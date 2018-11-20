From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tlv320aic3x: Add support for CBM_CFS
	and CBS_CFM clocking modes" to the asoc tree
Date: Tue, 20 Nov 2018 16:28:01 +0000 (GMT)
Message-ID: <20181120162801.3C2601124DC2@debutante.sirena.org.uk>
References: <20181120124253.27775-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id EF46526784F
 for <alsa-devel@alsa-project.org>; Tue, 20 Nov 2018 17:28:02 +0100 (CET)
In-Reply-To: <20181120124253.27775-1-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: tlv320aic3x: Add support for CBM_CFS and CBS_CFM clocking modes

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

>From 4647598cde0e55d5c6d6a3c4223953611a472289 Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Tue, 20 Nov 2018 14:42:53 +0200
Subject: [PATCH] ASoC: tlv320aic3x: Add support for CBM_CFS and CBS_CFM
 clocking modes

The codec can support any variation of bclk/fs master/slave configuration.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tlv320aic3x.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 6a271e6e6b8f..6aa0edf8c5ef 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -1260,6 +1260,16 @@ static int aic3x_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		aic3x->master = 0;
 		iface_areg &= ~(BIT_CLK_MASTER | WORD_CLK_MASTER);
 		break;
+	case SND_SOC_DAIFMT_CBM_CFS:
+		aic3x->master = 1;
+		iface_areg |= BIT_CLK_MASTER;
+		iface_areg &= ~WORD_CLK_MASTER;
+		break;
+	case SND_SOC_DAIFMT_CBS_CFM:
+		aic3x->master = 1;
+		iface_areg |= WORD_CLK_MASTER;
+		iface_areg &= ~BIT_CLK_MASTER;
+		break;
 	default:
 		return -EINVAL;
 	}
-- 
2.19.0.rc2
