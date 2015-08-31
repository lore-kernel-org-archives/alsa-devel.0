From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH] ASoC: fsl_ssi: Fix checking of dai format for
	AC97 mode
Date: Mon, 31 Aug 2015 18:24:09 +0100
Message-ID: <9f62b701350bbb1857b56ba22bb832d7550b676e.1441041757.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.bemta5.messagelabs.com (mail1.bemta5.messagelabs.com
 [195.245.231.138])
 by alsa0.perex.cz (Postfix) with ESMTP id 0DC662604F8
 for <alsa-devel@alsa-project.org>; Mon, 31 Aug 2015 19:24:14 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Timur Tabi <timur@tabi.org>, support.opensource@diasemi.com, Xiubo Li <Xiubo.Lee@gmail.com>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Nicolin Chen <nicoleotsuka@gmail.com>, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

Current code incorrectly treats dai format for AC97 as bit mask
whereas it's actually an integer value. This causes DAI formats
other than AC97 (e.g. DSP_B) to trigger AC97 related code,
which is incorrect and breaks functionality. This patch fixes
the code to correctly compare values to determine AC97 or not.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
---
 sound/soc/fsl/fsl_ssi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index c0b940e..ee47041 100644
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
@@ -945,7 +946,7 @@ static int _fsl_ssi_set_dai_fmt(struct device *dev,
 				CCSR_SSI_SCR_TCH_EN);
 	}
 
-	if (fmt & SND_SOC_DAIFMT_AC97)
+	if ((fmt & SND_SOC_DAIFMT_FORMAT_MASK) == SND_SOC_DAIFMT_AC97)
 		fsl_ssi_setup_ac97(ssi_private);
 
 	return 0;
-- 
1.9.3
