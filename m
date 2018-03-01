From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: max9867: DSP mode" to the asoc tree
Date: Thu, 01 Mar 2018 18:06:34 +0000
Message-ID: <E1erSbC-0005lO-BC@debutante>
References: <20180301142130.GG30722@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id AE82526798E
 for <alsa-devel@alsa-project.org>; Thu,  1 Mar 2018 19:06:35 +0100 (CET)
In-Reply-To: <20180301142130.GG30722@lenoch>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ladislav Michl <ladis@linux-mips.org>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: max9867: DSP mode

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

>From 79e139744508105bd749300f364563934bff23f2 Mon Sep 17 00:00:00 2001
From: Ladislav Michl <ladis@linux-mips.org>
Date: Thu, 1 Mar 2018 15:21:30 +0100
Subject: [PATCH] ASoC: max9867: DSP mode

Add configuration for DSP mode.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max9867.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/max9867.c b/sound/soc/codecs/max9867.c
index 367c0329d5c8..0dbf3136e3ef 100644
--- a/sound/soc/codecs/max9867.c
+++ b/sound/soc/codecs/max9867.c
@@ -325,10 +325,16 @@ static int max9867_dai_set_fmt(struct snd_soc_dai *codec_dai,
 		return -EINVAL;
 	}
 
-	/* for i2s compatible mode */
-	iface1A |= MAX9867_I2S_DLY;
-	/* SDOUT goes to hiz state after all data is transferred */
-	iface1A |= MAX9867_SDOUT_HIZ;
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+		iface1A |= MAX9867_I2S_DLY;
+		break;
+	case SND_SOC_DAIFMT_DSP_A:
+		iface1A |= MAX9867_TDM_MODE | MAX9867_SDOUT_HIZ;
+		break;
+	default:
+		return -EINVAL;
+	}
 
 	/* Clock inversion bits, BCI and WCI */
 	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
-- 
2.16.2
