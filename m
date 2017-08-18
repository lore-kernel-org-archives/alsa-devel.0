From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 13/13] ALSA: usb: constify snd_pcm_ops structures
Date: Fri, 18 Aug 2017 13:15:21 +0530
Message-ID: <a6ce54c995eb3ce68bf6231ccc9a2ccee17ec023.1503040251.git.arvind.yadav.cs@gmail.com>
References: <1503042321-26758-1-git-send-email-arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1503042321-26758-1-git-send-email-arvind.yadav.cs@gmail.com>
In-Reply-To: <19589e15b10f062109b5e90c9c253aefb2d3819c.1503040251.git.arvind.yadav.cs@gmail.com>
References: <19589e15b10f062109b5e90c9c253aefb2d3819c.1503040251.git.arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com, johannes@sipsolutions.net, linux@armlinux.org.uk, daniel@zonque.org, clemens@ladisch.de
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

snd_pcm_ops are not supposed to change at runtime. All functions
working with snd_pcm_ops provided by <sound/pcm.h> work with
const snd_pcm_ops. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 sound/usb/6fire/pcm.c           | 2 +-
 sound/usb/caiaq/audio.c         | 2 +-
 sound/usb/hiface/pcm.c          | 2 +-
 sound/usb/misc/ua101.c          | 4 ++--
 sound/usb/pcm.c                 | 4 ++--
 sound/usb/usx2y/usbusx2yaudio.c | 2 +-
 sound/usb/usx2y/usx2yhwdeppcm.c | 2 +-
 7 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/sound/usb/6fire/pcm.c b/sound/usb/6fire/pcm.c
index 36f4115..224a6a5 100644
--- a/sound/usb/6fire/pcm.c
+++ b/sound/usb/6fire/pcm.c
@@ -555,7 +555,7 @@ static snd_pcm_uframes_t usb6fire_pcm_pointer(
 	return ret;
 }
 
-static struct snd_pcm_ops pcm_ops = {
+static const struct snd_pcm_ops pcm_ops = {
 	.open = usb6fire_pcm_open,
 	.close = usb6fire_pcm_close,
 	.ioctl = snd_pcm_lib_ioctl,
diff --git a/sound/usb/caiaq/audio.c b/sound/usb/caiaq/audio.c
index 8f66ba7..af5ad84 100644
--- a/sound/usb/caiaq/audio.c
+++ b/sound/usb/caiaq/audio.c
@@ -338,7 +338,7 @@ static int snd_usb_caiaq_pcm_trigger(struct snd_pcm_substream *sub, int cmd)
 }
 
 /* operators for both playback and capture */
-static struct snd_pcm_ops snd_usb_caiaq_ops = {
+static const struct snd_pcm_ops snd_usb_caiaq_ops = {
 	.open =		snd_usb_caiaq_substream_open,
 	.close =	snd_usb_caiaq_substream_close,
 	.ioctl =	snd_pcm_lib_ioctl,
diff --git a/sound/usb/hiface/pcm.c b/sound/usb/hiface/pcm.c
index 33db205..175d8d6 100644
--- a/sound/usb/hiface/pcm.c
+++ b/sound/usb/hiface/pcm.c
@@ -513,7 +513,7 @@ static snd_pcm_uframes_t hiface_pcm_pointer(struct snd_pcm_substream *alsa_sub)
 	return bytes_to_frames(alsa_sub->runtime, dma_offset);
 }
 
-static struct snd_pcm_ops pcm_ops = {
+static const struct snd_pcm_ops pcm_ops = {
 	.open = hiface_pcm_open,
 	.close = hiface_pcm_close,
 	.ioctl = snd_pcm_lib_ioctl,
diff --git a/sound/usb/misc/ua101.c b/sound/usb/misc/ua101.c
index c19a5dd..71a0e9e 100644
--- a/sound/usb/misc/ua101.c
+++ b/sound/usb/misc/ua101.c
@@ -890,7 +890,7 @@ static snd_pcm_uframes_t playback_pcm_pointer(struct snd_pcm_substream *subs)
 	return ua101_pcm_pointer(ua, &ua->playback);
 }
 
-static struct snd_pcm_ops capture_pcm_ops = {
+static const struct snd_pcm_ops capture_pcm_ops = {
 	.open = capture_pcm_open,
 	.close = capture_pcm_close,
 	.ioctl = snd_pcm_lib_ioctl,
@@ -903,7 +903,7 @@ static snd_pcm_uframes_t playback_pcm_pointer(struct snd_pcm_substream *subs)
 	.mmap = snd_pcm_lib_mmap_vmalloc,
 };
 
-static struct snd_pcm_ops playback_pcm_ops = {
+static const struct snd_pcm_ops playback_pcm_ops = {
 	.open = playback_pcm_open,
 	.close = playback_pcm_close,
 	.ioctl = snd_pcm_lib_ioctl,
diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index 9aa5b18..f9634c9 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -1690,7 +1690,7 @@ static int snd_usb_substream_capture_trigger(struct snd_pcm_substream *substream
 	return -EINVAL;
 }
 
-static struct snd_pcm_ops snd_usb_playback_ops = {
+static const struct snd_pcm_ops snd_usb_playback_ops = {
 	.open =		snd_usb_playback_open,
 	.close =	snd_usb_playback_close,
 	.ioctl =	snd_pcm_lib_ioctl,
@@ -1703,7 +1703,7 @@ static int snd_usb_substream_capture_trigger(struct snd_pcm_substream *substream
 	.mmap =		snd_pcm_lib_mmap_vmalloc,
 };
 
-static struct snd_pcm_ops snd_usb_capture_ops = {
+static const struct snd_pcm_ops snd_usb_capture_ops = {
 	.open =		snd_usb_capture_open,
 	.close =	snd_usb_capture_close,
 	.ioctl =	snd_pcm_lib_ioctl,
diff --git a/sound/usb/usx2y/usbusx2yaudio.c b/sound/usb/usx2y/usbusx2yaudio.c
index dd40ca9..f412d8b 100644
--- a/sound/usb/usx2y/usbusx2yaudio.c
+++ b/sound/usb/usx2y/usbusx2yaudio.c
@@ -907,7 +907,7 @@ static int snd_usX2Y_pcm_close(struct snd_pcm_substream *substream)
 }
 
 
-static struct snd_pcm_ops snd_usX2Y_pcm_ops = 
+static const struct snd_pcm_ops snd_usX2Y_pcm_ops =
 {
 	.open =		snd_usX2Y_pcm_open,
 	.close =	snd_usX2Y_pcm_close,
diff --git a/sound/usb/usx2y/usx2yhwdeppcm.c b/sound/usb/usx2y/usx2yhwdeppcm.c
index d51c7fd..0d05052 100644
--- a/sound/usb/usx2y/usx2yhwdeppcm.c
+++ b/sound/usb/usx2y/usx2yhwdeppcm.c
@@ -587,7 +587,7 @@ static int snd_usX2Y_usbpcm_close(struct snd_pcm_substream *substream)
 }
 
 
-static struct snd_pcm_ops snd_usX2Y_usbpcm_ops = 
+static const struct snd_pcm_ops snd_usX2Y_usbpcm_ops =
 {
 	.open =		snd_usX2Y_usbpcm_open,
 	.close =	snd_usX2Y_usbpcm_close,
-- 
1.9.1
