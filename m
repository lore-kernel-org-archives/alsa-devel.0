From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 4/7] ALSA: intel8x0: constify snd_pcm_ops structures
Date: Thu, 10 Aug 2017 17:17:35 +0530
Message-ID: <1502365658-24723-5-git-send-email-arvind.yadav.cs@gmail.com>
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
 sound/pci/intel8x0.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/sound/pci/intel8x0.c b/sound/pci/intel8x0.c
index a8d7092..fcd032e 100644
--- a/sound/pci/intel8x0.c
+++ b/sound/pci/intel8x0.c
@@ -1367,7 +1367,7 @@ static int snd_intel8x0_ali_spdifout_close(struct snd_pcm_substream *substream)
 }
 #endif
 
-static struct snd_pcm_ops snd_intel8x0_playback_ops = {
+static const struct snd_pcm_ops snd_intel8x0_playback_ops = {
 	.open =		snd_intel8x0_playback_open,
 	.close =	snd_intel8x0_playback_close,
 	.ioctl =	snd_pcm_lib_ioctl,
@@ -1378,7 +1378,7 @@ static int snd_intel8x0_ali_spdifout_close(struct snd_pcm_substream *substream)
 	.pointer =	snd_intel8x0_pcm_pointer,
 };
 
-static struct snd_pcm_ops snd_intel8x0_capture_ops = {
+static const struct snd_pcm_ops snd_intel8x0_capture_ops = {
 	.open =		snd_intel8x0_capture_open,
 	.close =	snd_intel8x0_capture_close,
 	.ioctl =	snd_pcm_lib_ioctl,
@@ -1389,7 +1389,7 @@ static int snd_intel8x0_ali_spdifout_close(struct snd_pcm_substream *substream)
 	.pointer =	snd_intel8x0_pcm_pointer,
 };
 
-static struct snd_pcm_ops snd_intel8x0_capture_mic_ops = {
+static const struct snd_pcm_ops snd_intel8x0_capture_mic_ops = {
 	.open =		snd_intel8x0_mic_open,
 	.close =	snd_intel8x0_mic_close,
 	.ioctl =	snd_pcm_lib_ioctl,
@@ -1400,7 +1400,7 @@ static int snd_intel8x0_ali_spdifout_close(struct snd_pcm_substream *substream)
 	.pointer =	snd_intel8x0_pcm_pointer,
 };
 
-static struct snd_pcm_ops snd_intel8x0_capture_mic2_ops = {
+static const struct snd_pcm_ops snd_intel8x0_capture_mic2_ops = {
 	.open =		snd_intel8x0_mic2_open,
 	.close =	snd_intel8x0_mic2_close,
 	.ioctl =	snd_pcm_lib_ioctl,
@@ -1411,7 +1411,7 @@ static int snd_intel8x0_ali_spdifout_close(struct snd_pcm_substream *substream)
 	.pointer =	snd_intel8x0_pcm_pointer,
 };
 
-static struct snd_pcm_ops snd_intel8x0_capture2_ops = {
+static const struct snd_pcm_ops snd_intel8x0_capture2_ops = {
 	.open =		snd_intel8x0_capture2_open,
 	.close =	snd_intel8x0_capture2_close,
 	.ioctl =	snd_pcm_lib_ioctl,
@@ -1422,7 +1422,7 @@ static int snd_intel8x0_ali_spdifout_close(struct snd_pcm_substream *substream)
 	.pointer =	snd_intel8x0_pcm_pointer,
 };
 
-static struct snd_pcm_ops snd_intel8x0_spdif_ops = {
+static const struct snd_pcm_ops snd_intel8x0_spdif_ops = {
 	.open =		snd_intel8x0_spdif_open,
 	.close =	snd_intel8x0_spdif_close,
 	.ioctl =	snd_pcm_lib_ioctl,
@@ -1433,7 +1433,7 @@ static int snd_intel8x0_ali_spdifout_close(struct snd_pcm_substream *substream)
 	.pointer =	snd_intel8x0_pcm_pointer,
 };
 
-static struct snd_pcm_ops snd_intel8x0_ali_playback_ops = {
+static const struct snd_pcm_ops snd_intel8x0_ali_playback_ops = {
 	.open =		snd_intel8x0_playback_open,
 	.close =	snd_intel8x0_playback_close,
 	.ioctl =	snd_pcm_lib_ioctl,
@@ -1444,7 +1444,7 @@ static int snd_intel8x0_ali_spdifout_close(struct snd_pcm_substream *substream)
 	.pointer =	snd_intel8x0_pcm_pointer,
 };
 
-static struct snd_pcm_ops snd_intel8x0_ali_capture_ops = {
+static const struct snd_pcm_ops snd_intel8x0_ali_capture_ops = {
 	.open =		snd_intel8x0_capture_open,
 	.close =	snd_intel8x0_capture_close,
 	.ioctl =	snd_pcm_lib_ioctl,
@@ -1455,7 +1455,7 @@ static int snd_intel8x0_ali_spdifout_close(struct snd_pcm_substream *substream)
 	.pointer =	snd_intel8x0_pcm_pointer,
 };
 
-static struct snd_pcm_ops snd_intel8x0_ali_capture_mic_ops = {
+static const struct snd_pcm_ops snd_intel8x0_ali_capture_mic_ops = {
 	.open =		snd_intel8x0_mic_open,
 	.close =	snd_intel8x0_mic_close,
 	.ioctl =	snd_pcm_lib_ioctl,
@@ -1466,7 +1466,7 @@ static int snd_intel8x0_ali_spdifout_close(struct snd_pcm_substream *substream)
 	.pointer =	snd_intel8x0_pcm_pointer,
 };
 
-static struct snd_pcm_ops snd_intel8x0_ali_ac97spdifout_ops = {
+static const struct snd_pcm_ops snd_intel8x0_ali_ac97spdifout_ops = {
 	.open =		snd_intel8x0_ali_ac97spdifout_open,
 	.close =	snd_intel8x0_ali_ac97spdifout_close,
 	.ioctl =	snd_pcm_lib_ioctl,
@@ -1503,8 +1503,8 @@ static int snd_intel8x0_ali_spdifout_close(struct snd_pcm_substream *substream)
 
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
