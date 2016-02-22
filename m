From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH] ASoC: fix memory leak
Date: Mon, 22 Feb 2016 14:14:31 +0530
Message-ID: <1456130671-12365-1-git-send-email-sudipm.mukherjee@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>
List-Id: alsa-devel@alsa-project.org

If dai_link is already bound then we just returned and leaked rtd and
rtd->codec_dais which were allocated by soc_new_pcm_runtime(). We do not
need this newly allocated rtd to check if dai_link is already binded. Lets
check first if it is already binded before allocating this memory.

Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
---
 sound/soc/soc-core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 790ee2b..d2e62b15 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -986,16 +986,16 @@ static int soc_bind_dai_link(struct snd_soc_card *card,
 
 	dev_dbg(card->dev, "ASoC: binding %s\n", dai_link->name);
 
-	rtd = soc_new_pcm_runtime(card, dai_link);
-	if (!rtd)
-		return -ENOMEM;
-
 	if (soc_is_dai_link_bound(card, dai_link)) {
 		dev_dbg(card->dev, "ASoC: dai link %s already bound\n",
 			dai_link->name);
 		return 0;
 	}
 
+	rtd = soc_new_pcm_runtime(card, dai_link);
+	if (!rtd)
+		return -ENOMEM;
+
 	cpu_dai_component.name = dai_link->cpu_name;
 	cpu_dai_component.of_node = dai_link->cpu_of_node;
 	cpu_dai_component.dai_name = dai_link->cpu_dai_name;
-- 
1.9.1
