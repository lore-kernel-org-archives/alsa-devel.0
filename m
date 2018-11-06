From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: ak5558: Remove redundant
	snd_soc_component_read32 calls" to the asoc tree
Date: Tue,  6 Nov 2018 18:09:19 +0000 (GMT)
Message-ID: <20181106180919.CD2CB112266B@debutante.sirena.org.uk>
References: <20181106093919.20740-1-axel.lin@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 98333267ADA
 for <alsa-devel@alsa-project.org>; Tue,  6 Nov 2018 19:09:20 +0100 (CET)
In-Reply-To: <20181106093919.20740-1-axel.lin@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Daniel Baluta <daniel.baluta@nxp.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: ak5558: Remove redundant snd_soc_component_read32 calls

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

>From 39dfdf00c7a56b2a8c01c596f6522f089428b1c7 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Tue, 6 Nov 2018 17:39:19 +0800
Subject: [PATCH] ASoC: ak5558: Remove redundant snd_soc_component_read32 calls

snd_soc_component_update_bits() will only update the mask bits,
so remove the redundant snd_soc_component_read32().

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/ak5558.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/ak5558.c b/sound/soc/codecs/ak5558.c
index 60f1f12c81ea..8179512129d3 100644
--- a/sound/soc/codecs/ak5558.c
+++ b/sound/soc/codecs/ak5558.c
@@ -130,16 +130,12 @@ static int ak5558_hw_params(struct snd_pcm_substream *substream,
 	u8 bits;
 	int pcm_width = max(params_physical_width(params), ak5558->slot_width);
 
-	/* set master/slave audio interface */
-	bits = snd_soc_component_read32(component, AK5558_02_CONTROL1);
-	bits &= ~AK5558_BITS;
-
 	switch (pcm_width) {
 	case 16:
-		bits |= AK5558_DIF_24BIT_MODE;
+		bits = AK5558_DIF_24BIT_MODE;
 		break;
 	case 32:
-		bits |= AK5558_DIF_32BIT_MODE;
+		bits = AK5558_DIF_32BIT_MODE;
 		break;
 	default:
 		return -EINVAL;
@@ -168,18 +164,15 @@ static int ak5558_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	}
 
 	/* set master/slave audio interface */
-	format = snd_soc_component_read32(component, AK5558_02_CONTROL1);
-	format &= ~AK5558_DIF;
-
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
-		format |= AK5558_DIF_I2S_MODE;
+		format = AK5558_DIF_I2S_MODE;
 		break;
 	case SND_SOC_DAIFMT_LEFT_J:
-		format |= AK5558_DIF_MSB_MODE;
+		format = AK5558_DIF_MSB_MODE;
 		break;
 	case SND_SOC_DAIFMT_DSP_B:
-		format |= AK5558_DIF_MSB_MODE;
+		format = AK5558_DIF_MSB_MODE;
 		break;
 	default:
 		return -EINVAL;
-- 
2.19.0.rc2
