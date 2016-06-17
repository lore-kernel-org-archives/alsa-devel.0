From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoc: wm8731: add 32bit mode." to the asoc
	tree
Date: Fri, 17 Jun 2016 12:43:27 +0100
Message-ID: <E1bDsBL-000272-3X@debutante>
References: <1466138896-19739-1-git-send-email-flatmax@flatmax.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CDCCA265CB5
 for <alsa-devel@alsa-project.org>; Fri, 17 Jun 2016 13:43:35 +0200 (CEST)
In-Reply-To: <1466138896-19739-1-git-send-email-flatmax@flatmax.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Matt Flax <flatmax@flatmax.org>
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, broonie@kernel.org, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoc: wm8731: add 32bit mode.

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

>From cf5ef3a299ba32f6ac24c3c6ba18c1b7f1b5475f Mon Sep 17 00:00:00 2001
From: Matt Flax <flatmax@flatmax.org>
Date: Fri, 17 Jun 2016 14:48:16 +1000
Subject: [PATCH] ASoc: wm8731: add 32bit mode.

This patch adds 32 bit word capability to the wm8731 driver. The wm8731
codec is capable of handling 32 bit word sizes, however that has not
previously been activated in the codec driver.

Signed-off-by: Matt Flax <flatmax@flatmax.org>
Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm8731.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8731.c b/sound/soc/codecs/wm8731.c
index 4bcf5f8ece50..d18261a44256 100644
--- a/sound/soc/codecs/wm8731.c
+++ b/sound/soc/codecs/wm8731.c
@@ -358,6 +358,9 @@ static int wm8731_hw_params(struct snd_pcm_substream *substream,
 	case 24:
 		iface |= 0x0008;
 		break;
+	case 32:
+		iface |= 0x000c;
+		break;
 	}
 
 	wm8731_set_deemph(codec);
@@ -541,7 +544,7 @@ static int wm8731_startup(struct snd_pcm_substream *substream,
 #define WM8731_RATES SNDRV_PCM_RATE_8000_96000
 
 #define WM8731_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE |\
-	SNDRV_PCM_FMTBIT_S24_LE)
+	SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE)
 
 static const struct snd_soc_dai_ops wm8731_dai_ops = {
 	.startup	= wm8731_startup,
-- 
2.8.1
