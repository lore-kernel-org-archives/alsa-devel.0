From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: pxa: remove incorrect do_div() call" to
	the asoc tree
Date: Fri, 20 Nov 2015 18:20:24 +0000
Message-ID: <E1ZzqIK-0003tw-5D@debutante>
References: <7580645.enu4DmUPIv@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 905C6266677
 for <alsa-devel@alsa-project.org>; Fri, 20 Nov 2015 19:20:31 +0100 (CET)
In-Reply-To: <7580645.enu4DmUPIv@wuerfel>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: pxa: remove incorrect do_div() call

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

>From d1afdf34fc17bd2e1c96dc6196c562fa8906a026 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 20 Nov 2015 10:32:44 +0100
Subject: [PATCH] ASoC: pxa: remove incorrect do_div() call

The new optimized do_div implementation (now in asm-generic/next) exposes a
glitch in the brownstone audio driver by producing a compile-time warning:

sound/soc/pxa/brownstone.c: In function 'brownstone_wm8994_hw_params':
sound/soc/pxa/brownstone.c:67:85: warning: comparison of distinct pointer types lacks a cast
sound/soc/pxa/brownstone.c:67:10125: warning: right shift count >= width of type [-Wshift-count-overflow]
sound/soc/pxa/brownstone.c:67:10254: warning: passing argument 1 of '__div64_32' from incompatible pointer type [-Wincompatible-pointer-types]

The driver just divides two plain integer values, so it should not
use do_div to start with, but has apparently done so ever since the
code was first merged. This replaces do_div with a simple division
operator.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/pxa/brownstone.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/pxa/brownstone.c b/sound/soc/pxa/brownstone.c
index 6147e86e9b0f..416ea646c3b1 100644
--- a/sound/soc/pxa/brownstone.c
+++ b/sound/soc/pxa/brownstone.c
@@ -63,8 +63,7 @@ static int brownstone_wm8994_hw_params(struct snd_pcm_substream *substream,
 		sysclk    = params_rate(params) * 512;
 		sspa_mclk = params_rate(params) * 64;
 	}
-	sspa_div = freq_out;
-	do_div(sspa_div, sspa_mclk);
+	sspa_div = freq_out / sspa_mclk;
 
 	snd_soc_dai_set_sysclk(cpu_dai, MMP_SSPA_CLK_AUDIO, freq_out, 0);
 	snd_soc_dai_set_pll(cpu_dai, MMP_SYSCLK, 0, freq_out, sysclk);
-- 
2.6.2
