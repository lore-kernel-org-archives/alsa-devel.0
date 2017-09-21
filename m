From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH] sound: core: Fix structure definition for X32 ABI
Date: Thu, 21 Sep 2017 14:03:29 +0800
Message-ID: <a7fc2a6c658b7a3561a635e2286861bf2ba00db4.1505717100.git.baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com
Cc: o-takashi@sakamocchi.jp, arnd@arndb.de, broonie@kernel.org, deepa.kernel@gmail.com, baolin.wang@linaro.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

X32 ABI uses the 64bit timespec in addition to 64bit alignment of 64bit
values. We have added compat ABI for these ioctls, but this patch adds
one missing padding into 'struct snd_pcm_mmap_status_x32' to fix
incompatibilities.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 sound/core/pcm_compat.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/core/pcm_compat.c b/sound/core/pcm_compat.c
index 10f537f..29ab480 100644
--- a/sound/core/pcm_compat.c
+++ b/sound/core/pcm_compat.c
@@ -547,6 +547,7 @@ struct snd_pcm_mmap_status_x32 {
 	u32 pad2; /* alignment */
 	struct timespec tstamp;
 	s32 suspended_state;
+	s32 pad3;
 	struct timespec audio_tstamp;
 } __packed;
 
-- 
1.7.9.5
