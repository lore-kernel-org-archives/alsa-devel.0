From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 3/6] ASoC: Report errors when we have a WM8962
	IRQ and don't get FLL lock
Date: Wed,  8 Jun 2011 14:50:52 +0100
Message-ID: <1307541055-10150-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1307541055-10150-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1760F103928
	for <alsa-devel@alsa-project.org>;
	Wed,  8 Jun 2011 15:51:03 +0200 (CEST)
In-Reply-To: <1307541055-10150-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

We really should be getting the interrupt - if we don't get one it's very
likely that the configuration is incorrect and audio will fail. Also
increase the timeout substantially in this case for safety.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8962.c |   37 ++++++++++++++++++++++++++++++++-----
 1 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index a159453..859e699 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -2186,6 +2186,8 @@ static int sysclk_event(struct snd_soc_dapm_widget *w,
 			struct snd_kcontrol *kcontrol, int event)
 {
 	struct snd_soc_codec *codec = w->codec;
+	struct wm8962_priv *wm8962 = snd_soc_codec_get_drvdata(codec);
+	unsigned long timeout;
 	int src;
 	int fll;
 
@@ -2205,9 +2207,19 @@ static int sysclk_event(struct snd_soc_dapm_widget *w,
 
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
-		if (fll)
+		if (fll) {
 			snd_soc_update_bits(codec, WM8962_FLL_CONTROL_1,
 					    WM8962_FLL_ENA, WM8962_FLL_ENA);
+			if (wm8962->irq) {
+				timeout = msecs_to_jiffies(5);
+				timeout = wait_for_completion_timeout(&wm8962->fll_lock,
+								      timeout);
+
+				if (timeout == 0)
+					dev_err(codec->dev,
+						"Timed out starting FLL\n");
+			}
+		}
 		break;
 
 	case SND_SOC_DAPM_POST_PMD:
@@ -3263,16 +3275,31 @@ static int wm8962_set_fll(struct snd_soc_codec *codec, int fll_id, int source,
 
 	dev_dbg(codec->dev, "FLL configured for %dHz->%dHz\n", Fref, Fout);
 
-	/* This should be a massive overestimate */
-	timeout = msecs_to_jiffies(1);
+	ret = 0;
+
+	if (fll1 & WM8962_FLL_ENA) {
+		/* This should be a massive overestimate but go even
+		 * higher if we'll error out
+		 */
+		if (wm8962->irq)
+			timeout = msecs_to_jiffies(5);
+		else
+			timeout = msecs_to_jiffies(1);
+
+		timeout = wait_for_completion_timeout(&wm8962->fll_lock,
+						      timeout);
 
-	wait_for_completion_timeout(&wm8962->fll_lock, timeout);
+		if (timeout == 0 && wm8962->irq) {
+			dev_err(codec->dev, "FLL lock timed out");
+			ret = -ETIMEDOUT;
+		}
+	}
 
 	wm8962->fll_fref = Fref;
 	wm8962->fll_fout = Fout;
 	wm8962->fll_src = source;
 
-	return 0;
+	return ret;
 }
 
 static int wm8962_mute(struct snd_soc_dai *dai, int mute)
-- 
1.7.5.3
