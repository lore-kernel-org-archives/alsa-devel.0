From: Thomas Klausner <tk@giga.or.at>
Subject: [PATCH 4/4] Replace __u* with uint*_t
Date: Mon, 29 Feb 2016 16:10:35 +0100
Message-ID: <20160229151035.GE7216@danbala.tuwien.ac.at>
References: <56D010C4.3000804@ladisch.de>
 <1456758321-2256-1-git-send-email-tk@giga.or.at>
 <sfid-H20160229-160720-+038.00-1@spamfilter.osbf.lua>
 <1456758321-2256-3-git-send-email-tk@giga.or.at>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="y0ulUmNC+osPPQO6"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from danbala.ifoer.tuwien.ac.at (danbala.ifoer.tuwien.ac.at
 [128.130.168.64])
 by alsa0.perex.cz (Postfix) with ESMTP id 95A53260535
 for <alsa-devel@alsa-project.org>; Mon, 29 Feb 2016 16:10:40 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1456758321-2256-3-git-send-email-tk@giga.or.at>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

And here's a fourth one.

--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0004-Replace-__u-with-uint-_t.patch"

>From e98b740f7617830f46e58365f3c0602fcb3ff8c2 Mon Sep 17 00:00:00 2001
From: Thomas Klausner <wiz@NetBSD.org>
Date: Mon, 29 Feb 2016 16:08:54 +0100
Subject: [PATCH 4/4] Replace __u* with uint*_t.

---
 include/sound/asound.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/sound/asound.h b/include/sound/asound.h
index 4f2202f..0d30eaa 100644
--- a/include/sound/asound.h
+++ b/include/sound/asound.h
@@ -370,7 +370,7 @@ struct snd_interval {
 #define SNDRV_MASK_MAX	256
 
 struct snd_mask {
-	__u32 bits[(SNDRV_MASK_MAX+31)/32];
+	uint32_t bits[(SNDRV_MASK_MAX+31)/32];
 };
 
 struct snd_pcm_hw_params {
@@ -447,10 +447,10 @@ struct snd_pcm_status {
 	snd_pcm_uframes_t avail_max;	/* max frames available on hw since last status */
 	snd_pcm_uframes_t overrange;	/* count of ADC (capture) overrange detections from last status */
 	snd_pcm_state_t suspended_state; /* suspended stream state */
-	__u32 audio_tstamp_data;	 /* needed for 64-bit alignment, used for configs/report to/from userspace */
+	uint32_t audio_tstamp_data;	 /* needed for 64-bit alignment, used for configs/report to/from userspace */
 	struct timespec audio_tstamp;	/* sample counter, wall clock, PHC or on-demand sync'ed */
 	struct timespec driver_tstamp;	/* useful in case reference system tstamp is reported with delay */
-	__u32 audio_tstamp_accuracy;	/* in ns units, only valid if indicated in audio_tstamp_data */
+	uint32_t audio_tstamp_accuracy;	/* in ns units, only valid if indicated in audio_tstamp_data */
 	unsigned char reserved[52-2*sizeof(struct timespec)]; /* must be filled with zero */
 };
 
@@ -900,7 +900,7 @@ struct snd_ctl_elem_info {
 			unsigned int items;	/* R: number of items */
 			unsigned int item;	/* W: item number */
 			char name[64];		/* R: value name */
-			__u64 names_ptr;	/* W: names list (ELEM_ADD only) */
+			uint64_t names_ptr;	/* W: names list (ELEM_ADD only) */
 			unsigned int names_length;
 		} enumerated;
 		unsigned char reserved[128];
-- 
2.7.1


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--y0ulUmNC+osPPQO6--
