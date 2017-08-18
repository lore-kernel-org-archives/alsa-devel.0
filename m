From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 04/13] ALSA: drivers: constify snd_pcm_ops structures
Date: Fri, 18 Aug 2017 13:15:12 +0530
Message-ID: <1503042321-26758-5-git-send-email-arvind.yadav.cs@gmail.com>
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
 sound/drivers/aloop.c        | 4 ++--
 sound/drivers/ml403-ac97cr.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/drivers/aloop.c b/sound/drivers/aloop.c
index 54f348a..f9f0edf 100644
--- a/sound/drivers/aloop.c
+++ b/sound/drivers/aloop.c
@@ -750,7 +750,7 @@ static int loopback_close(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-static struct snd_pcm_ops loopback_playback_ops = {
+static const struct snd_pcm_ops loopback_playback_ops = {
 	.open =		loopback_open,
 	.close =	loopback_close,
 	.ioctl =	snd_pcm_lib_ioctl,
@@ -763,7 +763,7 @@ static int loopback_close(struct snd_pcm_substream *substream)
 	.mmap =		snd_pcm_lib_mmap_vmalloc,
 };
 
-static struct snd_pcm_ops loopback_capture_ops = {
+static const struct snd_pcm_ops loopback_capture_ops = {
 	.open =		loopback_open,
 	.close =	loopback_close,
 	.ioctl =	snd_pcm_lib_ioctl,
diff --git a/sound/drivers/ml403-ac97cr.c b/sound/drivers/ml403-ac97cr.c
index bdcb572..8195ae8 100644
--- a/sound/drivers/ml403-ac97cr.c
+++ b/sound/drivers/ml403-ac97cr.c
@@ -759,7 +759,7 @@ static int snd_ml403_ac97cr_capture_close(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-static struct snd_pcm_ops snd_ml403_ac97cr_playback_ops = {
+static const struct snd_pcm_ops snd_ml403_ac97cr_playback_ops = {
 	.open = snd_ml403_ac97cr_playback_open,
 	.close = snd_ml403_ac97cr_playback_close,
 	.ioctl = snd_pcm_lib_ioctl,
@@ -770,7 +770,7 @@ static int snd_ml403_ac97cr_capture_close(struct snd_pcm_substream *substream)
 	.pointer = snd_ml403_ac97cr_pcm_pointer,
 };
 
-static struct snd_pcm_ops snd_ml403_ac97cr_capture_ops = {
+static const struct snd_pcm_ops snd_ml403_ac97cr_capture_ops = {
 	.open = snd_ml403_ac97cr_capture_open,
 	.close = snd_ml403_ac97cr_capture_close,
 	.ioctl = snd_pcm_lib_ioctl,
-- 
1.9.1
