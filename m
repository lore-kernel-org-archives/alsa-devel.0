From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm8962: set ALC2 as non-volatile
	register" to the asoc tree
Date: Wed, 28 Oct 2015 09:21:44 +0900
Message-ID: <E1ZrEUq-0007Fs-7E@finisterre>
References: <1445577528-2354-1-git-send-email-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 974AE26149D
 for <alsa-devel@alsa-project.org>; Wed, 28 Oct 2015 01:21:58 +0100 (CET)
In-Reply-To: <1445577528-2354-1-git-send-email-jiada_wang@mentor.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jiada Wang <jiada_wang@mentor.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm8962: set ALC2 as non-volatile register

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

>From 0b170f7acd2ab1ca0771b933493b9241706117b4 Mon Sep 17 00:00:00 2001
From: Jiada Wang <jiada_wang@mentor.com>
Date: Fri, 23 Oct 2015 14:18:48 +0900
Subject: [PATCH] ASoC: wm8962: set ALC2 as non-volatile register

Previously ALC2 register is set as a volatile register, declare
it as one of ALC Coefficients register together with other non-volatile
registers will cause issue, in case wm8962 has enter suspend mode,
and cache_only flag is set, any attempt to read from ALC2 will fail.

Because the 5 status bits in ALC2 aren't used anywhere nor are useful
to end user, so this patch removes ALC2 register from volatile
register list to make ALC2 be possible to be accessed when cache_only
flag is set.

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm8962.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index b4eb975..2976200 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -131,7 +131,7 @@ static const struct reg_default wm8962_reg[] = {
 	{ 15, 0x6243 },   /* R15    - Software Reset */
 
 	{ 17, 0x007B },   /* R17    - ALC1 */
-
+	{ 18, 0x0000 },   /* R18    - ALC2 */
 	{ 19, 0x1C32 },   /* R19    - ALC3 */
 	{ 20, 0x3200 },   /* R20    - Noise Gate */
 	{ 21, 0x00C0 },   /* R21    - Left ADC volume */
@@ -794,7 +794,6 @@ static bool wm8962_volatile_register(struct device *dev, unsigned int reg)
 	case WM8962_CLOCKING1:
 	case WM8962_CLOCKING2:
 	case WM8962_SOFTWARE_RESET:
-	case WM8962_ALC2:
 	case WM8962_THERMAL_SHUTDOWN_STATUS:
 	case WM8962_ADDITIONAL_CONTROL_4:
 	case WM8962_DC_SERVO_6:
-- 
2.6.1
