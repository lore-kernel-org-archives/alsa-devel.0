From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: nau8825: correct typo in biquad filter
	coefficients" to the asoc tree
Date: Fri, 03 Jun 2016 11:45:03 +0100
Message-ID: <E1b8mb9-0003Gh-0J@finisterre>
References: <1464926536-2685-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D3839265238
 for <alsa-devel@alsa-project.org>; Fri,  3 Jun 2016 12:45:17 +0200 (CEST)
In-Reply-To: <1464926536-2685-1-git-send-email-KCHSU0@nuvoton.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Hsu <KCHSU0@nuvoton.com>
Cc: alsa-devel@alsa-project.org, anatol.pomozov@gmail.com, benzh@chromium.org, lgirdwood@gmail.com, YHCHuang@nuvoton.com, broonie@kernel.org, CTLIN0@nuvoton.com, yong.zhi@intel.com, mhkuo@nuvoton.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: nau8825: correct typo in biquad filter coefficients

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

>From 0cbeccdfb159110f5158c0daf52acf6b2288eaf7 Mon Sep 17 00:00:00 2001
From: John Hsu <KCHSU0@nuvoton.com>
Date: Fri, 3 Jun 2016 12:02:16 +0800
Subject: [PATCH] ASoC: nau8825: correct typo in biquad filter coefficients

There is typo in the name of biquad filter coefficients control.
The patch is to fix the typo.

Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/nau8825.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
index dbb91aae9905..43cb677d3db2 100644
--- a/sound/soc/codecs/nau8825.c
+++ b/sound/soc/codecs/nau8825.c
@@ -386,7 +386,7 @@ static const struct snd_kcontrol_new nau8825_controls[] = {
 	SOC_ENUM("DAC Oversampling Rate", nau8825_dac_oversampl_enum),
 	/* programmable biquad filter */
 	SOC_ENUM("BIQ Path Select", nau8825_biq_path_enum),
-	SND_SOC_BYTES_EXT("BIQ Coefficeints", 20,
+	SND_SOC_BYTES_EXT("BIQ Coefficients", 20,
 		  nau8825_biq_coeff_get, nau8825_biq_coeff_put),
 };
 
-- 
2.8.1
