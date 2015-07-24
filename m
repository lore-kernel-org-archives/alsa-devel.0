From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cs4265: Fix setting dai format for
	Left/Right Justified" to the asoc tree
Date: Fri, 24 Jul 2015 18:31:59 +0100
Message-ID: <E1ZIgpD-0001mL-Bp@debutante>
References: <1437278956.20103.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6481515673285324939=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D8F922605E4
 for <alsa-devel@alsa-project.org>; Fri, 24 Jul 2015 19:32:05 +0200 (CEST)
In-Reply-To: <1437278956.20103.1.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--===============6481515673285324939==
Content-Type: text/plain

The patch

   ASoC: cs4265: Fix setting dai format for Left/Right Justified

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

>From bffc4496886683fac86d31e5d0cf9a22f8044e3d Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Sun, 19 Jul 2015 12:09:16 +0800
Subject: [PATCH] ASoC: cs4265: Fix setting dai format for Left/Right Justified
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The settings in current code does not match the datasheet, fix it.

DAC Control - Address 03h

DAC Digital Interface Format (Bits 5:4)
        DAC_DIF1 DAC_DIF0 Description
        0        0        Left Justified, up to 24-bit data (default)
        0        1        I²S, up to 24-bit data
        1        0        Right-Justified, 16-bit Data
        1        1        Right-Justified, 24-bit Data

Transmitter Control 2 - Address 12h

Transmitter Digital Interface Format (Bits 7:6)
        Tx_DIF1 Tx_DIF0 Description Format Figure
        0       0       Left Justified, up to 24-bit data (default)
        0       1       I²S, up to 24-bit data
        1       0       Right-Justified, 16-bit Data
        1       1       Right-Justified, 24-bit Data

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs4265.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/cs4265.c b/sound/soc/codecs/cs4265.c
index d7ec4756e45b..8e36198474d9 100644
--- a/sound/soc/codecs/cs4265.c
+++ b/sound/soc/codecs/cs4265.c
@@ -457,14 +457,14 @@ static int cs4265_pcm_hw_params(struct snd_pcm_substream *substream,
 	case SND_SOC_DAIFMT_RIGHT_J:
 		if (params_width(params) == 16) {
 			snd_soc_update_bits(codec, CS4265_DAC_CTL,
-				CS4265_DAC_CTL_DIF, (1 << 5));
+				CS4265_DAC_CTL_DIF, (2 << 4));
 			snd_soc_update_bits(codec, CS4265_SPDIF_CTL2,
-				CS4265_SPDIF_CTL2_DIF, (1 << 7));
+				CS4265_SPDIF_CTL2_DIF, (2 << 6));
 		} else {
 			snd_soc_update_bits(codec, CS4265_DAC_CTL,
-				CS4265_DAC_CTL_DIF, (3 << 5));
+				CS4265_DAC_CTL_DIF, (3 << 4));
 			snd_soc_update_bits(codec, CS4265_SPDIF_CTL2,
-				CS4265_SPDIF_CTL2_DIF, (1 << 7));
+				CS4265_SPDIF_CTL2_DIF, (3 << 6));
 		}
 		break;
 	case SND_SOC_DAIFMT_LEFT_J:
@@ -473,7 +473,7 @@ static int cs4265_pcm_hw_params(struct snd_pcm_substream *substream,
 		snd_soc_update_bits(codec, CS4265_ADC_CTL,
 			CS4265_ADC_DIF, 0);
 		snd_soc_update_bits(codec, CS4265_SPDIF_CTL2,
-			CS4265_SPDIF_CTL2_DIF, (1 << 6));
+			CS4265_SPDIF_CTL2_DIF, 0);
 
 		break;
 	default:
-- 
2.1.4


--===============6481515673285324939==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6481515673285324939==--
