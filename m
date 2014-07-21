From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 5/6] bebob: Correction for return value of .put
	callback functions
Date: Mon, 21 Jul 2014 11:10:04 +0900
Message-ID: <1405908605-8105-6-git-send-email-o-takashi@sakamocchi.jp>
References: <1405831835-26499-1-git-send-email-weiyj_lk@163.com>
 <1405908605-8105-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id F10742650FF
 for <alsa-devel@alsa-project.org>; Mon, 21 Jul 2014 04:10:18 +0200 (CEST)
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

This commit is for correction of my misunderstanding for return value of
.put callback of ALSA Control interface.

According to 'Writing ALSA Driver' (*1), return value of the callback has
three patterns; 1: changed, 0: not changed, an negative value: fatal error.

But I misunderstood that it's boolean; zero or nonzero.

*1: Writing an ALSA Driver (2005, Takashi Iwai)
http://www.alsa-project.org/main/index.php/ALSA_Driver_Documentation

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/bebob/bebob_maudio.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/sound/firewire/bebob/bebob_maudio.c b/sound/firewire/bebob/bebob_maudio.c
index f2277ce..acfe94a 100644
--- a/sound/firewire/bebob/bebob_maudio.c
+++ b/sound/firewire/bebob/bebob_maudio.c
@@ -396,8 +396,10 @@ static int special_clk_ctl_set(struct snd_kcontrol *kctl,
 	if (err < 0)
 		dev_err(&bebob->unit->device,
 			"fail to change clock source: %d\n", err);
+	else
+		err = 1;
 
-	return err >= 0;
+	return err;
 }
 static struct snd_kcontrol_new special_clk_ctl = {
 	.name	= "Clock Source",
@@ -519,13 +521,17 @@ static int special_dig_in_iface_ctl_set(struct snd_kcontrol *kctl,
 	}
 
 	/* For ADAT, optical interface is only available. */
-	if (params->dig_in_fmt > 0)
+	if (params->dig_in_fmt > 0) {
+		err = 1;
 		goto end;
+	}
 
 	err = avc_audio_set_selector(bebob->unit, 0x00, 0x04, dig_in_iface);
 	if (err < 0)
 		dev_err(&bebob->unit->device,
 			"fail to set digital input interface: %d\n", err);
+	else
+		err = 1;
 end:
 	mutex_unlock(&bebob->mutex);
 	return err;
@@ -592,6 +598,8 @@ static int special_dig_out_iface_ctl_set(struct snd_kcontrol *kctl,
 	if (err < 0)
 		dev_err(&bebob->unit->device,
 			"fail to change digital output interface: %d\n", err);
+	else
+		err = 1;
 
 	return err;
 }
-- 
1.9.1
