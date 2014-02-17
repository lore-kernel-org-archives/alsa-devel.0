From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 11/15] ASoC: omap: rx51: Update locking around use of DAPM pin API
Date: Mon, 17 Feb 2014 16:51:39 +0000
Message-ID: <1392655903-24537-12-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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
 sound/soc/omap/rx51.c |   20 ++++++++++++--------
 1 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/sound/soc/omap/rx51.c b/sound/soc/omap/rx51.c
index 611179c..51f1ae6 100644
--- a/sound/soc/omap/rx51.c
+++ b/sound/soc/omap/rx51.c
@@ -74,22 +74,26 @@ static void rx51_ext_control(struct snd_soc_dapm_context *dapm)
 		break;
 	}
 
+	mutex_lock(&dapm->card->dapm_mutex);
+
 	if (rx51_spk_func)
-		snd_soc_dapm_enable_pin(dapm, "Ext Spk");
+		snd_soc_dapm_enable_pin_locked(dapm, "Ext Spk");
 	else
-		snd_soc_dapm_disable_pin(dapm, "Ext Spk");
+		snd_soc_dapm_disable_pin_locked(dapm, "Ext Spk");
 	if (rx51_dmic_func)
-		snd_soc_dapm_enable_pin(dapm, "DMic");
+		snd_soc_dapm_enable_pin_locked(dapm, "DMic");
 	else
-		snd_soc_dapm_disable_pin(dapm, "DMic");
+		snd_soc_dapm_disable_pin_locked(dapm, "DMic");
 	if (hp)
-		snd_soc_dapm_enable_pin(dapm, "Headphone Jack");
+		snd_soc_dapm_enable_pin_locked(dapm, "Headphone Jack");
 	else
-		snd_soc_dapm_disable_pin(dapm, "Headphone Jack");
+		snd_soc_dapm_disable_pin_locked(dapm, "Headphone Jack");
 	if (hs)
-		snd_soc_dapm_enable_pin(dapm, "HS Mic");
+		snd_soc_dapm_enable_pin_locked(dapm, "HS Mic");
 	else
-		snd_soc_dapm_disable_pin(dapm, "HS Mic");
+		snd_soc_dapm_disable_pin_locked(dapm, "HS Mic");
+
+	mutex_unlock(&dapm->card->dapm_mutex);
 
 	gpio_set_value(RX51_TVOUT_SEL_GPIO, tvout);
 
-- 
1.7.2.5
