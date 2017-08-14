From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 04/10] ASoC: intel: constify snd_pcm_ops structures
Date: Mon, 14 Aug 2017 11:26:27 +0530
Message-ID: <1502690193-29059-5-git-send-email-arvind.yadav.cs@gmail.com>
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
 sound/soc/intel/baytrail/sst-baytrail-pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/baytrail/sst-baytrail-pcm.c b/sound/soc/intel/baytrail/sst-baytrail-pcm.c
index 4765ad4..0bdc057 100644
--- a/sound/soc/intel/baytrail/sst-baytrail-pcm.c
+++ b/sound/soc/intel/baytrail/sst-baytrail-pcm.c
@@ -309,7 +309,7 @@ static int sst_byt_pcm_mmap(struct snd_pcm_substream *substream,
 	return snd_pcm_lib_default_mmap(substream, vma);
 }
 
-static struct snd_pcm_ops sst_byt_pcm_ops = {
+static const struct snd_pcm_ops sst_byt_pcm_ops = {
 	.open		= sst_byt_pcm_open,
 	.close		= sst_byt_pcm_close,
 	.ioctl		= snd_pcm_lib_ioctl,
-- 
1.9.1
