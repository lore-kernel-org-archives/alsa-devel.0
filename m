From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl_ssi: Fix mode setting when changing
	channel number" to the asoc tree
Date: Thu, 12 Apr 2018 15:48:07 +0100
Message-ID: <E1f6dWB-00059o-Ne@debutante>
References: <1523162421-26400-1-git-send-email-nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6893240149511128784=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 18D5D2673B2
 for <alsa-devel@alsa-project.org>; Thu, 12 Apr 2018 16:48:17 +0200 (CEST)
In-Reply-To: <1523162421-26400-1-git-send-email-nicoleotsuka@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: alsa-devel@alsa-project.org, timur@tabi.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, tiwai@suse.com, broonie@kernel.org, mika.penttila@nextfour.com, fabio.estevam@nxp.com, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

--===============6893240149511128784==
Content-Type: text/plain

The patch

   ASoC: fsl_ssi: Fix mode setting when changing channel number

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From fac8a5a5ea40b03dcbb0f46977094099ba2220b8 Mon Sep 17 00:00:00 2001
From: Nicolin Chen <nicoleotsuka@gmail.com>
Date: Sat, 7 Apr 2018 21:40:21 -0700
Subject: [PATCH] ASoC: fsl_ssi: Fix mode setting when changing channel number
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is a partial revert (in a cleaner way) of commit ebf08ae3bc90
("ASoC: fsl_ssi: Keep ssi->i2s_net updated") to fix a regression
at test cases when switching between mono and stereo audio.

The problem is that ssi->i2s_net is initialized in set_dai_fmt()
only, while this set_dai_fmt() is only called during the dai-link
probe(). The original patch assumed set_dai_fmt() would be called
during every playback instance, so it failed at the overriding use
cases.

This patch adds the local variable i2s_net back to let regular use
cases still follow the mode settings from the set_dai_fmt().

Meanwhile, the original commit of keeping ssi->i2s_net updated was
to make set_tdm_slot() clean by checking the ssi->i2s_net directly
instead of reading SCR register. However, the change itself is not
necessary (or even harmful) because the set_tdm_slot() might fail
to check the slot number for Normal-Mode-None-Net settings while
mono audio cases still need 2 slots. So this patch can also fix it.
And it adds an extra line of comments to declare ssi->i2s_net does
not reflect the register value but merely the initial setting from
the set_dai_fmt().

Reported-by: Mika Penttilä <mika.penttila@nextfour.com>
Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
Tested-by: Mika Penttilä <mika.penttila@nextfour.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_ssi.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 0823b08923b5..89df2d9f63d7 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -217,6 +217,7 @@ struct fsl_ssi_soc_data {
  * @dai_fmt: DAI configuration this device is currently used with
  * @streams: Mask of current active streams: BIT(TX) and BIT(RX)
  * @i2s_net: I2S and Network mode configurations of SCR register
+ *           (this is the initial settings based on the DAI format)
  * @synchronous: Use synchronous mode - both of TX and RX use STCK and SFCK
  * @use_dma: DMA is used or FIQ with stream filter
  * @use_dual_fifo: DMA with support for dual FIFO mode
@@ -829,16 +830,23 @@ static int fsl_ssi_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	if (!fsl_ssi_is_ac97(ssi)) {
+		/*
+		 * Keep the ssi->i2s_net intact while having a local variable
+		 * to override settings for special use cases. Otherwise, the
+		 * ssi->i2s_net will lose the settings for regular use cases.
+		 */
+		u8 i2s_net = ssi->i2s_net;
+
 		/* Normal + Network mode to send 16-bit data in 32-bit frames */
 		if (fsl_ssi_is_i2s_cbm_cfs(ssi) && sample_size == 16)
-			ssi->i2s_net = SSI_SCR_I2S_MODE_NORMAL | SSI_SCR_NET;
+			i2s_net = SSI_SCR_I2S_MODE_NORMAL | SSI_SCR_NET;
 
 		/* Use Normal mode to send mono data at 1st slot of 2 slots */
 		if (channels == 1)
-			ssi->i2s_net = SSI_SCR_I2S_MODE_NORMAL;
+			i2s_net = SSI_SCR_I2S_MODE_NORMAL;
 
 		regmap_update_bits(regs, REG_SSI_SCR,
-				   SSI_SCR_I2S_NET_MASK, ssi->i2s_net);
+				   SSI_SCR_I2S_NET_MASK, i2s_net);
 	}
 
 	/* In synchronous mode, the SSI uses STCCR for capture */
-- 
2.17.0


--===============6893240149511128784==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6893240149511128784==--
