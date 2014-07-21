From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 6/6] bebob: Arrangement for a control element
	to which two settings relate
Date: Mon, 21 Jul 2014 11:10:05 +0900
Message-ID: <1405908605-8105-7-git-send-email-o-takashi@sakamocchi.jp>
References: <1405831835-26499-1-git-send-email-weiyj_lk@163.com>
 <1405908605-8105-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id D5A85265109
 for <alsa-devel@alsa-project.org>; Mon, 21 Jul 2014 04:10:20 +0200 (CEST)
In-Reply-To: <1405908605-8105-1-git-send-email-o-takashi@sakamocchi.jp>
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
Cc: alsa-devel@alsa-project.org, darrena092@gmail.com, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

A control element for digital input interface includes two settings; one
is for digital format (S/PDIF or ADAT), another is for interface (optical or
coaxial).

The setting for interface is meaningful just for S/PDIF, therefore to consider
recovery at failure of a operation for the second setting, a operation for
the first setting should be for interface, not digital format.

Additionally, this commit changes special_dig_in_iface_ctl_get() to reduce
needless processing for the interface when the digital format is ADAT.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/bebob/bebob_maudio.c | 70 +++++++++++++++++++++----------------
 1 file changed, 40 insertions(+), 30 deletions(-)

diff --git a/sound/firewire/bebob/bebob_maudio.c b/sound/firewire/bebob/bebob_maudio.c
index acfe94a..7899b56 100644
--- a/sound/firewire/bebob/bebob_maudio.c
+++ b/sound/firewire/bebob/bebob_maudio.c
@@ -471,21 +471,24 @@ static int special_dig_in_iface_ctl_get(struct snd_kcontrol *kctl,
 
 	mutex_lock(&bebob->mutex);
 
-	err = avc_audio_get_selector(bebob->unit, 0x00, 0x04,
-				     &dig_in_iface);
-	if (err < 0) {
-		dev_err(&bebob->unit->device,
-			"fail to get digital input interface: %d\n", err);
-		goto end;
+	/* For ADAT, optical interface is only available. */
+	if (params->dig_in_fmt > 0) {
+		err = 0;
+		dig_in_iface = 0;
+	} else {
+		err = avc_audio_get_selector(bebob->unit, 0x00, 0x04,
+					     &dig_in_iface);
+		if (err < 0) {
+			dev_err(&bebob->unit->device,
+				"fail to get digital input interface: %d\n",
+				err);
+			goto end;
+		}
 	}
 
 	/* encoded id for user value */
 	val = (params->dig_in_fmt << 1) | (dig_in_iface & 0x01);
 
-	/* for ADAT Optical */
-	if (val > 2)
-		val = 2;
-
 	uval->value.enumerated.item[0] = val;
 end:
 	mutex_unlock(&bebob->mutex);
@@ -497,7 +500,7 @@ static int special_dig_in_iface_ctl_set(struct snd_kcontrol *kctl,
 	struct snd_bebob *bebob = snd_kcontrol_chip(kctl);
 	struct special_params *params = bebob->maudio_special_quirk;
 	unsigned int id, dig_in_fmt, dig_in_iface;
-	int err;
+	int err = 0;
 
 	id = uval->value.enumerated.item[0];
 	if (id >= ARRAY_SIZE(special_dig_in_iface_labels))
@@ -509,29 +512,36 @@ static int special_dig_in_iface_ctl_set(struct snd_kcontrol *kctl,
 
 	mutex_lock(&bebob->mutex);
 
-	err = avc_maudio_set_special_clk(bebob,
-					 params->clk_src,
-					 dig_in_fmt,
-					 params->dig_out_fmt,
-					 params->clk_lock);
-	if (err < 0) {
-		dev_err(&bebob->unit->device,
-			"fail to change clock source: %d\n", err);
-		goto end;
-	}
-
-	/* For ADAT, optical interface is only available. */
-	if (params->dig_in_fmt > 0) {
+	/* For S/PDIF, optical/coaxial interfaces are selectable. */
+	if (dig_in_fmt == 0) {
+		if (amdtp_stream_running(&bebob->rx_stream))
+			goto end;
+
+		err = avc_audio_set_selector(bebob->unit, 0x00, 0x04,
+					     dig_in_iface);
+		if (err < 0) {
+			dev_err(&bebob->unit->device,
+				"fail to change digital input interface: %d\n",
+				err);
+			goto end;
+		}
 		err = 1;
-		goto end;
 	}
 
-	err = avc_audio_set_selector(bebob->unit, 0x00, 0x04, dig_in_iface);
-	if (err < 0)
-		dev_err(&bebob->unit->device,
-			"fail to set digital input interface: %d\n", err);
-	else
+	if (params->dig_in_fmt != dig_in_fmt) {
+		err = avc_maudio_set_special_clk(bebob,
+						 params->clk_src,
+						 dig_in_fmt,
+						 params->dig_out_fmt,
+						 params->clk_lock);
+		if (err < 0) {
+			dev_err(&bebob->unit->device,
+				"fail to change digital input format: %d\n",
+				err);
+			goto end;
+		}
 		err = 1;
+	}
 end:
 	mutex_unlock(&bebob->mutex);
 	return err;
-- 
1.9.1
