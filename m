From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 06/13] ALSA: mips: constify snd_pcm_ops structures
Date: Fri, 18 Aug 2017 13:15:14 +0530
Message-ID: <1503042321-26758-7-git-send-email-arvind.yadav.cs@gmail.com>
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
 sound/mips/hal2.c       | 4 ++--
 sound/mips/sgio2audio.c | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/mips/hal2.c b/sound/mips/hal2.c
index 3318c15..b123e16 100644
--- a/sound/mips/hal2.c
+++ b/sound/mips/hal2.c
@@ -711,7 +711,7 @@ static int hal2_capture_ack(struct snd_pcm_substream *substream)
 						 hal2_capture_transfer);
 }
 
-static struct snd_pcm_ops hal2_playback_ops = {
+static const struct snd_pcm_ops hal2_playback_ops = {
 	.open =        hal2_playback_open,
 	.close =       hal2_playback_close,
 	.ioctl =       snd_pcm_lib_ioctl,
@@ -723,7 +723,7 @@ static int hal2_capture_ack(struct snd_pcm_substream *substream)
 	.ack =         hal2_playback_ack,
 };
 
-static struct snd_pcm_ops hal2_capture_ops = {
+static const struct snd_pcm_ops hal2_capture_ops = {
 	.open =        hal2_capture_open,
 	.close =       hal2_capture_close,
 	.ioctl =       snd_pcm_lib_ioctl,
diff --git a/sound/mips/sgio2audio.c b/sound/mips/sgio2audio.c
index 0ebc1c3..e1800c3 100644
--- a/sound/mips/sgio2audio.c
+++ b/sound/mips/sgio2audio.c
@@ -675,7 +675,7 @@ static int snd_sgio2audio_pcm_trigger(struct snd_pcm_substream *substream,
 }
 
 /* operators */
-static struct snd_pcm_ops snd_sgio2audio_playback1_ops = {
+static const struct snd_pcm_ops snd_sgio2audio_playback1_ops = {
 	.open =        snd_sgio2audio_playback1_open,
 	.close =       snd_sgio2audio_pcm_close,
 	.ioctl =       snd_pcm_lib_ioctl,
@@ -688,7 +688,7 @@ static int snd_sgio2audio_pcm_trigger(struct snd_pcm_substream *substream,
 	.mmap =        snd_pcm_lib_mmap_vmalloc,
 };
 
-static struct snd_pcm_ops snd_sgio2audio_playback2_ops = {
+static const struct snd_pcm_ops snd_sgio2audio_playback2_ops = {
 	.open =        snd_sgio2audio_playback2_open,
 	.close =       snd_sgio2audio_pcm_close,
 	.ioctl =       snd_pcm_lib_ioctl,
@@ -701,7 +701,7 @@ static int snd_sgio2audio_pcm_trigger(struct snd_pcm_substream *substream,
 	.mmap =        snd_pcm_lib_mmap_vmalloc,
 };
 
-static struct snd_pcm_ops snd_sgio2audio_capture_ops = {
+static const struct snd_pcm_ops snd_sgio2audio_capture_ops = {
 	.open =        snd_sgio2audio_capture_open,
 	.close =       snd_sgio2audio_pcm_close,
 	.ioctl =       snd_pcm_lib_ioctl,
-- 
1.9.1
