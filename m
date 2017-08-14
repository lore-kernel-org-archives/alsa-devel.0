From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 02/10] ASoC: blackfin: constify snd_pcm_ops structures
Date: Mon, 14 Aug 2017 11:26:25 +0530
Message-ID: <1502690193-29059-3-git-send-email-arvind.yadav.cs@gmail.com>
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
 sound/soc/blackfin/bf5xx-ac97-pcm.c | 2 +-
 sound/soc/blackfin/bf5xx-i2s-pcm.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/blackfin/bf5xx-ac97-pcm.c b/sound/soc/blackfin/bf5xx-ac97-pcm.c
index 913e292..8c1d198 100644
--- a/sound/soc/blackfin/bf5xx-ac97-pcm.c
+++ b/sound/soc/blackfin/bf5xx-ac97-pcm.c
@@ -308,7 +308,7 @@ static	int bf5xx_pcm_copy_user(struct snd_pcm_substream *substream,
 }
 #endif
 
-static struct snd_pcm_ops bf5xx_pcm_ac97_ops = {
+static const struct snd_pcm_ops bf5xx_pcm_ac97_ops = {
 	.open		= bf5xx_pcm_open,
 	.ioctl		= snd_pcm_lib_ioctl,
 	.hw_params	= bf5xx_pcm_hw_params,
diff --git a/sound/soc/blackfin/bf5xx-i2s-pcm.c b/sound/soc/blackfin/bf5xx-i2s-pcm.c
index 470d99a..51cae76 100644
--- a/sound/soc/blackfin/bf5xx-i2s-pcm.c
+++ b/sound/soc/blackfin/bf5xx-i2s-pcm.c
@@ -318,7 +318,7 @@ static int bf5xx_pcm_silence(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static struct snd_pcm_ops bf5xx_pcm_i2s_ops = {
+static const struct snd_pcm_ops bf5xx_pcm_i2s_ops = {
 	.open		= bf5xx_pcm_open,
 	.ioctl		= snd_pcm_lib_ioctl,
 	.hw_params	= bf5xx_pcm_hw_params,
-- 
1.9.1
