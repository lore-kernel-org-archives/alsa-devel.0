From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 03/13] ALSA: atmel: constify snd_pcm_ops structures
Date: Fri, 18 Aug 2017 13:15:11 +0530
Message-ID: <1503042321-26758-4-git-send-email-arvind.yadav.cs@gmail.com>
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
 sound/atmel/ac97c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/atmel/ac97c.c b/sound/atmel/ac97c.c
index 52b0522..70616da 100644
--- a/sound/atmel/ac97c.c
+++ b/sound/atmel/ac97c.c
@@ -461,7 +461,7 @@ static int atmel_ac97c_capture_prepare(struct snd_pcm_substream *substream)
 	return frames;
 }
 
-static struct snd_pcm_ops atmel_ac97_playback_ops = {
+static const struct snd_pcm_ops atmel_ac97_playback_ops = {
 	.open		= atmel_ac97c_playback_open,
 	.close		= atmel_ac97c_playback_close,
 	.ioctl		= snd_pcm_lib_ioctl,
@@ -472,7 +472,7 @@ static int atmel_ac97c_capture_prepare(struct snd_pcm_substream *substream)
 	.pointer	= atmel_ac97c_playback_pointer,
 };
 
-static struct snd_pcm_ops atmel_ac97_capture_ops = {
+static const struct snd_pcm_ops atmel_ac97_capture_ops = {
 	.open		= atmel_ac97c_capture_open,
 	.close		= atmel_ac97c_capture_close,
 	.ioctl		= snd_pcm_lib_ioctl,
-- 
1.9.1
