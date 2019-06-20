From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: ti: davinci-mcasp: Set unused
	serializers as INACTIVE" to the asoc tree
Date: Thu, 20 Jun 2019 14:32:24 +0100 (BST)
Message-ID: <20190620133224.AB9CF44004C@finisterre.sirena.org.uk>
References: <20190620092002.13766-2-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9200CF896F4
 for <alsa-devel@alsa-project.org>; Thu, 20 Jun 2019 15:32:25 +0200 (CEST)
In-Reply-To: <20190620092002.13766-2-peter.ujfalusi@ti.com>
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

   ASoC: ti: davinci-mcasp: Set unused serializers as INACTIVE

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

>From 5dd17a3c3ed545f73b8bf7754efd5f6125bf7531 Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Thu, 20 Jun 2019 12:20:01 +0300
Subject: [PATCH] ASoC: ti: davinci-mcasp: Set unused serializers as INACTIVE

Unused serializers needs to be configured as INACTIVE, otherwise they will
underflow/overflow when multiple serializers are connected, but some are
not needed for the given stream.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/ti/davinci-mcasp.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/sound/soc/ti/davinci-mcasp.c b/sound/soc/ti/davinci-mcasp.c
index a8378d223a9e..8bec0dc4f754 100644
--- a/sound/soc/ti/davinci-mcasp.c
+++ b/sound/soc/ti/davinci-mcasp.c
@@ -848,14 +848,15 @@ static int mcasp_common_hw_param(struct davinci_mcasp *mcasp, int stream,
 					rx_ser < max_active_serializers) {
 			clear_bit(PIN_BIT_AXR(i), &mcasp->pdir);
 			rx_ser++;
-		} else if (mcasp->serial_dir[i] == INACTIVE_MODE) {
+		} else {
+			/* Inactive or unused pin, set it to inactive */
 			mcasp_mod_bits(mcasp, DAVINCI_MCASP_XRSRCTL_REG(i),
 				       SRMOD_INACTIVE, SRMOD_MASK);
-			clear_bit(PIN_BIT_AXR(i), &mcasp->pdir);
-		} else if (mcasp->serial_dir[i] == TX_MODE) {
-			/* Unused TX pins, clear PDIR  */
-			mcasp_mod_bits(mcasp, DAVINCI_MCASP_XRSRCTL_REG(i),
-				       mcasp->dismod, DISMOD_MASK);
+			/* If unused, set DISMOD for the pin */
+			if (mcasp->serial_dir[i] != INACTIVE_MODE)
+				mcasp_mod_bits(mcasp,
+					       DAVINCI_MCASP_XRSRCTL_REG(i),
+					       mcasp->dismod, DISMOD_MASK);
 			clear_bit(PIN_BIT_AXR(i), &mcasp->pdir);
 		}
 	}
@@ -965,6 +966,7 @@ static int mcasp_i2s_hw_param(struct davinci_mcasp *mcasp, int stream,
 		for (i = 0; i < active_slots; i++)
 			mask |= (1 << i);
 	}
+
 	mcasp_clr_bits(mcasp, DAVINCI_MCASP_ACLKXCTL_REG, TX_ASYNC);
 
 	if (!mcasp->dat_port)
-- 
2.20.1
