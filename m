From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: arizona: Fix error path in codec probe"
	to the asoc tree
Date: Fri, 10 Jul 2015 19:08:36 +0100
Message-ID: <E1ZDciz-0006rT-01@debutante>
References: <1436535445-32176-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A85F52604A7
 for <alsa-devel@alsa-project.org>; Fri, 10 Jul 2015 20:08:46 +0200 (CEST)
In-Reply-To: <1436535445-32176-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: arizona: Fix error path in codec probe

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From d90c6cc242045115c5c4973114cc93e1c20e2ea8 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Date: Fri, 10 Jul 2015 14:37:25 +0100
Subject: [PATCH] ASoC: arizona: Fix error path in codec probe

If we fail to add some DSPs or fail to add the controls we should call
wm_adsp2_codec_remove for all the cores we have already added. This
patch fixes this up on the wm5102 and wm5110.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm5102.c |  7 ++++++-
 sound/soc/codecs/wm5110.c | 10 ++++++++--
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm5102.c b/sound/soc/codecs/wm5102.c
index 6ddee999bc51..64637d1cf4e5 100644
--- a/sound/soc/codecs/wm5102.c
+++ b/sound/soc/codecs/wm5102.c
@@ -1879,7 +1879,7 @@ static int wm5102_codec_probe(struct snd_soc_codec *codec)
 	ret = snd_soc_add_codec_controls(codec,
 					 arizona_adsp2_rate_controls, 1);
 	if (ret)
-		return ret;
+		goto err_adsp2_codec_probe;
 
 	arizona_init_spk(codec);
 	arizona_init_gpio(codec);
@@ -1889,6 +1889,11 @@ static int wm5102_codec_probe(struct snd_soc_codec *codec)
 	priv->core.arizona->dapm = dapm;
 
 	return 0;
+
+err_adsp2_codec_probe:
+	wm_adsp2_codec_remove(&priv->core.adsp[0], codec);
+
+	return ret;
 }
 
 static int wm5102_codec_remove(struct snd_soc_codec *codec)
diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index 05aa5bca97cf..2d1168c768d9 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -1607,18 +1607,24 @@ static int wm5110_codec_probe(struct snd_soc_codec *codec)
 	for (i = 0; i < WM5110_NUM_ADSP; ++i) {
 		ret = wm_adsp2_codec_probe(&priv->core.adsp[i], codec);
 		if (ret)
-			return ret;
+			goto err_adsp2_codec_probe;
 	}
 
 	ret = snd_soc_add_codec_controls(codec,
 					 arizona_adsp2_rate_controls,
 					 WM5110_NUM_ADSP);
 	if (ret)
-		return ret;
+		goto err_adsp2_codec_probe;
 
 	snd_soc_dapm_disable_pin(dapm, "HAPTICS");
 
 	return 0;
+
+err_adsp2_codec_probe:
+	for (--i; i >= 0; --i)
+		wm_adsp2_codec_remove(&priv->core.adsp[i], codec);
+
+	return ret;
 }
 
 static int wm5110_codec_remove(struct snd_soc_codec *codec)
-- 
2.1.4
