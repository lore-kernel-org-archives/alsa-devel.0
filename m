From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: [PATCH for-3.2 2/2] ASoC: Davinci: Fix FS polarity for
	I2S format
Date: Fri, 30 Sep 2011 10:55:33 +0300
Message-ID: <1317369333-20814-2-git-send-email-jarkko.nikula@bitmer.com>
References: <1317369333-20814-1-git-send-email-jarkko.nikula@bitmer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bitmer.com (bitmer.com [213.157.87.50])
	by alsa0.perex.cz (Postfix) with ESMTP id 9A9CE2413F
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Sep 2011 09:56:41 +0200 (CEST)
In-Reply-To: <1317369333-20814-1-git-send-email-jarkko.nikula@bitmer.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Kevin Hilman <khilman@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Sekhar Nori <nsekhar@ti.com>, Vaibhav Bedia <vaibhav.bedia@ti.com>, Liam Girdwood <lrg@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

Commit 75d9ac4 ("ASoC: Allow DAI formats to be specified in the dai_link")
changed DAI format flag values and we cannot simply invert anymore e.g.
frame-sync with ^= SND_SOC_DAIFMT_NB_IF (which was anyway misuse) as there
is no anymore fixed bit position for bit-clock or frame-sync inversion.

Fix this by relying only on DAI format flag values passed to us and by not
making any assumption on individual bit positions

Signed-off-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: Vaibhav Bedia <vaibhav.bedia@ti.com>
Cc: Sekhar Nori <nsekhar@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
---
I don't have Davinci so only compile tested.
---
 sound/soc/davinci/davinci-i2s.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/sound/soc/davinci/davinci-i2s.c b/sound/soc/davinci/davinci-i2s.c
index d0d60b8..300e121 100644
--- a/sound/soc/davinci/davinci-i2s.c
+++ b/sound/soc/davinci/davinci-i2s.c
@@ -265,6 +265,7 @@ static int davinci_i2s_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 	struct davinci_mcbsp_dev *dev = snd_soc_dai_get_drvdata(cpu_dai);
 	unsigned int pcr;
 	unsigned int srgr;
+	bool inv_fs = false;
 	/* Attention srgr is updated by hw_params! */
 	srgr = DAVINCI_MCBSP_SRGR_FSGM |
 		DAVINCI_MCBSP_SRGR_FPER(DEFAULT_BITPERSAMPLE * 2 - 1) |
@@ -330,7 +331,7 @@ static int davinci_i2s_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 		 * more empty bit clock slots between channels as the sample
 		 * rate is lowered.
 		 */
-		fmt ^= SND_SOC_DAIFMT_NB_IF;
+		inv_fs = true;
 	case SND_SOC_DAIFMT_DSP_A:
 		dev->mode = MOD_DSP_A;
 		break;
@@ -394,6 +395,8 @@ static int davinci_i2s_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 	default:
 		return -EINVAL;
 	}
+	if (inv_fs == true)
+		pcr ^= (DAVINCI_MCBSP_PCR_FSXP | DAVINCI_MCBSP_PCR_FSRP);
 	davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_SRGR_REG, srgr);
 	dev->pcr = pcr;
 	davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_PCR_REG, pcr);
-- 
1.7.6.3
