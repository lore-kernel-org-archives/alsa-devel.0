From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [RFC] [PATCH] firewire-lib: add support for AV/C deferred transaction
Date: Fri, 14 Mar 2014 23:41:33 +0900
Message-ID: <5323151D.3010706@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070209040204000803020402"
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: Clemens Ladisch <clemens@ladisch.de>, Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, linux1394-devel@lists.sourceforge.net, "ffado-devel@lists.sf.net" <ffado-devel@lists.sf.net>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------070209040204000803020402
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

Clemens and Stefan,

Can I request your comments about attached patch?

This is for adding support of deferred transaction into
snd-firewire-lib. I confirm some BeBoB devices use this type of
transaction. If you have no negative comments, I'll add this patch for
my series.

For 'undefined interval' between INTERIM and final response, I want to
use 'FCP_TIMEOUT_MS' (=125msec) again. In specifications which I can
read, there is no limit for this interval. But I need to promise to
finish this function for callers.

According to AV/C general specification, targets can send INTERIM
response one time. But this patch allows to accept several ITERIM
responses for device quirks. I don't have devices which have such
quirks, but there may be such devices and I want to make codes simpler.


Regards

Takashi Sakamoto
o-takashi@sakamocchi.jp

--------------070209040204000803020402
Content-Type: text/x-patch;
	name="0001-firewire-lib-Add-support-for-deferred-transaction.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0001-firewire-lib-Add-support-for-deferred-transaction.patch"

>From 87b73cc7f5aa389101b362f21ddeb0f1a4cbe984 Mon Sep 17 00:00:00 2001
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Date: Fri, 14 Mar 2014 13:17:43 +0900
Subject: [PATCH] firewire-lib: Add support for deferred transaction

Some devices based on BeBoB use this type of transaction.

'Deferred Transaction' is defined in 'AV/C Digital Interface Command Set
General Specification' and is used by targets to make a response deferred
during processing it.

If a target may not be able to complete a command within 100msec since
receiving the command, then the target shall return INTERIM response,
to which final response will follow later. CONTROL/NOTIFY commands are
allowed for deferred transaction.

There is an issue. In the specification, the interval between INTERIM
response and final response is 'Unspecified interval'. The specification
depends on each subunit specification for this interval.

But we promise to finish this function for caller. In this reason, I use
FCP_TIMEOUT_MS for this interval. Currently it's 125msec.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/fcp.c | 38 ++++++++++++++++++++++++++++++--------
 1 file changed, 30 insertions(+), 8 deletions(-)

diff --git a/sound/firewire/fcp.c b/sound/firewire/fcp.c
index 860c080..56d03fc 100644
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
@@ -93,17 +98,28 @@ int fcp_avc_transaction(struct fw_unit *unit,
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
 			msleep(ERROR_DELAY_MS);
 		} else if (++tries >= ERROR_RETRIES) {
-			dev_err(&t.unit->device, "FCP command timed out\n");
+			dev_err(&t.unit->device,
+				"FCP command timed out\n");
 			ret = -EIO;
 			break;
 		}
@@ -132,7 +148,8 @@ void fcp_bus_reset(struct fw_unit *unit)
 	spin_lock_irq(&transactions_lock);
 	list_for_each_entry(t, &transactions, list) {
 		if (t->unit == unit &&
-		    t->state == STATE_PENDING) {
+		    (t->state == STATE_PENDING ||
+		     t->state == STATE_DEFERRED)) {
 			t->state = STATE_BUS_RESET;
 			wake_up(&t->wait);
 		}
@@ -186,10 +203,15 @@ static void fcp_response(struct fw_card *card, struct fw_request *request,
 
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
+				t->response_size = min((unsigned int)length,
+						       t->response_size);
+				memcpy(t->response_buffer, data,
+				       t->response_size);
+			}
 			wake_up(&t->wait);
 		}
 	}
-- 
1.8.3.2


--------------070209040204000803020402
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/13534_NeoTech
--------------070209040204000803020402
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------070209040204000803020402--
