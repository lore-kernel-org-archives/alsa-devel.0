From: Colin King <colin.king@canonical.com>
Subject: [PATCH] ALSA: pcm: remove redundant variable runtime
Date: Sun, 15 Oct 2017 22:06:44 +0100
Message-ID: <20171015210644.15565-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

An earlier commit removed the access to variable runtime
and we are now left with unused variable that is redundant,
so remove it.

Cleans up the clang warning: Value stored to 'runtime' is never read

Fixes: e11f0f90a626 ("ALSA: pcm: remove SNDRV_PCM_IOCTL1_INFO internal command")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/core/pcm_native.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 2fec2feac387..a4d92e46c459 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -195,7 +195,6 @@ EXPORT_SYMBOL_GPL(snd_pcm_stream_unlock_irqrestore);
 
 int snd_pcm_info(struct snd_pcm_substream *substream, struct snd_pcm_info *info)
 {
-	struct snd_pcm_runtime *runtime;
 	struct snd_pcm *pcm = substream->pcm;
 	struct snd_pcm_str *pstr = substream->pstr;
 
@@ -211,7 +210,6 @@ int snd_pcm_info(struct snd_pcm_substream *substream, struct snd_pcm_info *info)
 	info->subdevices_count = pstr->substream_count;
 	info->subdevices_avail = pstr->substream_count - pstr->substream_opened;
 	strlcpy(info->subname, substream->name, sizeof(info->subname));
-	runtime = substream->runtime;
 
 	return 0;
 }
-- 
2.14.1
