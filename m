From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 12/15] ASoC: pxa: corgi: Update locking around use of DAPM pin API
Date: Mon, 17 Feb 2014 16:51:40 +0000
Message-ID: <1392655903-24537-13-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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
 sound/soc/pxa/corgi.c |   40 ++++++++++++++++++++++------------------
 1 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/sound/soc/pxa/corgi.c b/sound/soc/pxa/corgi.c
index 1853d41..d29cd0d 100644
--- a/sound/soc/pxa/corgi.c
+++ b/sound/soc/pxa/corgi.c
@@ -47,48 +47,52 @@ static int corgi_spk_func;
 
 static void corgi_ext_control(struct snd_soc_dapm_context *dapm)
 {
+	mutex_lock(&dapm->card->dapm_mutex);
+
 	/* set up jack connection */
 	switch (corgi_jack_func) {
 	case CORGI_HP:
 		/* set = unmute headphone */
 		gpio_set_value(CORGI_GPIO_MUTE_L, 1);
 		gpio_set_value(CORGI_GPIO_MUTE_R, 1);
-		snd_soc_dapm_disable_pin(dapm, "Mic Jack");
-		snd_soc_dapm_disable_pin(dapm, "Line Jack");
-		snd_soc_dapm_enable_pin(dapm, "Headphone Jack");
-		snd_soc_dapm_disable_pin(dapm, "Headset Jack");
+		snd_soc_dapm_disable_pin_locked(dapm, "Mic Jack");
+		snd_soc_dapm_disable_pin_locked(dapm, "Line Jack");
+		snd_soc_dapm_enable_pin_locked(dapm, "Headphone Jack");
+		snd_soc_dapm_disable_pin_locked(dapm, "Headset Jack");
 		break;
 	case CORGI_MIC:
 		/* reset = mute headphone */
 		gpio_set_value(CORGI_GPIO_MUTE_L, 0);
 		gpio_set_value(CORGI_GPIO_MUTE_R, 0);
-		snd_soc_dapm_enable_pin(dapm, "Mic Jack");
-		snd_soc_dapm_disable_pin(dapm, "Line Jack");
-		snd_soc_dapm_disable_pin(dapm, "Headphone Jack");
-		snd_soc_dapm_disable_pin(dapm, "Headset Jack");
+		snd_soc_dapm_enable_pin_locked(dapm, "Mic Jack");
+		snd_soc_dapm_disable_pin_locked(dapm, "Line Jack");
+		snd_soc_dapm_disable_pin_locked(dapm, "Headphone Jack");
+		snd_soc_dapm_disable_pin_locked(dapm, "Headset Jack");
 		break;
 	case CORGI_LINE:
 		gpio_set_value(CORGI_GPIO_MUTE_L, 0);
 		gpio_set_value(CORGI_GPIO_MUTE_R, 0);
-		snd_soc_dapm_disable_pin(dapm, "Mic Jack");
-		snd_soc_dapm_enable_pin(dapm, "Line Jack");
-		snd_soc_dapm_disable_pin(dapm, "Headphone Jack");
-		snd_soc_dapm_disable_pin(dapm, "Headset Jack");
+		snd_soc_dapm_disable_pin_locked(dapm, "Mic Jack");
+		snd_soc_dapm_enable_pin_locked(dapm, "Line Jack");
+		snd_soc_dapm_disable_pin_locked(dapm, "Headphone Jack");
+		snd_soc_dapm_disable_pin_locked(dapm, "Headset Jack");
 		break;
 	case CORGI_HEADSET:
 		gpio_set_value(CORGI_GPIO_MUTE_L, 0);
 		gpio_set_value(CORGI_GPIO_MUTE_R, 1);
-		snd_soc_dapm_enable_pin(dapm, "Mic Jack");
-		snd_soc_dapm_disable_pin(dapm, "Line Jack");
-		snd_soc_dapm_disable_pin(dapm, "Headphone Jack");
-		snd_soc_dapm_enable_pin(dapm, "Headset Jack");
+		snd_soc_dapm_enable_pin_locked(dapm, "Mic Jack");
+		snd_soc_dapm_disable_pin_locked(dapm, "Line Jack");
+		snd_soc_dapm_disable_pin_locked(dapm, "Headphone Jack");
+		snd_soc_dapm_enable_pin_locked(dapm, "Headset Jack");
 		break;
 	}
 
 	if (corgi_spk_func == CORGI_SPK_ON)
-		snd_soc_dapm_enable_pin(dapm, "Ext Spk");
+		snd_soc_dapm_enable_pin_locked(dapm, "Ext Spk");
 	else
-		snd_soc_dapm_disable_pin(dapm, "Ext Spk");
+		snd_soc_dapm_disable_pin_locked(dapm, "Ext Spk");
+
+	mutex_unlock(&dapm->card->dapm_mutex);
 
 	/* signal a DAPM event */
 	snd_soc_dapm_sync(dapm);
-- 
1.7.2.5
