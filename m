From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 07/10] ASoC: pxa: constify snd_pcm_ops structures
Date: Mon, 14 Aug 2017 11:26:30 +0530
Message-ID: <1502690193-29059-8-git-send-email-arvind.yadav.cs@gmail.com>
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
 sound/soc/pxa/mmp-pcm.c    | 2 +-
 sound/soc/pxa/pxa2xx-pcm.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/pxa/mmp-pcm.c b/sound/soc/pxa/mmp-pcm.c
index 5b5f1a4..e25f1c2 100644
--- a/sound/soc/pxa/mmp-pcm.c
+++ b/sound/soc/pxa/mmp-pcm.c
@@ -131,7 +131,7 @@ static int mmp_pcm_mmap(struct snd_pcm_substream *substream,
 		vma->vm_end - vma->vm_start, vma->vm_page_prot);
 }
 
-static struct snd_pcm_ops mmp_pcm_ops = {
+static const struct snd_pcm_ops mmp_pcm_ops = {
 	.open		= mmp_pcm_open,
 	.close		= snd_dmaengine_pcm_close_release_chan,
 	.ioctl		= snd_pcm_lib_ioctl,
diff --git a/sound/soc/pxa/pxa2xx-pcm.c b/sound/soc/pxa/pxa2xx-pcm.c
index b51d7a0..357981c 100644
--- a/sound/soc/pxa/pxa2xx-pcm.c
+++ b/sound/soc/pxa/pxa2xx-pcm.c
@@ -45,7 +45,7 @@ static int pxa2xx_pcm_hw_free(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-static struct snd_pcm_ops pxa2xx_pcm_ops = {
+static const struct snd_pcm_ops pxa2xx_pcm_ops = {
 	.open		= __pxa2xx_pcm_open,
 	.close		= __pxa2xx_pcm_close,
 	.ioctl		= snd_pcm_lib_ioctl,
-- 
1.9.1
