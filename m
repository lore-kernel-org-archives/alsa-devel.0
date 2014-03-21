From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 14/44] firewire-lib: Add support for deferred transaction
Date: Fri, 21 Mar 2014 20:09:59 +0900
Message-ID: <1395400229-22957-15-git-send-email-o-takashi@sakamocchi.jp>
References: <1395400229-22957-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1395400229-22957-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: clemens@ladisch.de, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Some devices based on BeBoB use this type of AV/C transaction.

'Deferred Transaction' is defined in 'AV/C Digital Interface Command Set
General Specification' and is used by targets to make a response deferred
during processing it.

If a target may not be able to complete a command within 100msec since
receiving the command, then the target shall return INTERIM response,
to which final response will follow later. CONTROL/NOTIFY commands are
allowed for deferred transaction.

In the specification, devices allow to send INTERIM response just one time.
But this commit allows to handle several INTERIM response with two reasons.
One reason is to simplify codes, and another reason is to prepare for
devices which is out of specification.

There is an issue. In the specification, the interval between INTERIM
response and final response is 'Unspecified interval'. The specification
depends on each subunit specification for this interval.

But we promise to finish this function for caller. In this reason, I use
FCP_TIMEOUT_MS for this interval. Currently it's 125msec. When we find
devices which needs more time for this interval, then let us add some codes
to apply more interval for 'undefined interval'.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/fcp.c | 35 ++++++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)

diff --git a/sound/firewire/fcp.c b/sound/firewire/fcp.c
index 860c080..6876bfa 100644
--- a/sound/firewire/fcp.c
+++ b/sound/firewire/fcp.c
@@ -30,6 +30,7 @@ enum fcp_state {
 	STATE_PENDING,
 	STATE_BUS_RESET,
 	STATE_COMPLETE,
+	STATE_DEFERRED,
 };
 
 struct fcp_transaction {
@@ -40,6 +41,7 @@ struct fcp_transaction {
 	unsigned int response_match_bytes;
 	enum fcp_state state;
 	wait_queue_head_t wait;
+	bool deferrable;
 };
 
 /**
@@ -81,6 +83,9 @@ int fcp_avc_transaction(struct fw_unit *unit,
 	t.state = STATE_PENDING;
 	init_waitqueue_head(&t.wait);
 
+	if (*(const u8 *)command == 0x00 || *(const u8 *)command == 0x03)
+		t.deferrable = true;
+
 	spin_lock_irq(&transactions_lock);
 	list_add_tail(&t.list, &transactions);
 	spin_unlock_irq(&transactions_lock);
@@ -93,11 +98,21 @@ int fcp_avc_transaction(struct fw_unit *unit,
 					 (void *)command, command_size, 0);
 		if (ret < 0)
 			break;
-
+deferred:
 		wait_event_timeout(t.wait, t.state != STATE_PENDING,
 				   msecs_to_jiffies(FCP_TIMEOUT_MS));
 
-		if (t.state == STATE_COMPLETE) {
+		if (t.state == STATE_DEFERRED) {
+			/*
+			 * 'AV/C General Specification' define no time limit
+			 * on command completion once an INTERIM response has
+			 * been sent. but we promise to finish this function
+			 * for a caller. Here we use FCP_TIMEOUT_MS for next
+			 * interval. This is not in the specification.
+			 */
+			t.state = STATE_PENDING;
+			goto deferred;
+		} else if (t.state == STATE_COMPLETE) {
 			ret = t.response_size;
 			break;
 		} else if (t.state == STATE_BUS_RESET) {
@@ -132,7 +147,8 @@ void fcp_bus_reset(struct fw_unit *unit)
 	spin_lock_irq(&transactions_lock);
 	list_for_each_entry(t, &transactions, list) {
 		if (t->unit == unit &&
-		    t->state == STATE_PENDING) {
+		    (t->state == STATE_PENDING ||
+		     t->state == STATE_DEFERRED)) {
 			t->state = STATE_BUS_RESET;
 			wake_up(&t->wait);
 		}
@@ -186,10 +202,15 @@ static void fcp_response(struct fw_card *card, struct fw_request *request,
 
 		if (t->state == STATE_PENDING &&
 		    is_matching_response(t, data, length)) {
-			t->state = STATE_COMPLETE;
-			t->response_size = min((unsigned int)length,
-					       t->response_size);
-			memcpy(t->response_buffer, data, t->response_size);
+			if (t->deferrable && *(const u8 *)data == 0x0f) {
+				t->state = STATE_DEFERRED;
+			} else {
+				t->state = STATE_COMPLETE;
+				t->response_size = min_t(unsigned int, length,
+							 t->response_size);
+				memcpy(t->response_buffer, data,
+				       t->response_size);
+			}
 			wake_up(&t->wait);
 		}
 	}
-- 
1.8.3.2


------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/13534_NeoTech
