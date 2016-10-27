From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: arizona: Access driver data through
	platform from compressed ops" to the asoc tree
Date: Thu, 27 Oct 2016 17:47:45 +0100
Message-ID: <E1bznqD-0007kb-OI@debutante>
References: <1477498000-10104-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E81512669A9
 for <alsa-devel@alsa-project.org>; Thu, 27 Oct 2016 18:47:55 +0200 (CEST)
In-Reply-To: <1477498000-10104-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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
Cc: patches@opensource.wolfsonmicro.com, broonie@kernel.org, lars@metafoo.de, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: arizona: Access driver data through platform from compressed ops

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

>From 1095e281559d61ed05c1b33aa4c6b305fcc211df Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Date: Wed, 26 Oct 2016 17:06:40 +0100
Subject: [PATCH] ASoC: arizona: Access driver data through platform from
 compressed ops

As the compressed ops run on the platform side of things we should
really access the driver data through the platform pointer rather than
the CODEC pointer. As the compressed DAIs in our systems always connect
our CODEC to our platform this has never been an issue, but should still
be corrected. Additionally it clears the way for future core refactoring
work.

Reported-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs47l24.c | 2 +-
 sound/soc/codecs/wm5102.c  | 2 +-
 sound/soc/codecs/wm5110.c  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/cs47l24.c b/sound/soc/codecs/cs47l24.c
index f9e720b65454..1ed1329c31cc 100644
--- a/sound/soc/codecs/cs47l24.c
+++ b/sound/soc/codecs/cs47l24.c
@@ -1066,7 +1066,7 @@ static struct snd_soc_dai_driver cs47l24_dai[] = {
 static int cs47l24_open(struct snd_compr_stream *stream)
 {
 	struct snd_soc_pcm_runtime *rtd = stream->private_data;
-	struct cs47l24_priv *priv = snd_soc_codec_get_drvdata(rtd->codec);
+	struct cs47l24_priv *priv = snd_soc_platform_get_drvdata(rtd->platform);
 	struct arizona *arizona = priv->core.arizona;
 	int n_adsp;
 
diff --git a/sound/soc/codecs/wm5102.c b/sound/soc/codecs/wm5102.c
index a80a680d1b5b..0136234e6e66 100644
--- a/sound/soc/codecs/wm5102.c
+++ b/sound/soc/codecs/wm5102.c
@@ -1908,7 +1908,7 @@ static struct snd_soc_dai_driver wm5102_dai[] = {
 static int wm5102_open(struct snd_compr_stream *stream)
 {
 	struct snd_soc_pcm_runtime *rtd = stream->private_data;
-	struct wm5102_priv *priv = snd_soc_codec_get_drvdata(rtd->codec);
+	struct wm5102_priv *priv = snd_soc_platform_get_drvdata(rtd->platform);
 
 	return wm_adsp_compr_open(&priv->core.adsp[0], stream);
 }
diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index f1a41139caf6..a9a8bc98fb29 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -2224,7 +2224,7 @@ static struct snd_soc_dai_driver wm5110_dai[] = {
 static int wm5110_open(struct snd_compr_stream *stream)
 {
 	struct snd_soc_pcm_runtime *rtd = stream->private_data;
-	struct wm5110_priv *priv = snd_soc_codec_get_drvdata(rtd->codec);
+	struct wm5110_priv *priv = snd_soc_platform_get_drvdata(rtd->platform);
 	struct arizona *arizona = priv->core.arizona;
 	int n_adsp;
 
-- 
2.8.1
