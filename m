From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH trivial] ASoC: fsl_esai: Spelling s/specifially/specifically/
Date: Thu, 21 May 2015 14:02:18 +0200
Message-ID: <1432209738-20877-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Timur Tabi <timur@tabi.org>, Takashi Iwai <tiwai@suse.de>, Jiri Kosina <trivial@kernel.org>
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 sound/soc/fsl/fsl_esai.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
index 5c7597191e3ffc68..45eee131c47d43cd 100644
--- a/sound/soc/fsl/fsl_esai.c
+++ b/sound/soc/fsl/fsl_esai.c
@@ -517,7 +517,7 @@ static int fsl_esai_hw_params(struct snd_pcm_substream *substream,
 	u32 bclk, mask, val;
 	int ret;
 
-	/* Override slot_width if being specifially set */
+	/* Override slot_width if being specifically set */
 	if (esai_priv->slot_width)
 		slot_width = esai_priv->slot_width;
 
-- 
1.9.1
