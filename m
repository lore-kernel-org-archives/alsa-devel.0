From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: arizona: Propagate errors from
	arizona_spk_init" to the asoc tree
Date: Thu, 19 Jan 2017 18:03:56 +0000
Message-ID: <E1cUH40-0004ys-M6@debutante>
References: <1484753225-24188-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id ADB9F2678D4
 for <alsa-devel@alsa-project.org>; Thu, 19 Jan 2017 19:04:07 +0100 (CET)
In-Reply-To: <1484753225-24188-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: arizona: Propagate errors from arizona_spk_init

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

>From acff07d060d8175b2b54c5bc2d9bb910a6db1049 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Date: Wed, 18 Jan 2017 15:27:05 +0000
Subject: [PATCH] ASoC: arizona: Propagate errors from arizona_spk_init

arizona_spk_init uses snd_soc_dapm_new_control which since
commit 37e1df8c95e2 ("ASoC: dapm: handle probe deferrals") will
occasionally request a probe deferral. Which means we should propagate the
error out of our driver from it.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs47l24.c | 5 ++++-
 sound/soc/codecs/wm5102.c  | 5 ++++-
 sound/soc/codecs/wm5110.c  | 5 ++++-
 sound/soc/codecs/wm8997.c  | 6 +++++-
 sound/soc/codecs/wm8998.c  | 6 +++++-
 5 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/cs47l24.c b/sound/soc/codecs/cs47l24.c
index 73559ae864b6..5bf6e599e835 100644
--- a/sound/soc/codecs/cs47l24.c
+++ b/sound/soc/codecs/cs47l24.c
@@ -1121,7 +1121,10 @@ static int cs47l24_codec_probe(struct snd_soc_codec *codec)
 
 	priv->core.arizona->dapm = dapm;
 
-	arizona_init_spk(codec);
+	ret = arizona_init_spk(codec);
+	if (ret < 0)
+		return ret;
+
 	arizona_init_gpio(codec);
 	arizona_init_mono(codec);
 	arizona_init_notifiers(codec);
diff --git a/sound/soc/codecs/wm5102.c b/sound/soc/codecs/wm5102.c
index e7ab37d0dd32..3fd42d30b1eb 100644
--- a/sound/soc/codecs/wm5102.c
+++ b/sound/soc/codecs/wm5102.c
@@ -1944,7 +1944,10 @@ static int wm5102_codec_probe(struct snd_soc_codec *codec)
 	if (ret)
 		goto err_adsp2_codec_probe;
 
-	arizona_init_spk(codec);
+	ret = arizona_init_spk(codec);
+	if (ret < 0)
+		return ret;
+
 	arizona_init_gpio(codec);
 	arizona_init_notifiers(codec);
 
diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index 585fc706c1b0..9a9c2d097d9e 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -2279,7 +2279,10 @@ static int wm5110_codec_probe(struct snd_soc_codec *codec)
 
 	priv->core.arizona->dapm = dapm;
 
-	arizona_init_spk(codec);
+	ret = arizona_init_spk(codec);
+	if (ret < 0)
+		return ret;
+
 	arizona_init_gpio(codec);
 	arizona_init_mono(codec);
 	arizona_init_notifiers(codec);
diff --git a/sound/soc/codecs/wm8997.c b/sound/soc/codecs/wm8997.c
index ee0c8639c743..49401a8aae64 100644
--- a/sound/soc/codecs/wm8997.c
+++ b/sound/soc/codecs/wm8997.c
@@ -1062,8 +1062,12 @@ static int wm8997_codec_probe(struct snd_soc_codec *codec)
 	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
 	struct snd_soc_component *component = snd_soc_dapm_to_component(dapm);
 	struct wm8997_priv *priv = snd_soc_codec_get_drvdata(codec);
+	int ret;
+
+	ret = arizona_init_spk(codec);
+	if (ret < 0)
+		return ret;
 
-	arizona_init_spk(codec);
 	arizona_init_notifiers(codec);
 
 	snd_soc_component_disable_pin(component, "HAPTICS");
diff --git a/sound/soc/codecs/wm8998.c b/sound/soc/codecs/wm8998.c
index 3694f5958d86..44f447136e22 100644
--- a/sound/soc/codecs/wm8998.c
+++ b/sound/soc/codecs/wm8998.c
@@ -1321,10 +1321,14 @@ static int wm8998_codec_probe(struct snd_soc_codec *codec)
 	struct wm8998_priv *priv = snd_soc_codec_get_drvdata(codec);
 	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
 	struct snd_soc_component *component = snd_soc_dapm_to_component(dapm);
+	int ret;
 
 	priv->core.arizona->dapm = dapm;
 
-	arizona_init_spk(codec);
+	ret = arizona_init_spk(codec);
+	if (ret < 0)
+		return ret;
+
 	arizona_init_gpio(codec);
 	arizona_init_notifiers(codec);
 
-- 
2.11.0
