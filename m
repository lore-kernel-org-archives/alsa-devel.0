From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 10/10] ASoC: txx9: constify snd_pcm_ops structures
Date: Mon, 14 Aug 2017 11:26:33 +0530
Message-ID: <1502690193-29059-11-git-send-email-arvind.yadav.cs@gmail.com>
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
 sound/soc/txx9/txx9aclc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/txx9/txx9aclc.c b/sound/soc/txx9/txx9aclc.c
index 7912bf0..2e82d06 100644
--- a/sound/soc/txx9/txx9aclc.c
+++ b/sound/soc/txx9/txx9aclc.c
@@ -271,7 +271,7 @@ static int txx9aclc_pcm_close(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-static struct snd_pcm_ops txx9aclc_pcm_ops = {
+static const struct snd_pcm_ops txx9aclc_pcm_ops = {
 	.open		= txx9aclc_pcm_open,
 	.close		= txx9aclc_pcm_close,
 	.ioctl		= snd_pcm_lib_ioctl,
-- 
1.9.1
