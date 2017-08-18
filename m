From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 10/13] ALSA: sh: constify snd_pcm_ops structures
Date: Fri, 18 Aug 2017 13:15:18 +0530
Message-ID: <1503042321-26758-9-git-send-email-arvind.yadav.cs@gmail.com>
References: <1503042321-26758-1-git-send-email-arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1503042321-26758-1-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com, johannes@sipsolutions.net, linux@armlinux.org.uk, daniel@zonque.org, clemens@ladisch.de
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

snd_pcm_ops are not supposed to change at runtime. All functions
working with snd_pcm_ops provided by <sound/pcm.h> work with
const snd_pcm_ops. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 sound/sh/aica.c         | 2 +-
 sound/sh/sh_dac_audio.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/sh/aica.c b/sound/sh/aica.c
index ab4802d..c1635f7 100644
--- a/sound/sh/aica.c
+++ b/sound/sh/aica.c
@@ -436,7 +436,7 @@ static unsigned long snd_aicapcm_pcm_pointer(struct snd_pcm_substream
 	return readl(AICA_CONTROL_CHANNEL_SAMPLE_NUMBER);
 }
 
-static struct snd_pcm_ops snd_aicapcm_playback_ops = {
+static const struct snd_pcm_ops snd_aicapcm_playback_ops = {
 	.open = snd_aicapcm_pcm_open,
 	.close = snd_aicapcm_pcm_close,
 	.ioctl = snd_pcm_lib_ioctl,
diff --git a/sound/sh/sh_dac_audio.c b/sound/sh/sh_dac_audio.c
index c1e00ed..b348be9 100644
--- a/sound/sh/sh_dac_audio.c
+++ b/sound/sh/sh_dac_audio.c
@@ -252,7 +252,7 @@ snd_pcm_uframes_t snd_sh_dac_pcm_pointer(struct snd_pcm_substream *substream)
 }
 
 /* pcm ops */
-static struct snd_pcm_ops snd_sh_dac_pcm_ops = {
+static const struct snd_pcm_ops snd_sh_dac_pcm_ops = {
 	.open		= snd_sh_dac_pcm_open,
 	.close		= snd_sh_dac_pcm_close,
 	.ioctl		= snd_pcm_lib_ioctl,
-- 
1.9.1
