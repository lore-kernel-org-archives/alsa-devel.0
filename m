From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [RESEND PATCH 1/1] ASoC: fsl_ssi: Fix checking of dai format for AC97 mode
Date: Wed, 16 Sep 2015 10:13:19 +0100
Message-ID: <409ab77432bd0553502b75ab98089bb7ecdb5018.1442394728.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Timur Tabi <timur@tabi.org>, Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, support.opensource@diasemi.com
List-Id: alsa-devel@alsa-project.org

Current code incorrectly treats dai format for AC97 as bit mask
whereas it's actually an integer value. This causes DAI formats
other than AC97 (e.g. DSP_B) to trigger AC97 related code,
which is incorrect and breaks functionality. This patch fixes
the code to correctly compare values to determine AC97 or not.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
---

Patch based on v4.3-rc1.

 sound/soc/fsl/fsl_ssi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 8ec6fb2..37c5cd4 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -249,7 +249,8 @@ MODULE_DEVICE_TABLE(of, fsl_ssi_ids);
 
 static bool fsl_ssi_is_ac97(struct fsl_ssi_private *ssi_private)
 {
-	return !!(ssi_private->dai_fmt & SND_SOC_DAIFMT_AC97);
+	return (ssi_private->dai_fmt & SND_SOC_DAIFMT_FORMAT_MASK) ==
+		SND_SOC_DAIFMT_AC97;
 }
 
 static bool fsl_ssi_is_i2s_master(struct fsl_ssi_private *ssi_private)
@@ -947,7 +948,7 @@ static int _fsl_ssi_set_dai_fmt(struct device *dev,
 				CCSR_SSI_SCR_TCH_EN);
 	}
 
-	if (fmt & SND_SOC_DAIFMT_AC97)
+	if ((fmt & SND_SOC_DAIFMT_FORMAT_MASK) == SND_SOC_DAIFMT_AC97)
 		fsl_ssi_setup_ac97(ssi_private);
 
 	return 0;
-- 
1.9.3
