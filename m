From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 18/39] firewire-lib: Add a fallback at
	RCODE_CANCELLED
Date: Fri, 28 Feb 2014 12:27:31 +0900
Message-ID: <1393558072-25926-19-git-send-email-o-takashi@sakamocchi.jp>
References: <1393558072-25926-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id EA7B3261A1A
 for <alsa-devel@alsa-project.org>; Fri, 28 Feb 2014 04:28:21 +0100 (CET)
In-Reply-To: <1393558072-25926-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

I confirm that some devices often send no response against driver's
request even if the devices handle the request. In this case, drivers
should not retry the request because it's not clear whether the devices
already handled an operation of the request or not. The second request
may bring errors or make no sence if the request was handled.

This patch adds a flag, FW_RETURN_TIMEOUT, for snd_fw_transaction().
With this flag, this function returns -ETIMEOUT when fw_run_transaction()
returns RCODE_CALCELLED.

For FCP, this patch modifies fcp_avc_transaction() with this flag. The
-ETIMEDOUT is handled as success. Linux Firewire Subsystem currently gives
200msec for default timeout (See DEFAULT_SPLIT_TIMEOUT in core-card.c).
firewire-lib gives 125msec for wait_event_timeout(). As a result, in worst
case that all of three retries are timeout and devices don't send responses,
fcp_avc_transaction() returns 1sec later ((200 + 125) msec * 3 times). But
this is rare.

For CMP, this patch modifies pcr_modify() with this flag. The -ETIMEOUT
generates another read transaction to check current value of PCR. If this
read transaction returns errors, then pcr_modify() returns the error code.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/cmp.c | 23 +++++++++++++++++++++--
 sound/firewire/fcp.c |  5 +++--
 sound/firewire/lib.c |  6 +++++-
 sound/firewire/lib.h |  1 +
 4 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/sound/firewire/cmp.c b/sound/firewire/cmp.c
index a8199fd..73f5f26 100644
--- a/sound/firewire/cmp.c
+++ b/sound/firewire/cmp.c
@@ -89,13 +89,32 @@ static int pcr_modify(struct cmp_connection *c,
 		err = snd_fw_transaction(
 				c->resources.unit, TCODE_LOCK_COMPARE_SWAP,
 				get_offset(c, false), buffer, 8,
-				FW_FIXED_GENERATION | c->resources.generation);
+				FW_FIXED_GENERATION | c->resources.generation |
+				FW_RETURN_TIMEOUT);
 
 		if (err < 0) {
 			if (err == -EAGAIN &&
 			    bus_reset_handling == SUCCEED_ON_BUS_RESET)
 				err = 0;
-			return err;
+
+			if (err != -ETIMEDOUT)
+				return err;
+
+			/* Check current PCR. */
+			err = snd_fw_transaction(
+				c->resources.unit, TCODE_READ_QUADLET_REQUEST,
+				get_offset(c, false), buffer, 4,
+				FW_FIXED_GENERATION | c->resources.generation);
+			if (err < 0)
+				return err;
+
+			/* The lock transaction may be failed, retry */
+			if (buffer[0] != buffer[1]) {
+				buffer[0] = c->last_pcr_value;
+				continue;
+			}
+
+			break;
 		}
 
 		if (buffer[0] == old_arg) /* success? */
diff --git a/sound/firewire/fcp.c b/sound/firewire/fcp.c
index e903ddb..6fc813f 100644
--- a/sound/firewire/fcp.c
+++ b/sound/firewire/fcp.c
@@ -245,8 +245,9 @@ int fcp_avc_transaction(struct fw_unit *unit,
 					  : TCODE_WRITE_BLOCK_REQUEST;
 		ret = snd_fw_transaction(t.unit, tcode,
 					 CSR_REGISTER_BASE + CSR_FCP_COMMAND,
-					 (void *)command, command_size, 0);
-		if (ret < 0)
+					 (void *)command, command_size,
+					 FW_RETURN_TIMEOUT);
+		if ((ret < 0) && (ret != -ETIMEDOUT))
 			break;
 
 		wait_event_timeout(t.wait, t.state != STATE_PENDING,
diff --git a/sound/firewire/lib.c b/sound/firewire/lib.c
index 7409edb..6c3278b 100644
--- a/sound/firewire/lib.c
+++ b/sound/firewire/lib.c
@@ -22,7 +22,7 @@
  * @length: length of @buffer
  * @flags: use %FW_FIXED_GENERATION and add the generation value to attempt the
  *         request only in that generation; use %FW_QUIET to suppress error
- *         messages
+ *         messages: use %FW_RETURN_TIMEOUT to avoid retry at RCODE_CANCELLED
  *
  * Submits an asynchronous request to the target device, and waits for the
  * response.  The node ID and the current generation are derived from @unit.
@@ -53,6 +53,10 @@ int snd_fw_transaction(struct fw_unit *unit, int tcode,
 		if (rcode == RCODE_GENERATION && (flags & FW_FIXED_GENERATION))
 			return -EAGAIN;
 
+		/* timeout */
+		if ((rcode == RCODE_CANCELLED) && (flags & FW_RETURN_TIMEOUT))
+			return -ETIMEDOUT;
+
 		if (rcode_is_permanent_error(rcode) || ++tries >= 3) {
 			if (!(flags & FW_QUIET))
 				dev_err(&unit->device,
diff --git a/sound/firewire/lib.h b/sound/firewire/lib.h
index 02cfabc..b8ea90b 100644
--- a/sound/firewire/lib.h
+++ b/sound/firewire/lib.h
@@ -9,6 +9,7 @@ struct fw_unit;
 #define FW_GENERATION_MASK	0x00ff
 #define FW_FIXED_GENERATION	0x0100
 #define FW_QUIET		0x0200
+#define FW_RETURN_TIMEOUT	0x0400
 
 int snd_fw_transaction(struct fw_unit *unit, int tcode,
 		       u64 offset, void *buffer, size_t length,
-- 
1.8.3.2
