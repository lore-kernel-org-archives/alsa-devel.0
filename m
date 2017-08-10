From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 3/7] ALSA: echoaudio: constify snd_pcm_ops structures
Date: Thu, 10 Aug 2017 17:17:34 +0530
Message-ID: <1502365658-24723-4-git-send-email-arvind.yadav.cs@gmail.com>
References: <1502365658-24723-1-git-send-email-arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1502365658-24723-1-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

snd_pcm_ops are not supposed to change at runtime. All functions
working with snd_pcm_ops provided by <sound/pcm.h> work with
const snd_pcm_ops. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 sound/pci/echoaudio/echoaudio.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/pci/echoaudio/echoaudio.c b/sound/pci/echoaudio/echoaudio.c
index d15ecf9..7326695 100644
--- a/sound/pci/echoaudio/echoaudio.c
+++ b/sound/pci/echoaudio/echoaudio.c
@@ -826,7 +826,7 @@ static snd_pcm_uframes_t pcm_pointer(struct snd_pcm_substream *substream)
 
 
 /* pcm *_ops structures */
-static struct snd_pcm_ops analog_playback_ops = {
+static const struct snd_pcm_ops analog_playback_ops = {
 	.open = pcm_analog_out_open,
 	.close = pcm_close,
 	.ioctl = snd_pcm_lib_ioctl,
@@ -837,7 +837,7 @@ static snd_pcm_uframes_t pcm_pointer(struct snd_pcm_substream *substream)
 	.pointer = pcm_pointer,
 	.page = snd_pcm_sgbuf_ops_page,
 };
-static struct snd_pcm_ops analog_capture_ops = {
+static const struct snd_pcm_ops analog_capture_ops = {
 	.open = pcm_analog_in_open,
 	.close = pcm_close,
 	.ioctl = snd_pcm_lib_ioctl,
@@ -850,7 +850,7 @@ static snd_pcm_uframes_t pcm_pointer(struct snd_pcm_substream *substream)
 };
 #ifdef ECHOCARD_HAS_DIGITAL_IO
 #ifndef ECHOCARD_HAS_VMIXER
-static struct snd_pcm_ops digital_playback_ops = {
+static const struct snd_pcm_ops digital_playback_ops = {
 	.open = pcm_digital_out_open,
 	.close = pcm_close,
 	.ioctl = snd_pcm_lib_ioctl,
@@ -862,7 +862,7 @@ static snd_pcm_uframes_t pcm_pointer(struct snd_pcm_substream *substream)
 	.page = snd_pcm_sgbuf_ops_page,
 };
 #endif /* !ECHOCARD_HAS_VMIXER */
-static struct snd_pcm_ops digital_capture_ops = {
+static const struct snd_pcm_ops digital_capture_ops = {
 	.open = pcm_digital_in_open,
 	.close = pcm_close,
 	.ioctl = snd_pcm_lib_ioctl,
-- 
1.9.1
