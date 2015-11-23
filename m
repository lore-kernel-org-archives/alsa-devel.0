From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: davinci-mcasp: Fix master capture only
	mode" to the asoc tree
Date: Mon, 23 Nov 2015 11:41:01 +0000
Message-ID: <E1a0pUT-0005S9-Ka@debutante>
References: <1448275913-30546-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9D3B9265238
 for <alsa-devel@alsa-project.org>; Mon, 23 Nov 2015 12:41:08 +0100 (CET)
In-Reply-To: <1448275913-30546-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: davinci-mcasp: Fix master capture only mode

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

>From 0ad7d3a04b2a1a43fa71eb89f754527b082213ad Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Mon, 23 Nov 2015 12:51:53 +0200
Subject: [PATCH] ASoC: davinci-mcasp: Fix master capture only mode

When McASP is used as TX/RX synchronous (TX side generating clocks for RX
side also) and only capture is used we need to configure the number of TX
slots in order McASP to be able to generate the Frame sync.

Fixes: 9273de1940d9e ("ASoC: davinci-mcasp: Add set_tdm_slots() support")
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/davinci/davinci-mcasp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index caa0bebcd7f4..c1c9c2e3525b 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -908,6 +908,14 @@ static int mcasp_i2s_hw_param(struct davinci_mcasp *mcasp, int stream,
 		mcasp_set_bits(mcasp, DAVINCI_MCASP_RXFMT_REG, busel | RXORD);
 		mcasp_mod_bits(mcasp, DAVINCI_MCASP_RXFMCTL_REG,
 			       FSRMOD(total_slots), FSRMOD(0x1FF));
+		/*
+		 * If McASP is set to be TX/RX synchronous and the playback is
+		 * not running already we need to configure the TX slots in
+		 * order to have correct FSX on the bus
+		 */
+		if (mcasp_is_synchronous(mcasp) && !mcasp->channels)
+			mcasp_mod_bits(mcasp, DAVINCI_MCASP_TXFMCTL_REG,
+				       FSXMOD(total_slots), FSXMOD(0x1FF));
 	}
 
 	return 0;
-- 
2.6.2
