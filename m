From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH] ALSA: usb: constify snd_pcm_ops structures
Date: Thu,  8 Sep 2016 03:01:02 +0200
Message-ID: <1473296462-26377-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <kernel-janitors-owner@vger.kernel.org>
Sender: kernel-janitors-owner@vger.kernel.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: kernel-janitors@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Check for snd_pcm_ops structures that are only stored in the ops field of a
snd_soc_platform_driver structure or passed as the third argument to
snd_pcm_set_ops.  The corresponding field or parameter is declared const,
so snd_pcm_ops structures that have this property can be declared as const
also.

The semantic patch that makes this change is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@r disable optional_qualifier@
identifier i;
position p;
@@
static struct snd_pcm_ops i@p = { ... };

@ok1@
identifier r.i;
struct snd_soc_platform_driver e;
position p;
@@
e.ops = &i@p;

@ok2@
identifier r.i;
expression e1, e2;
position p;
@@
snd_pcm_set_ops(e1, e2, &i@p)

@bad@
position p != {r.p,ok1.p,ok2.p};
identifier r.i;
struct snd_pcm_ops e;
@@
e@i@p

@depends on !bad disable optional_qualifier@
identifier r.i;
@@
static
+const
 struct snd_pcm_ops i = { ... };
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 sound/usb/6fire/pcm.c           |    2 +-
 sound/usb/caiaq/audio.c         |    2 +-
 sound/usb/hiface/pcm.c          |    2 +-
 sound/usb/misc/ua101.c          |    4 ++--
 sound/usb/usx2y/usx2yhwdeppcm.c |    2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

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
diff --git a/sound/usb/hiface/pcm.c b/sound/usb/hiface/pcm.c
index 2c44139..23e66ed 100644
--- a/sound/usb/hiface/pcm.c
+++ b/sound/usb/hiface/pcm.c
@@ -511,7 +511,7 @@ static snd_pcm_uframes_t hiface_pcm_pointer(struct snd_pcm_substream *alsa_sub)
 	return bytes_to_frames(alsa_sub->runtime, dma_offset);
 }
 
-static struct snd_pcm_ops pcm_ops = {
+static const struct snd_pcm_ops pcm_ops = {
 	.open = hiface_pcm_open,
 	.close = hiface_pcm_close,
 	.ioctl = snd_pcm_lib_ioctl,
diff --git a/sound/usb/usx2y/usx2yhwdeppcm.c b/sound/usb/usx2y/usx2yhwdeppcm.c
index 90766a9..1f28cb2a 100644
--- a/sound/usb/usx2y/usx2yhwdeppcm.c
+++ b/sound/usb/usx2y/usx2yhwdeppcm.c
@@ -587,7 +587,7 @@ static int snd_usX2Y_usbpcm_close(struct snd_pcm_substream *substream)
 }
 
 
-static struct snd_pcm_ops snd_usX2Y_usbpcm_ops = 
+static const struct snd_pcm_ops snd_usX2Y_usbpcm_ops =
 {
 	.open =		snd_usX2Y_usbpcm_open,
 	.close =	snd_usX2Y_usbpcm_close,
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
@@ -903,7 +903,7 @@ static struct snd_pcm_ops capture_pcm_ops = {
 	.mmap = snd_pcm_lib_mmap_vmalloc,
 };
 
-static struct snd_pcm_ops playback_pcm_ops = {
+static const struct snd_pcm_ops playback_pcm_ops = {
 	.open = playback_pcm_open,
 	.close = playback_pcm_close,
 	.ioctl = snd_pcm_lib_ioctl,
diff --git a/sound/usb/caiaq/audio.c b/sound/usb/caiaq/audio.c
index 8f66ba7..af5ad84 100644
--- a/sound/usb/caiaq/audio.c
+++ b/sound/usb/caiaq/audio.c
@@ -338,7 +338,7 @@ unlock:
 }
 
 /* operators for both playback and capture */
-static struct snd_pcm_ops snd_usb_caiaq_ops = {
+static const struct snd_pcm_ops snd_usb_caiaq_ops = {
 	.open =		snd_usb_caiaq_substream_open,
 	.close =	snd_usb_caiaq_substream_close,
 	.ioctl =	snd_pcm_lib_ioctl,

