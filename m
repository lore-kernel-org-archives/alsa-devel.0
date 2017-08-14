From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 08/10] ASoC: samsung: constify snd_pcm_ops structures
Date: Mon, 14 Aug 2017 11:26:31 +0530
Message-ID: <1502690193-29059-9-git-send-email-arvind.yadav.cs@gmail.com>
References: <1502690193-29059-1-git-send-email-arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1502690193-29059-1-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

snd_pcm_ops are not supposed to change at runtime. All functions
working with snd_pcm_ops provided by <sound/soc.h> work with
const snd_pcm_ops. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 sound/soc/samsung/idma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/samsung/idma.c b/sound/soc/samsung/idma.c
index 3e40815..5c59c95 100644
--- a/sound/soc/samsung/idma.c
+++ b/sound/soc/samsung/idma.c
@@ -325,7 +325,7 @@ static int idma_close(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-static struct snd_pcm_ops idma_ops = {
+static const struct snd_pcm_ops idma_ops = {
 	.open		= idma_open,
 	.close		= idma_close,
 	.ioctl		= snd_pcm_lib_ioctl,
-- 
1.9.1
