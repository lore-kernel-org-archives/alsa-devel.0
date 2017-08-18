From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 01/13] ALSA: aoa: constify snd_pcm_ops structures
Date: Fri, 18 Aug 2017 13:15:09 +0530
Message-ID: <1503042321-26758-2-git-send-email-arvind.yadav.cs@gmail.com>
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
 sound/aoa/soundbus/i2sbus/pcm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/aoa/soundbus/i2sbus/pcm.c b/sound/aoa/soundbus/i2sbus/pcm.c
index 053b09c..e618531 100644
--- a/sound/aoa/soundbus/i2sbus/pcm.c
+++ b/sound/aoa/soundbus/i2sbus/pcm.c
@@ -778,7 +778,7 @@ static snd_pcm_uframes_t i2sbus_playback_pointer(struct snd_pcm_substream
 	return i2sbus_pcm_pointer(i2sdev, 0);
 }
 
-static struct snd_pcm_ops i2sbus_playback_ops = {
+static const struct snd_pcm_ops i2sbus_playback_ops = {
 	.open =		i2sbus_playback_open,
 	.close =	i2sbus_playback_close,
 	.ioctl =	snd_pcm_lib_ioctl,
@@ -848,7 +848,7 @@ static snd_pcm_uframes_t i2sbus_record_pointer(struct snd_pcm_substream
 	return i2sbus_pcm_pointer(i2sdev, 1);
 }
 
-static struct snd_pcm_ops i2sbus_record_ops = {
+static const struct snd_pcm_ops i2sbus_record_ops = {
 	.open =		i2sbus_record_open,
 	.close =	i2sbus_record_close,
 	.ioctl =	snd_pcm_lib_ioctl,
-- 
1.9.1
