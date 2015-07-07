From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tas571x: Replace direct snd_soc_codec
	dapm field access" to the asoc tree
Date: Tue, 07 Jul 2015 14:57:37 +0100
Message-ID: <E1ZCTNR-0005SP-IH@finisterre>
References: <1436189891-15343-2-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3FEF22654CD
 for <alsa-devel@alsa-project.org>; Tue,  7 Jul 2015 15:57:50 +0200 (CEST)
In-Reply-To: <1436189891-15343-2-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, Kevin Cernekee <cernekee@chromium.org>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: tas571x: Replace direct snd_soc_codec dapm field access

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

>From 8f218fa93d20a7b4ef8a088e5eed2d84b8ef4ab5 Mon Sep 17 00:00:00 2001
From: Lars-Peter Clausen <lars@metafoo.de>
Date: Mon, 6 Jul 2015 15:38:07 +0200
Subject: [PATCH] ASoC: tas571x: Replace direct snd_soc_codec dapm field access

The dapm field of the snd_soc_codec struct is eventually going to be
removed, in preparation for this replace all manual access to
codec->dapm.bias_level with snd_soc_codec_get_bias_level().

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Kevin Cernekee <cernekee@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tas571x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tas571x.c b/sound/soc/codecs/tas571x.c
index 85bcc37..39307ad 100644
--- a/sound/soc/codecs/tas571x.c
+++ b/sound/soc/codecs/tas571x.c
@@ -179,7 +179,7 @@ static int tas571x_set_bias_level(struct snd_soc_codec *codec,
 	case SND_SOC_BIAS_PREPARE:
 		break;
 	case SND_SOC_BIAS_STANDBY:
-		if (codec->dapm.bias_level == SND_SOC_BIAS_OFF) {
+		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_OFF) {
 			if (!IS_ERR(priv->mclk)) {
 				ret = clk_prepare_enable(priv->mclk);
 				if (ret) {
-- 
2.1.4
