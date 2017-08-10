From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 6/7] ALSA: sis7019: constify snd_pcm_ops structures
Date: Thu, 10 Aug 2017 17:17:37 +0530
Message-ID: <1502365658-24723-7-git-send-email-arvind.yadav.cs@gmail.com>
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
 sound/pci/sis7019.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/sis7019.c b/sound/pci/sis7019.c
index f3860b8..3518887 100644
--- a/sound/pci/sis7019.c
+++ b/sound/pci/sis7019.c
@@ -872,7 +872,7 @@ static int sis_pcm_capture_prepare(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-static struct snd_pcm_ops sis_playback_ops = {
+static const struct snd_pcm_ops sis_playback_ops = {
 	.open = sis_playback_open,
 	.close = sis_substream_close,
 	.ioctl = snd_pcm_lib_ioctl,
@@ -883,7 +883,7 @@ static int sis_pcm_capture_prepare(struct snd_pcm_substream *substream)
 	.pointer = sis_pcm_pointer,
 };
 
-static struct snd_pcm_ops sis_capture_ops = {
+static const struct snd_pcm_ops sis_capture_ops = {
 	.open = sis_capture_open,
 	.close = sis_substream_close,
 	.ioctl = snd_pcm_lib_ioctl,
-- 
1.9.1
