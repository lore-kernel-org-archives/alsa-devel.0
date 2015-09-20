From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm8962: remove 64k sample rate support"
	to the asoc tree
Date: Sat, 19 Sep 2015 17:13:04 -0700
Message-ID: <E1ZdSFc-00041F-5d@finisterre>
References: <2e8075642e5d428b1136b3b7b18be5b7d30c358a.1442566367.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A06EB2605D8
 for <alsa-devel@alsa-project.org>; Sun, 20 Sep 2015 02:13:18 +0200 (CEST)
In-Reply-To: <2e8075642e5d428b1136b3b7b18be5b7d30c358a.1442566367.git.zidan.wang@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Zidan Wang <zidan.wang@freescale.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm8962: remove 64k sample rate support

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

>From ee92cfb030c16ddb01f6543968f13bcb61ed9da5 Mon Sep 17 00:00:00 2001
From: Zidan Wang <zidan.wang@freescale.com>
Date: Fri, 18 Sep 2015 17:19:25 +0800
Subject: [PATCH] ASoC: wm8962: remove 64k sample rate support

wm8962 can't support 64k sample rate. When playing a 64KHz wave file,
'Unsupported rate 64000Hz' will be prompted.

Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm8962.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index b4eb975..293e47a 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -2944,7 +2944,8 @@ static int wm8962_mute(struct snd_soc_dai *dai, int mute)
 				   WM8962_DAC_MUTE, val);
 }
 
-#define WM8962_RATES SNDRV_PCM_RATE_8000_96000
+#define WM8962_RATES (SNDRV_PCM_RATE_8000_48000 |\
+		SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000)
 
 #define WM8962_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE |\
 			SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE)
-- 
2.5.0
