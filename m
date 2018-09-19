From: Nick Simonov <nicksimonovv@gmail.com>
Subject: [PATCH] ALSA: xen-front: Refine indentations and constify snd_pcm_ops
Date: Thu, 20 Sep 2018 00:47:10 +0300
Message-ID: <20180919214710.GA6907@nick>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: oleksandr_andrushchenko@epam.com
Cc: tiwai@suse.com, xen-devel@lists.xenproject.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, nicksimonovv@gmail.com
List-Id: alsa-devel@alsa-project.org

snd_pcm_ops are not supposed to change. So mark the
non-const structs as const. Also, refine indentation
to ncrease readability.

Signed-off-by: Nick Simonov <nicksimonovv@gmail.com>
---
 sound/xen/xen_snd_front_alsa.c | 46 +++++++++++++++++++++---------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/sound/xen/xen_snd_front_alsa.c b/sound/xen/xen_snd_front_alsa.c
index 129180e..2cbd967 100644
--- a/sound/xen/xen_snd_front_alsa.c
+++ b/sound/xen/xen_snd_front_alsa.c
@@ -637,31 +637,31 @@ static int alsa_pb_fill_silence(struct snd_pcm_substream *substream,
  * to know when the buffer can be transferred to the backend.
  */
 
-static struct snd_pcm_ops snd_drv_alsa_playback_ops = {
-	.open = alsa_open,
-	.close = alsa_close,
-	.ioctl = snd_pcm_lib_ioctl,
-	.hw_params = alsa_hw_params,
-	.hw_free = alsa_hw_free,
-	.prepare = alsa_prepare,
-	.trigger = alsa_trigger,
-	.pointer = alsa_pointer,
-	.copy_user = alsa_pb_copy_user,
-	.copy_kernel = alsa_pb_copy_kernel,
-	.fill_silence = alsa_pb_fill_silence,
+static const struct snd_pcm_ops snd_drv_alsa_playback_ops = {
+	.open		= alsa_open,
+	.close		= alsa_close,
+	.ioctl		= snd_pcm_lib_ioctl,
+	.hw_params	= alsa_hw_params,
+	.hw_free	= alsa_hw_free,
+	.prepare	= alsa_prepare,
+	.trigger	= alsa_trigger,
+	.pointer	= alsa_pointer,
+	.copy_user	= alsa_pb_copy_user,
+	.copy_kernel	= alsa_pb_copy_kernel,
+	.fill_silence	= alsa_pb_fill_silence,
 };
 
-static struct snd_pcm_ops snd_drv_alsa_capture_ops = {
-	.open = alsa_open,
-	.close = alsa_close,
-	.ioctl = snd_pcm_lib_ioctl,
-	.hw_params = alsa_hw_params,
-	.hw_free = alsa_hw_free,
-	.prepare = alsa_prepare,
-	.trigger = alsa_trigger,
-	.pointer = alsa_pointer,
-	.copy_user = alsa_cap_copy_user,
-	.copy_kernel = alsa_cap_copy_kernel,
+static const struct snd_pcm_ops snd_drv_alsa_capture_ops = {
+	.open		= alsa_open,
+	.close		= alsa_close,
+	.ioctl		= snd_pcm_lib_ioctl,
+	.hw_params	= alsa_hw_params,
+	.hw_free	= alsa_hw_free,
+	.prepare	= alsa_prepare,
+	.trigger	= alsa_trigger,
+	.pointer	= alsa_pointer,
+	.copy_user	= alsa_cap_copy_user,
+	.copy_kernel	= alsa_cap_copy_kernel,
 };
 
 static int new_pcm_instance(struct xen_snd_front_card_info *card_info,
-- 
2.7.4
