From: Codrut Grosu <codrut.cristian.grosu@gmail.com>
Subject: [PATCH] ASoC: ux500: Added blank line after declarations
Date: Sat, 25 Feb 2017 21:50:21 +0200
Message-ID: <1488052221-9384-1-git-send-email-codrut.cristian.grosu@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com
Cc: lgirdwood@gmail.com, broonie@kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, colin.king@canonical.com, Codrut Grosu <codrut.cristian.grosu@gmail.com>
List-Id: alsa-devel@alsa-project.org

This was reported by checkpatch.pl

Signed-off-by: Codrut GROSU <codrut.cristian.grosu@gmail.com>
---
 sound/soc/ux500/ux500_msp_dai.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/ux500/ux500_msp_dai.c b/sound/soc/ux500/ux500_msp_dai.c
index 36e9bb2..ec5152a 100644
--- a/sound/soc/ux500/ux500_msp_dai.c
+++ b/sound/soc/ux500/ux500_msp_dai.c
@@ -133,6 +133,7 @@ static int setup_pcm_framing(struct snd_soc_dai *dai, unsigned int rate,
 	struct ux500_msp_i2s_drvdata *drvdata = dev_get_drvdata(dai->dev);

 	u32 frame_length = MSP_FRAME_LEN_1;
+
 	prot_desc->frame_width = 0;

 	switch (drvdata->slots) {
--
1.9.1
