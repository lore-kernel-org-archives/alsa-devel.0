From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm8962: Correct typo when setting
	DSPCLK rate" to the asoc tree
Date: Tue, 29 Mar 2016 10:08:12 -0700
Message-ID: <E1akx7k-0001H1-9Y@finisterre>
References: <1459158454-5635-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3F4492668C4
 for <alsa-devel@alsa-project.org>; Tue, 29 Mar 2016 19:08:22 +0200 (CEST)
In-Reply-To: <1459158454-5635-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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

   ASoC: wm8962: Correct typo when setting DSPCLK rate

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

>From 33362c69c8e68281633a7c3a1d5c840e940097b7 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Date: Mon, 28 Mar 2016 10:47:34 +0100
Subject: [PATCH] ASoC: wm8962: Correct typo when setting DSPCLK rate

The variable dspclk holds the rate of the DSPCLK, but the variable
sysclk holds an identifier for the clock. Currently if read a
non-sensical value from the DSPCLK_DIV register we assign sysclk to
dspclk, clearly this was intended to be sysclk_rate.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm8962.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 88223608a33f..720a14e0687d 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -2471,7 +2471,7 @@ static void wm8962_configure_bclk(struct snd_soc_codec *codec)
 		break;
 	default:
 		dev_warn(codec->dev, "Unknown DSPCLK divisor read back\n");
-		dspclk = wm8962->sysclk;
+		dspclk = wm8962->sysclk_rate;
 	}
 
 	dev_dbg(codec->dev, "DSPCLK is %dHz, BCLK %d\n", dspclk, wm8962->bclk);
-- 
2.8.0.rc3
