From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 15/17 v2] ASoC: pxa: magician: Update locking around use of DAPM pin API
Date: Tue, 18 Feb 2014 15:22:26 +0000
Message-ID: <1392736948-26623-16-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1392736948-26623-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1392736948-26623-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: myungjoo.ham@samsung.com, cw00.choi@samsung.com, dmitry.torokhov@gmail.com, lgirdwood@gmail.com, lars@metafoo.de, peter.ujfalusi@ti.com, jarkko.nikula@bitmer.com, eric.y.miao@gmail.com, haojian.zhuang@gmail.com, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux@arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

The pin updates in this driver look like they are intended to be done
atomically, update to do so.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/pxa/magician.c |   22 +++++++++++++---------
 1 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/sound/soc/pxa/magician.c b/sound/soc/pxa/magician.c
index aace19e..31242be 100644
--- a/sound/soc/pxa/magician.c
+++ b/sound/soc/pxa/magician.c
@@ -45,27 +45,31 @@ static void magician_ext_control(struct snd_soc_codec *codec)
 {
 	struct snd_soc_dapm_context *dapm = &codec->dapm;
 
+	snd_soc_dapm_mutex_lock(dapm);
+
 	if (magician_spk_switch)
-		snd_soc_dapm_enable_pin(dapm, "Speaker");
+		snd_soc_dapm_enable_pin_unlocked(dapm, "Speaker");
 	else
-		snd_soc_dapm_disable_pin(dapm, "Speaker");
+		snd_soc_dapm_disable_pin_unlocked(dapm, "Speaker");
 	if (magician_hp_switch)
-		snd_soc_dapm_enable_pin(dapm, "Headphone Jack");
+		snd_soc_dapm_enable_pin_unlocked(dapm, "Headphone Jack");
 	else
-		snd_soc_dapm_disable_pin(dapm, "Headphone Jack");
+		snd_soc_dapm_disable_pin_unlocked(dapm, "Headphone Jack");
 
 	switch (magician_in_sel) {
 	case MAGICIAN_MIC:
-		snd_soc_dapm_disable_pin(dapm, "Headset Mic");
-		snd_soc_dapm_enable_pin(dapm, "Call Mic");
+		snd_soc_dapm_disable_pin_unlocked(dapm, "Headset Mic");
+		snd_soc_dapm_enable_pin_unlocked(dapm, "Call Mic");
 		break;
 	case MAGICIAN_MIC_EXT:
-		snd_soc_dapm_disable_pin(dapm, "Call Mic");
-		snd_soc_dapm_enable_pin(dapm, "Headset Mic");
+		snd_soc_dapm_disable_pin_unlocked(dapm, "Call Mic");
+		snd_soc_dapm_enable_pin_unlocked(dapm, "Headset Mic");
 		break;
 	}
 
-	snd_soc_dapm_sync(dapm);
+	snd_soc_dapm_sync_unlocked(dapm);
+
+	snd_soc_dapm_mutex_unlock(dapm);
 }
 
 static int magician_startup(struct snd_pcm_substream *substream)
-- 
1.7.2.5
