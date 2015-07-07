From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: omap3pandora: Use card DAPM context to
	access widgets" to the asoc tree
Date: Tue, 07 Jul 2015 14:57:36 +0100
Message-ID: <E1ZCTNQ-0005Rw-Ay@finisterre>
References: <1436189891-15343-3-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 980AE2654B7
 for <alsa-devel@alsa-project.org>; Tue,  7 Jul 2015 15:57:48 +0200 (CEST)
In-Reply-To: <1436189891-15343-3-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: omap3pandora: Use card DAPM context to access widgets

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

>From 987731bb7c80b170228e6e1acf2e7b91efb51100 Mon Sep 17 00:00:00 2001
From: Lars-Peter Clausen <lars@metafoo.de>
Date: Mon, 6 Jul 2015 15:38:08 +0200
Subject: [PATCH] ASoC: omap3pandora: Use card DAPM context to access widgets

The dapm field of the snd_soc_codec struct will eventually be removed
(replaced with the DAPM context from the component embedded inside the
CODEC). Replace its usage with the card's DAPM context. The idea is that
DAPM is hierarchical and with the card at the root it is possible to access
widgets from other contexts through the card context.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/omap/omap3pandora.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/omap/omap3pandora.c b/sound/soc/omap/omap3pandora.c
index 076bec6..732e749 100644
--- a/sound/soc/omap/omap3pandora.c
+++ b/sound/soc/omap/omap3pandora.c
@@ -154,8 +154,7 @@ static const struct snd_soc_dapm_route omap3pandora_map[] = {
 
 static int omap3pandora_out_init(struct snd_soc_pcm_runtime *rtd)
 {
-	struct snd_soc_codec *codec = rtd->codec;
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
+	struct snd_soc_dapm_context *dapm = &rtd->card->dapm;
 
 	/* All TWL4030 output pins are floating */
 	snd_soc_dapm_nc_pin(dapm, "EARPIECE");
@@ -174,8 +173,7 @@ static int omap3pandora_out_init(struct snd_soc_pcm_runtime *rtd)
 
 static int omap3pandora_in_init(struct snd_soc_pcm_runtime *rtd)
 {
-	struct snd_soc_codec *codec = rtd->codec;
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
+	struct snd_soc_dapm_context *dapm = &rtd->card->dapm;
 
 	/* Not comnnected */
 	snd_soc_dapm_nc_pin(dapm, "HSMIC");
-- 
2.1.4
