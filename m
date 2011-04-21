From: Ben Gardiner <bengardiner@nanometrics.ca>
Subject: [PATCH 2/4] davinci-mcasp: use bitfield definitions for PDIR
Date: Thu, 21 Apr 2011 14:19:02 -0400
Message-ID: <2541e7e4e115b2d54a1f785fc0f603b6a6e9a526.1303408522.git.bengardiner@nanometrics.ca>
References: <cover.1303408522.git.bengardiner@nanometrics.ca>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1303408522.git.bengardiner@nanometrics.ca>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lrg@slimlogic.co.uk>, alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Sekhar Nori <nsekhar@ti.com>, davinci-linux-open-source@linux.davincidsp.com, James Nuss <jamesnuss@nanometrics.ca>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The current driver creates value for set/clr of PDIR using (x<<26) instead
of the #defines that are convieniently made available.

Update the driver to use the bitfield definitions of PDIR. There is no
functional change introduced by this patch.

Signed-off-by: Ben Gardiner <bengardiner@nanometrics.ca>
Reviewed-by: James Nuss <jamesnuss@nanometrics.ca>
---
 sound/soc/davinci/davinci-mcasp.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index e595756..1aa24a1 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -434,7 +434,8 @@ static int davinci_mcasp_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 		mcasp_set_bits(base + DAVINCI_MCASP_ACLKRCTL_REG, ACLKRE);
 		mcasp_set_bits(base + DAVINCI_MCASP_RXFMCTL_REG, AFSRE);
 
-		mcasp_set_bits(base + DAVINCI_MCASP_PDIR_REG, (0x7 << 26));
+		mcasp_set_bits(base + DAVINCI_MCASP_PDIR_REG,
+				ACLKX | AHCLKX | AFSX);
 		break;
 	case SND_SOC_DAIFMT_CBM_CFS:
 		/* codec is clock master and frame slave */
@@ -444,7 +445,8 @@ static int davinci_mcasp_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 		mcasp_set_bits(base + DAVINCI_MCASP_ACLKRCTL_REG, ACLKRE);
 		mcasp_set_bits(base + DAVINCI_MCASP_RXFMCTL_REG, AFSRE);
 
-		mcasp_set_bits(base + DAVINCI_MCASP_PDIR_REG, (0x2d << 26));
+		mcasp_set_bits(base + DAVINCI_MCASP_PDIR_REG,
+				ACLKX | AFSX | ACLKR | AFSR);
 		break;
 	case SND_SOC_DAIFMT_CBM_CFM:
 		/* codec is clock and frame master */
@@ -454,7 +456,8 @@ static int davinci_mcasp_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 		mcasp_clr_bits(base + DAVINCI_MCASP_ACLKRCTL_REG, ACLKRE);
 		mcasp_clr_bits(base + DAVINCI_MCASP_RXFMCTL_REG, AFSRE);
 
-		mcasp_clr_bits(base + DAVINCI_MCASP_PDIR_REG, (0x3f << 26));
+		mcasp_clr_bits(base + DAVINCI_MCASP_PDIR_REG,
+				ACLKX | AHCLKX | AFSX | ACLKR | AHCLKR | AFSR);
 		break;
 
 	default:
-- 
1.7.1
