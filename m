From: Nick Simonov <nicksimonovv@gmail.com>
Subject: [PATCH v2] ALSA: xen-front: Refine indentations and
 constify snd_pcm_ops
Date: Fri, 21 Sep 2018 08:47:38 +0300
Message-ID: <20180921054514.GA11771@nick>
Reply-To: 20180919214710.GA6907@nick.alsa-project.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf1-f66.google.com (mail-lf1-f66.google.com
 [209.85.167.66])
 by alsa0.perex.cz (Postfix) with ESMTP id E528D267889
 for <alsa-devel@alsa-project.org>; Fri, 21 Sep 2018 08:06:17 +0200 (CEST)
Received: by mail-lf1-f66.google.com with SMTP id x20-v6so10451108lfg.2
 for <alsa-devel@alsa-project.org>; Thu, 20 Sep 2018 23:06:17 -0700 (PDT)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: oleksandr_andrushchenko@epam.com
Cc: xen-devel@lists.xenproject.org, alsa-devel@alsa-project.org, tiwai@suse.com, inux-kernel@vger.kernel.org, nicksimonovv@gmail.com
List-Id: alsa-devel@alsa-project.org

snd_pcm_ops are not supposed to change. So mark the
non-const structs as const. Also, refine indentation
to increase readability.

Signed-off-by: Nick Simonov <nicksimonovv@gmail.com>
---
Changes v2:
- Fix typo in commit description, ncrease to increase.

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
