From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH] ALSA: dice: ensure transmission speed for
	transmitted packets
Date: Tue,  3 Jan 2017 12:44:43 +0900
Message-ID: <20170103034443.25095-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 7D9A4266C94
 for <alsa-devel@alsa-project.org>; Tue,  3 Jan 2017 04:44:51 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

As of kernel 4.10, ALSA dice driver is expected to be used in default
speed. In most cases, it's S400. While, IEEE 1394 specification describes
the other speed such as S800.

According to 'TCD30XX User Guide', its link layer controller supports
several transmission speed up to S800[0]. In Dice software interface,
transmission speed in output direction can be configured by asynchronous
transaction to 'TX_SPEED' offset in its address space. S800 may be
available.

This commit improves configuration of transmission unit before starting
packet streaming for this purpose. The value of 'max_speed' in 'fw_device'
data structure has available maximum speed decided in bus arbitration,
thus it's within capacity of the unit.

[0] TCD3xx User Guide - TCAT 1394 LLC, Revision 0.9.0-41360 (TC Applied Technologies, May 6 2015)
http://www.tctechnologies.tc/index.php/support/support-hardware/dice-iii-detailed-documentation

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/dice/dice-interface.h |  1 +
 sound/firewire/dice/dice-stream.c    | 12 +++++++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/sound/firewire/dice/dice-interface.h b/sound/firewire/dice/dice-interface.h
index 27b044f..47f2c0a 100644
--- a/sound/firewire/dice/dice-interface.h
+++ b/sound/firewire/dice/dice-interface.h
@@ -251,6 +251,7 @@
 
 /*
  * The speed at which the packets are sent, SCODE_100-_400; read/write.
+ * SCODE_800 is only available in Dice III.
  */
 #define TX_SPEED			0x014
 
diff --git a/sound/firewire/dice/dice-stream.c b/sound/firewire/dice/dice-stream.c
index ec4db3a..8573289 100644
--- a/sound/firewire/dice/dice-stream.c
+++ b/sound/firewire/dice/dice-stream.c
@@ -195,6 +195,7 @@ static int start_streams(struct snd_dice *dice, enum amdtp_stream_direction dir,
 	unsigned int i, pcm_chs, midi_ports;
 	struct amdtp_stream *streams;
 	struct fw_iso_resources *resources;
+	struct fw_device *fw_dev = fw_parent_device(dice->unit);
 	int err = 0;
 
 	if (dir == AMDTP_IN_STREAM) {
@@ -237,8 +238,17 @@ static int start_streams(struct snd_dice *dice, enum amdtp_stream_direction dir,
 		if (err < 0)
 			return err;
 
+		if (dir == AMDTP_IN_STREAM) {
+			reg[0] = cpu_to_be32(fw_dev->max_speed);
+			err = snd_dice_transaction_write_tx(dice,
+					params->size * i + TX_SPEED,
+					reg, sizeof(reg[0]));
+			if (err < 0)
+				return err;
+		}
+
 		err = amdtp_stream_start(&streams[i], resources[i].channel,
-				fw_parent_device(dice->unit)->max_speed);
+					 fw_dev->max_speed);
 		if (err < 0)
 			return err;
 	}
-- 
2.9.3
