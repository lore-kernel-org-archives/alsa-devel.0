From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH] ASoC: rsnd: Fix duplicate const for DVC ramp rates
Date: Tue, 24 Mar 2015 11:47:43 +0100
Message-ID: <1427194063-31572-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
List-Id: alsa-devel@alsa-project.org

Replace duplicated const keyword for 'dvc_ramp_rate' with proper
array of const pointers to const strings.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 sound/soc/sh/rcar/dvc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sh/rcar/dvc.c b/sound/soc/sh/rcar/dvc.c
index aeeef1352eee..6d85e36c6c2b 100644
--- a/sound/soc/sh/rcar/dvc.c
+++ b/sound/soc/sh/rcar/dvc.c
@@ -36,7 +36,7 @@ struct rsnd_dvc {
 	     ((pos) = (struct rsnd_dvc *)(priv)->dvc + i);	\
 	     i++)
 
-static const char const *dvc_ramp_rate[] = {
+static const char * const dvc_ramp_rate[] = {
 	"128 dB/1 step",	 /* 00000 */
 	"64 dB/1 step",		 /* 00001 */
 	"32 dB/1 step",		 /* 00010 */
-- 
1.9.1
