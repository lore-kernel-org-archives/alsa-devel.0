From: Nicolin Chen <b42378@freescale.com>
Subject: [PATCH v2 1/2] ASoC: fsl: imx-wm8962: Don't update bias_level in machine driver
Date: Fri, 6 Dec 2013 23:38:28 +0800
Message-ID: <68a5b5c0d53260f190b58daf3e3a0b492148ed62.1386344000.git.b42378@freescale.com>
References: <cover.1386344000.git.b42378@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1386344000.git.b42378@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, perex@perex.cz, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

If we update it here, the set_bias_level() of Codec driver won't be normally
called and we will then miss some essential procedures in set_bias_level() of
the Codec driver. Thus drop it.

Signed-off-by: Nicolin Chen <b42378@freescale.com>
---
 sound/soc/fsl/imx-wm8962.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/fsl/imx-wm8962.c b/sound/soc/fsl/imx-wm8962.c
index 61e4885..3fd76bc 100644
--- a/sound/soc/fsl/imx-wm8962.c
+++ b/sound/soc/fsl/imx-wm8962.c
@@ -130,8 +130,6 @@ static int imx_wm8962_set_bias_level(struct snd_soc_card *card,
 		break;
 	}
 
-	dapm->bias_level = level;
-
 	return 0;
 }
 
-- 
1.8.4
