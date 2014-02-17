From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 10/15] ASoC: omap: n810: Update locking around use of DAPM pin API
Date: Mon, 17 Feb 2014 16:51:38 +0000
Message-ID: <1392655903-24537-11-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1392655903-24537-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1392655903-24537-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: myungjoo.ham@samsung.com, cw00.choi@samsung.com, dmitry.torokhov@gmail.com, lgirdwood@gmail.com, lars@metafoo.de, peter.ujfalusi@ti.com, jarkko.nikula@bitmer.com, eric.y.miao@gmail.com, haojian.zhuang@gmail.com, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux@arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

The pin updates in this driver look like they are intended to be done
atomically, update to do so.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/omap/n810.c |   20 ++++++++++++--------
 1 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/sound/soc/omap/n810.c b/sound/soc/omap/n810.c
index 3fde9e4..b3f59a5 100644
--- a/sound/soc/omap/n810.c
+++ b/sound/soc/omap/n810.c
@@ -68,24 +68,28 @@ static void n810_ext_control(struct snd_soc_dapm_context *dapm)
 		break;
 	}
 
+	mutex_lock(&dapm->card->dapm_mutex);
+
 	if (n810_spk_func)
-		snd_soc_dapm_enable_pin(dapm, "Ext Spk");
+		snd_soc_dapm_enable_pin_locked(dapm, "Ext Spk");
 	else
-		snd_soc_dapm_disable_pin(dapm, "Ext Spk");
+		snd_soc_dapm_disable_pin_locked(dapm, "Ext Spk");
 
 	if (hp)
-		snd_soc_dapm_enable_pin(dapm, "Headphone Jack");
+		snd_soc_dapm_enable_pin_locked(dapm, "Headphone Jack");
 	else
-		snd_soc_dapm_disable_pin(dapm, "Headphone Jack");
+		snd_soc_dapm_disable_pin_locked(dapm, "Headphone Jack");
 	if (line1l)
-		snd_soc_dapm_enable_pin(dapm, "LINE1L");
+		snd_soc_dapm_enable_pin_locked(dapm, "LINE1L");
 	else
-		snd_soc_dapm_disable_pin(dapm, "LINE1L");
+		snd_soc_dapm_disable_pin_locked(dapm, "LINE1L");
 
 	if (n810_dmic_func)
-		snd_soc_dapm_enable_pin(dapm, "DMic");
+		snd_soc_dapm_enable_pin_locked(dapm, "DMic");
 	else
-		snd_soc_dapm_disable_pin(dapm, "DMic");
+		snd_soc_dapm_disable_pin_locked(dapm, "DMic");
+
+	mutex_unlock(&dapm->card->dapm_mutex);
 
 	snd_soc_dapm_sync(dapm);
 }
-- 
1.7.2.5
