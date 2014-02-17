From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 05/15] ASoC: wm8962: Update locking around use
	of DAPM pin API
Date: Mon, 17 Feb 2014 16:51:33 +0000
Message-ID: <1392655903-24537-6-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1392655903-24537-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 472BA264EED
 for <alsa-devel@alsa-project.org>; Mon, 17 Feb 2014 18:00:06 +0100 (CET)
In-Reply-To: <1392655903-24537-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, eric.y.miao@gmail.com, dmitry.torokhov@gmail.com, lgirdwood@gmail.com, haojian.zhuang@gmail.com, linux-kernel@vger.kernel.org, peter.ujfalusi@ti.com, cw00.choi@samsung.com, myungjoo.ham@samsung.com, patches@opensource.wolfsonmicro.com, linux@arm.linux.org.uk, jarkko.nikula@bitmer.com
List-Id: alsa-devel@alsa-project.org

The pin updates in this driver look like they are intended to be done
atomically, update to do so.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8962.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index c06bb50..535a7dc 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -3126,14 +3126,18 @@ int wm8962_mic_detect(struct snd_soc_codec *codec, struct snd_soc_jack *jack)
 	snd_soc_jack_report(wm8962->jack, 0,
 			    SND_JACK_MICROPHONE | SND_JACK_BTN_0);
 
+	mutex_lock(&codec->dapm.card->dapm_mutex);
+
 	if (jack) {
-		snd_soc_dapm_force_enable_pin(&codec->dapm, "SYSCLK");
-		snd_soc_dapm_force_enable_pin(&codec->dapm, "MICBIAS");
+		snd_soc_dapm_force_enable_pin_locked(&codec->dapm, "SYSCLK");
+		snd_soc_dapm_force_enable_pin_locked(&codec->dapm, "MICBIAS");
 	} else {
-		snd_soc_dapm_disable_pin(&codec->dapm, "SYSCLK");
-		snd_soc_dapm_disable_pin(&codec->dapm, "MICBIAS");
+		snd_soc_dapm_disable_pin_locked(&codec->dapm, "SYSCLK");
+		snd_soc_dapm_disable_pin_locked(&codec->dapm, "MICBIAS");
 	}
 
+	mutex_unlock(&codec->dapm.card->dapm_mutex);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(wm8962_mic_detect);
-- 
1.7.2.5
