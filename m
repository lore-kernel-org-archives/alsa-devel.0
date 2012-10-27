From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] ALSA: core: fix 64-bit SNDRV_PCM_IOCTL_STATUS
	ABI breakage
Date: Sat, 27 Oct 2012 21:55:27 +0200
Message-ID: <508C3C2F.7070009@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 4F55E26522A
 for <alsa-devel@alsa-project.org>; Sat, 27 Oct 2012 21:56:52 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Commit 4eeaaeaea (ALSA: core: add hooks for audio timestamps) added the
new audio_tstamp field to struct snd_pcm_status.  However, struct
timespec requires 64-bit alignment, so the 64-bit compiler would insert
32 bits of padding before this field, which broke SNDRV_PCM_IOCTL_STATUS
with error messages like this:

  kernel: unknown ioctl = 0x80984120

To solve this, insert the padding explicitly so that it can be taken
into account when calculating the ABI structure size.

Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
---
 include/uapi/sound/asound.h |    3 ++-
 sound/core/pcm_compat.c     |    3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

--- a/include/uapi/sound/asound.h
+++ b/include/uapi/sound/asound.h
@@ -408,8 +408,9 @@ struct snd_pcm_status {
 	snd_pcm_uframes_t avail_max;	/* max frames available on hw since last status */
 	snd_pcm_uframes_t overrange;	/* count of ADC (capture) overrange detections from last status */
 	snd_pcm_state_t suspended_state; /* suspended stream state */
+	__u32 reserved_alignment;	/* must be filled with zero */
 	struct timespec audio_tstamp;	/* from sample counter or wall clock */
-	unsigned char reserved[60-sizeof(struct timespec)]; /* must be filled with zero */
+	unsigned char reserved[56-sizeof(struct timespec)]; /* must be filled with zero */
 };

 struct snd_pcm_mmap_status {
--- a/sound/core/pcm_compat.c
+++ b/sound/core/pcm_compat.c
@@ -190,8 +190,9 @@ struct snd_pcm_status32 {
 	u32 avail_max;
 	u32 overrange;
 	s32 suspended_state;
+	u32 reserved_alignment;
 	struct compat_timespec audio_tstamp;
-	unsigned char reserved[60-sizeof(struct compat_timespec)];
+	unsigned char reserved[56-sizeof(struct compat_timespec)];
 } __attribute__((packed));
