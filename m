From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 5/7] ALSA: intel8x0m: constify snd_pcm_ops structures
Date: Thu, 10 Aug 2017 17:17:36 +0530
Message-ID: <1502365658-24723-6-git-send-email-arvind.yadav.cs@gmail.com>
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
 sound/pci/intel8x0m.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/pci/intel8x0m.c b/sound/pci/intel8x0m.c
index 18ff668..2f1b878 100644
--- a/sound/pci/intel8x0m.c
+++ b/sound/pci/intel8x0m.c
@@ -685,7 +685,7 @@ static int snd_intel8x0m_capture_close(struct snd_pcm_substream *substream)
 }
 
 
-static struct snd_pcm_ops snd_intel8x0m_playback_ops = {
+static const struct snd_pcm_ops snd_intel8x0m_playback_ops = {
 	.open =		snd_intel8x0m_playback_open,
 	.close =	snd_intel8x0m_playback_close,
 	.ioctl =	snd_pcm_lib_ioctl,
@@ -696,7 +696,7 @@ static int snd_intel8x0m_capture_close(struct snd_pcm_substream *substream)
 	.pointer =	snd_intel8x0m_pcm_pointer,
 };
 
-static struct snd_pcm_ops snd_intel8x0m_capture_ops = {
+static const struct snd_pcm_ops snd_intel8x0m_capture_ops = {
 	.open =		snd_intel8x0m_capture_open,
 	.close =	snd_intel8x0m_capture_close,
 	.ioctl =	snd_pcm_lib_ioctl,
@@ -710,8 +710,8 @@ static int snd_intel8x0m_capture_close(struct snd_pcm_substream *substream)
 
 struct ich_pcm_table {
 	char *suffix;
-	struct snd_pcm_ops *playback_ops;
-	struct snd_pcm_ops *capture_ops;
+	const struct snd_pcm_ops *playback_ops;
+	const struct snd_pcm_ops *capture_ops;
 	size_t prealloc_size;
 	size_t prealloc_max_size;
 	int ac97_idx;
-- 
1.9.1
