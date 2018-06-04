From: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
Subject: [alsa-devel][PATCH 1/3] ASoC: TSCS42xx: Add mic bias boost control
Date: Mon, 4 Jun 2018 15:45:40 -0500
Message-ID: <91e206cbabd7c7a7c8d7715b5e51ffef384ac6ec.1528143829.git.steven.eckhoff.opensource@gmail.com>
References: <cover.1528143829.git.steven.eckhoff.opensource@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1528143829.git.steven.eckhoff.opensource@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Add mic bias boost control

Signed-off-by: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
---
 sound/soc/codecs/tscs42xx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/tscs42xx.c b/sound/soc/codecs/tscs42xx.c
index bbfc73a79b18..15505c3c9ed4 100644
--- a/sound/soc/codecs/tscs42xx.c
+++ b/sound/soc/codecs/tscs42xx.c
@@ -638,6 +638,9 @@ static const struct snd_kcontrol_new tscs42xx_snd_controls[] = {
 	/* Input Channel Map */
 	SOC_ENUM("Input Channel Map", ch_map_select_enum),
 
+	/* Mic Bias */
+	SOC_SINGLE("Mic Bias Boost Switch", 0x71, 0x07, 1, 0),
+
 	/* Coefficient Ram */
 	COEFF_RAM_CTL("Cascade1L BiQuad1", BIQUAD_SIZE, 0x00),
 	COEFF_RAM_CTL("Cascade1L BiQuad2", BIQUAD_SIZE, 0x05),
-- 
2.17.0
