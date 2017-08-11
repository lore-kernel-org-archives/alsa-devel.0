From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 5/9] ALSA: msnd: constify snd_pcm_ops structures
Date: Fri, 11 Aug 2017 17:28:03 +0530
Message-ID: <1502452687-8202-6-git-send-email-arvind.yadav.cs@gmail.com>
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
 sound/isa/msnd/msnd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/isa/msnd/msnd.c b/sound/isa/msnd/msnd.c
index 8109ab3..ae9562c 100644
--- a/sound/isa/msnd/msnd.c
+++ b/sound/isa/msnd/msnd.c
@@ -572,7 +572,7 @@ static int snd_msnd_playback_trigger(struct snd_pcm_substream *substream,
 }
 
 
-static struct snd_pcm_ops snd_msnd_playback_ops = {
+static const struct snd_pcm_ops snd_msnd_playback_ops = {
 	.open =		snd_msnd_playback_open,
 	.close =	snd_msnd_playback_close,
 	.ioctl =	snd_pcm_lib_ioctl,
@@ -669,7 +669,7 @@ static int snd_msnd_capture_hw_params(struct snd_pcm_substream *substream,
 }
 
 
-static struct snd_pcm_ops snd_msnd_capture_ops = {
+static const struct snd_pcm_ops snd_msnd_capture_ops = {
 	.open =		snd_msnd_capture_open,
 	.close =	snd_msnd_capture_close,
 	.ioctl =	snd_pcm_lib_ioctl,
-- 
1.9.1
