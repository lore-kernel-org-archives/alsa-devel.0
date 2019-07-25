From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: ti: davinci-mcasp: Fix clk PDIR
	handling for i2s master mode" to the asoc tree
Date: Thu, 25 Jul 2019 14:19:26 +0100 (BST)
Message-ID: <20190725131926.B594E2742B5F@ypsilon.sirena.org.uk>
References: <20190725083423.7321-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3F15EF8044A
 for <alsa-devel@alsa-project.org>; Thu, 25 Jul 2019 15:19:27 +0200 (CEST)
In-Reply-To: <20190725083423.7321-1-peter.ujfalusi@ti.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com, jsarha@ti.com, misael.lopez@ti.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: ti: davinci-mcasp: Fix clk PDIR handling for i2s master mode

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

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

>From 9fcf9139a2fd06b1ea1b11579371834cfa04bf4c Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Thu, 25 Jul 2019 11:34:23 +0300
Subject: [PATCH] ASoC: ti: davinci-mcasp: Fix clk PDIR handling for i2s master
 mode

When running McASP as master capture alone will not record any audio unless
a parallel playback stream is running. As soon as the playback stops the
captured data is going to be silent again.

In McASP master mode we need to set the PDIR for the clock pins and fix
the mcasp_set_axr_pdir() to skip the bits in the PDIR registers above
AMUTE.

This went unnoticed as most of the boards uses McASP as slave and neither
of these issues are visible (audible) in those setups.

Fixes: 2302be4126f52 ("ASoC: davinci-mcasp: Update PDIR (pin direction) register handling")
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Link: https://lore.kernel.org/r/20190725083423.7321-1-peter.ujfalusi@ti.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/ti/davinci-mcasp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/ti/davinci-mcasp.c b/sound/soc/ti/davinci-mcasp.c
index 2c518088b64d..4d611565375b 100644
--- a/sound/soc/ti/davinci-mcasp.c
+++ b/sound/soc/ti/davinci-mcasp.c
@@ -195,7 +195,7 @@ static inline void mcasp_set_axr_pdir(struct davinci_mcasp *mcasp, bool enable)
 {
 	u32 bit;
 
-	for_each_set_bit(bit, &mcasp->pdir, PIN_BIT_AFSR) {
+	for_each_set_bit(bit, &mcasp->pdir, PIN_BIT_AMUTE) {
 		if (enable)
 			mcasp_set_bits(mcasp, DAVINCI_MCASP_PDIR_REG, BIT(bit));
 		else
@@ -223,6 +223,7 @@ static void mcasp_start_rx(struct davinci_mcasp *mcasp)
 	if (mcasp_is_synchronous(mcasp)) {
 		mcasp_set_ctl_reg(mcasp, DAVINCI_MCASP_GBLCTLX_REG, TXHCLKRST);
 		mcasp_set_ctl_reg(mcasp, DAVINCI_MCASP_GBLCTLX_REG, TXCLKRST);
+		mcasp_set_clk_pdir(mcasp, true);
 	}
 
 	/* Activate serializer(s) */
-- 
2.20.1
