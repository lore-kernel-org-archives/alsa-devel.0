From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 52/52] bebob: Add support for M-Audio special Firewire
	series
Date: Wed, 26 Feb 2014 18:53:39 +0900
Message-ID: <530DB9A3.1020403@sakamocchi.jp>
References: <1391003099-7109-1-git-send-email-o-takashi@sakamocchi.jp>
	<1391006977-11572-3-git-send-email-o-takashi@sakamocchi.jp>
	<530CA27D.2000306@sakamocchi.jp> <530CF745.40309@ladisch.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080303000507080109000709"
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <530CF745.40309@ladisch.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------080303000507080109000709
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Clemens,

Thanks for your quick reply.

 > Maybe we should change how these functions handle timeouts.  Any other
> error code indicates that the lock transaction failed definitely, but
> after a timeout, we don't know if it was the request or the response
> that got lost.
>
> We could try to read the register, and, if we see that the change that we
> tried to do actually happend, assume that our driver's transaction did
> this change.

How is attached patch for this idea?

> Are read transactions more reliable than locks?  If not, we might need
> to increase the number of retries for these devices.

This quirk is applied for all of transactions to these devices. As long 
as I expeciment, their reliability roughly the same.

As long as I tested with this patch, the current number of retries (3 
times) seemd to be enough for these devices. ALSA applications can 
safely use PCM character devices.

> This patch (no. 52) does not change the CMP code.

I had no plan to touch CMP codes for this patch because just two models 
have this quirk. But now I want to add this patch into my series of patch.


Thanks

Takashi Sakamoto
o-takashi@sakamocchi.jp


--------------080303000507080109000709
Content-Type: text/x-patch;
	name="0001-firewire-lib-add-a-fallback-at-RCODE_CANCELLED.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0001-firewire-lib-add-a-fallback-at-RCODE_CANCELLED.patch"

>From e2a4091de645dddc116fe194b71ab20117a4f377 Mon Sep 17 00:00:00 2001
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Date: Wed, 26 Feb 2014 13:42:32 +0900
Subject: [PATCH] firewire-lib: add a fallback at RCODE_CANCELLED

I confirm that some devices often send no response against driver's
request even if the devices handle the request. In this case, drivers
should not retry the request because the devices already handled
an operation of the request.  The second request may bring errors or
make no sence.

This patch adds a flag, FW_RETURN_TIMEOUT, for snd_fw_transaction().
With this flag, this function returns -ETIMEOUT when fw_run_transaction()
returns RCODE_CALCELLED.,

For FCP, this patch modifies fcp_avc_transaction() with this flag. The
-ETIMEDOUT is handled as success.

For CMP, this patch modifies pcr_modify() with this flag. The -ETIMEOUT
generates another read transaction to check current value of PCR.
---
 sound/firewire/cmp.c | 23 +++++++++++++++++++++--
 sound/firewire/fcp.c |  5 +++--
 sound/firewire/lib.c |  6 +++++-
 sound/firewire/lib.h |  1 +
 4 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/sound/firewire/cmp.c b/sound/firewire/cmp.c
index efdbf58..1fc332a 100644
--- a/sound/firewire/cmp.c
+++ b/sound/firewire/cmp.c
@@ -60,13 +60,32 @@ static int pcr_modify(struct cmp_connection *c,
 				c->resources.unit, TCODE_LOCK_COMPARE_SWAP,
 				CSR_REGISTER_BASE + CSR_IPCR(c->pcr_index),
 				buffer, 8,
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
+				CSR_REGISTER_BASE + CSR_IPCR(c->pcr_index),
+				buffer, 4,
+				FW_FIXED_GENERATION | c->resources.generation);
+			if (err < 0)
+				return err;
+
+			/* The lock transaction may be failed, retry */
+			if (buffer[0] != buffer[1]) {
+				buffer[0] = c->last_pcr_value;
+				continue;
+			}
+			break;
 		}
 
 		if (buffer[0] == old_arg) /* success? */
diff --git a/sound/firewire/fcp.c b/sound/firewire/fcp.c
index 860c080..5bb1cdf 100644
--- a/sound/firewire/fcp.c
+++ b/sound/firewire/fcp.c
@@ -90,8 +90,9 @@ int fcp_avc_transaction(struct fw_unit *unit,
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


--------------080303000507080109000709
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Flow-based real-time traffic analytics software. Cisco certified tool.
Monitor traffic, SLAs, QoS, Medianet, WAAS etc. with NetFlow Analyzer
Customize your own dashboards, set traffic alerts and generate reports.
Network behavioral analysis & security monitoring. All-in-one tool.
http://pubads.g.doubleclick.net/gampad/clk?id=126839071&iu=/4140/ostg.clktrk
--------------080303000507080109000709
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------080303000507080109000709--
