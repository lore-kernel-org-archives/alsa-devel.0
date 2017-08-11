From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 9/9] ALSA: wss: constify snd_pcm_ops structures
Date: Fri, 11 Aug 2017 17:28:07 +0530
Message-ID: <1502452687-8202-10-git-send-email-arvind.yadav.cs@gmail.com>
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
 sound/isa/wss/wss_lib.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/isa/wss/wss_lib.c b/sound/isa/wss/wss_lib.c
index 9f4e2e3..29adb01 100644
--- a/sound/isa/wss/wss_lib.c
+++ b/sound/isa/wss/wss_lib.c
@@ -1901,7 +1901,7 @@ int snd_wss_create(struct snd_card *card,
 }
 EXPORT_SYMBOL(snd_wss_create);
 
-static struct snd_pcm_ops snd_wss_playback_ops = {
+static const struct snd_pcm_ops snd_wss_playback_ops = {
 	.open =		snd_wss_playback_open,
 	.close =	snd_wss_playback_close,
 	.ioctl =	snd_pcm_lib_ioctl,
@@ -1912,7 +1912,7 @@ int snd_wss_create(struct snd_card *card,
 	.pointer =	snd_wss_playback_pointer,
 };
 
-static struct snd_pcm_ops snd_wss_capture_ops = {
+static const struct snd_pcm_ops snd_wss_capture_ops = {
 	.open =		snd_wss_capture_open,
 	.close =	snd_wss_capture_close,
 	.ioctl =	snd_pcm_lib_ioctl,
-- 
1.9.1
