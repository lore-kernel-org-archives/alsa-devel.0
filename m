From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 3/3] bebob: Correction for return value of .put
	callback
Date: Tue, 22 Jul 2014 23:13:56 +0900
Message-ID: <1406038436-18701-1-git-send-email-o-takashi@sakamocchi.jp>
References: <1406038263-18558-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id 1B13A265528
 for <alsa-devel@alsa-project.org>; Tue, 22 Jul 2014 16:14:04 +0200 (CEST)
In-Reply-To: <1406038263-18558-1-git-send-email-o-takashi@sakamocchi.jp>
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
Cc: alsa-devel@alsa-project.org, darrena092@gmail.com
List-Id: alsa-devel@alsa-project.org

This commit is for correction of my misunderstanding about return value of
.put callback in ALSA Control interface.

According to 'Writing ALSA Driver' (*1), return value of the callback has
three patterns; 1: changed, 0: not changed, an negative value: fatal error.

But I misunderstood that it's boolean; zero or nonzero.

*1: Writing an ALSA Driver (2005, Takashi Iwai)
http://www.alsa-project.org/main/index.php/ALSA_Driver_Documentation

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/bebob/bebob_maudio.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/sound/firewire/bebob/bebob_maudio.c b/sound/firewire/bebob/bebob_maudio.c
index 42e6f22..d6d6ff8 100644
--- a/sound/firewire/bebob/bebob_maudio.c
+++ b/sound/firewire/bebob/bebob_maudio.c
@@ -391,7 +391,10 @@ static int special_clk_ctl_put(struct snd_kcontrol *kctl,
 					 params->clk_lock);
 	mutex_unlock(&bebob->mutex);
 
-	return err >= 0;
+	if (err >= 0)
+		err = 1;
+
+	return err;
 }
 static struct snd_kcontrol_new special_clk_ctl = {
 	.name	= "Clock Source",
@@ -491,14 +494,16 @@ static int special_dig_in_iface_ctl_set(struct snd_kcontrol *kctl,
 	unsigned int id, dig_in_fmt, dig_in_iface;
 	int err;
 
-	mutex_lock(&bebob->mutex);
-
 	id = uval->value.enumerated.item[0];
+	if (id >= ARRAY_SIZE(special_dig_in_iface_labels))
+		return -EINVAL;
 
 	/* decode user value */
 	dig_in_fmt = (id >> 1) & 0x01;
 	dig_in_iface = id & 0x01;
 
+	mutex_lock(&bebob->mutex);
+
 	err = avc_maudio_set_special_clk(bebob,
 					 params->clk_src,
 					 dig_in_fmt,
@@ -508,14 +513,17 @@ static int special_dig_in_iface_ctl_set(struct snd_kcontrol *kctl,
 		goto end;
 
 	/* For ADAT, optical interface is only available. */
-	if (params->dig_in_fmt > 0)
+	if (params->dig_in_fmt > 0) {
+		err = 1;
 		goto end;
+	}
 
 	/* For S/PDIF, optical/coaxial interfaces are selectable. */
 	err = avc_audio_set_selector(bebob->unit, 0x00, 0x04, dig_in_iface);
 	if (err < 0)
 		dev_err(&bebob->unit->device,
 			"fail to set digital input interface: %d\n", err);
+	err = 1;
 end:
 	special_stream_formation_set(bebob);
 	mutex_unlock(&bebob->mutex);
@@ -567,16 +575,20 @@ static int special_dig_out_iface_ctl_set(struct snd_kcontrol *kctl,
 	unsigned int id;
 	int err;
 
-	mutex_lock(&bebob->mutex);
-
 	id = uval->value.enumerated.item[0];
+	if (id >= ARRAY_SIZE(special_dig_out_iface_labels))
+		return -EINVAL;
+
+	mutex_lock(&bebob->mutex);
 
 	err = avc_maudio_set_special_clk(bebob,
 					 params->clk_src,
 					 params->dig_in_fmt,
 					 id, params->clk_lock);
-	if (err >= 0)
+	if (err >= 0) {
 		special_stream_formation_set(bebob);
+		err = 1;
+	}
 
 	mutex_unlock(&bebob->mutex);
 	return err;
-- 
1.9.1
