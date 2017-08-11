From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 7/9] ALSA: sb16: constify snd_pcm_ops structures
Date: Fri, 11 Aug 2017 17:28:05 +0530
Message-ID: <1502452687-8202-8-git-send-email-arvind.yadav.cs@gmail.com>
References: <1502452687-8202-1-git-send-email-arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1502452687-8202-1-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

snd_pcm_ops are not supposed to change at runtime. All functions
working with snd_pcm_ops provided by <sound/pcm.h> work with
const snd_pcm_ops. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 sound/isa/sb/sb16_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/isa/sb/sb16_main.c b/sound/isa/sb/sb16_main.c
index 4be1350..6fc6325 100644
--- a/sound/isa/sb/sb16_main.c
+++ b/sound/isa/sb/sb16_main.c
@@ -838,7 +838,7 @@ int snd_sb16dsp_configure(struct snd_sb * chip)
 	return 0;
 }
 
-static struct snd_pcm_ops snd_sb16_playback_ops = {
+static const struct snd_pcm_ops snd_sb16_playback_ops = {
 	.open =		snd_sb16_playback_open,
 	.close =	snd_sb16_playback_close,
 	.ioctl =	snd_pcm_lib_ioctl,
@@ -849,7 +849,7 @@ int snd_sb16dsp_configure(struct snd_sb * chip)
 	.pointer =	snd_sb16_playback_pointer,
 };
 
-static struct snd_pcm_ops snd_sb16_capture_ops = {
+static const struct snd_pcm_ops snd_sb16_capture_ops = {
 	.open =		snd_sb16_capture_open,
 	.close =	snd_sb16_capture_close,
 	.ioctl =	snd_pcm_lib_ioctl,
-- 
1.9.1
