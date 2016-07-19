From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: [PATCH 2/2] ASoC: cs53l30: Fix bit shift issue of TDM mode
Date: Tue, 19 Jul 2016 15:36:14 -0700
Message-ID: <1468967774-18621-2-git-send-email-nicoleotsuka@gmail.com>
References: <1468967774-18621-1-git-send-email-nicoleotsuka@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1468967774-18621-1-git-send-email-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: lgirdwood@gmail.com, brian.austin@cirrus.com, Paul.Handrigan@cirrus.com, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The TDM mode using PCM format now has two-bit right shift due to the
format configuration in the driver. According to Figure 4-13 in the
CS53L30 datasheet, using ASP_SCLK_INV = 0 and SHIFT_LEFT = 1 should
be the correct combination to create one-bit right shift for the DSP
type A format.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 sound/soc/codecs/cs53l30.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/cs53l30.c b/sound/soc/codecs/cs53l30.c
index fd5502e..2c0d9c4 100644
--- a/sound/soc/codecs/cs53l30.c
+++ b/sound/soc/codecs/cs53l30.c
@@ -592,8 +592,12 @@ static int cs53l30_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 		aspctl1 |= CS53L30_ASP_TDM_PDN;
 		break;
 	case SND_SOC_DAIFMT_DSP_A:
-		/* Clear TDM_PDN and SHIFT_LEFT, invert SCLK */
-		aspcfg |= CS53L30_ASP_SCLK_INV;
+		/*
+		 * Clear TDM_PDN to turn on TDM mode; Use ASP_SCLK_INV = 0
+		 * with SHIFT_LEFT = 1 combination as Figure 4-13 shows in
+		 * the CS53L30 datasheet
+		 */
+		aspctl1 |= CS53L30_SHIFT_LEFT;
 		break;
 	default:
 		return -EINVAL;
-- 
2.1.4
