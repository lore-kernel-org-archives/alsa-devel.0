From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 11/13] ALSA: sparc: constify snd_pcm_ops structures
Date: Fri, 18 Aug 2017 13:15:19 +0530
Message-ID: <1503042321-26758-10-git-send-email-arvind.yadav.cs@gmail.com>
References: <1503042321-26758-1-git-send-email-arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1503042321-26758-1-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com, johannes@sipsolutions.net, linux@armlinux.org.uk, daniel@zonque.org, clemens@ladisch.de
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

snd_pcm_ops are not supposed to change at runtime. All functions
working with snd_pcm_ops provided by <sound/pcm.h> work with
const snd_pcm_ops. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 sound/sparc/amd7930.c | 4 ++--
 sound/sparc/cs4231.c  | 4 ++--
 sound/sparc/dbri.c    | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/sparc/amd7930.c b/sound/sparc/amd7930.c
index 35c1f6a..2331dbf 100644
--- a/sound/sparc/amd7930.c
+++ b/sound/sparc/amd7930.c
@@ -733,7 +733,7 @@ static int snd_amd7930_hw_free(struct snd_pcm_substream *substream)
 	return snd_pcm_lib_free_pages(substream);
 }
 
-static struct snd_pcm_ops snd_amd7930_playback_ops = {
+static const struct snd_pcm_ops snd_amd7930_playback_ops = {
 	.open		=	snd_amd7930_playback_open,
 	.close		=	snd_amd7930_playback_close,
 	.ioctl		=	snd_pcm_lib_ioctl,
@@ -744,7 +744,7 @@ static int snd_amd7930_hw_free(struct snd_pcm_substream *substream)
 	.pointer	=	snd_amd7930_playback_pointer,
 };
 
-static struct snd_pcm_ops snd_amd7930_capture_ops = {
+static const struct snd_pcm_ops snd_amd7930_capture_ops = {
 	.open		=	snd_amd7930_capture_open,
 	.close		=	snd_amd7930_capture_close,
 	.ioctl		=	snd_pcm_lib_ioctl,
diff --git a/sound/sparc/cs4231.c b/sound/sparc/cs4231.c
index 3d7d425..3a947e0 100644
--- a/sound/sparc/cs4231.c
+++ b/sound/sparc/cs4231.c
@@ -1203,7 +1203,7 @@ static int snd_cs4231_capture_close(struct snd_pcm_substream *substream)
  * XXX the audio AUXIO register...
  */
 
-static struct snd_pcm_ops snd_cs4231_playback_ops = {
+static const struct snd_pcm_ops snd_cs4231_playback_ops = {
 	.open		=	snd_cs4231_playback_open,
 	.close		=	snd_cs4231_playback_close,
 	.ioctl		=	snd_pcm_lib_ioctl,
@@ -1214,7 +1214,7 @@ static int snd_cs4231_capture_close(struct snd_pcm_substream *substream)
 	.pointer	=	snd_cs4231_playback_pointer,
 };
 
-static struct snd_pcm_ops snd_cs4231_capture_ops = {
+static const struct snd_pcm_ops snd_cs4231_capture_ops = {
 	.open		=	snd_cs4231_capture_open,
 	.close		=	snd_cs4231_capture_close,
 	.ioctl		=	snd_pcm_lib_ioctl,
diff --git a/sound/sparc/dbri.c b/sound/sparc/dbri.c
index 52063b2..87b887a 100644
--- a/sound/sparc/dbri.c
+++ b/sound/sparc/dbri.c
@@ -2213,7 +2213,7 @@ static snd_pcm_uframes_t snd_dbri_pointer(struct snd_pcm_substream *substream)
 	return ret;
 }
 
-static struct snd_pcm_ops snd_dbri_ops = {
+static const struct snd_pcm_ops snd_dbri_ops = {
 	.open = snd_dbri_open,
 	.close = snd_dbri_close,
 	.ioctl = snd_pcm_lib_ioctl,
-- 
1.9.1
