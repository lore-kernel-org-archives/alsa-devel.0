From: Li Xu <li.xu@cirrus.com>
Subject: [PATCH] ALSA: core: update supported sample rates
Date: Thu, 1 Dec 2016 15:16:08 -0600
Message-ID: <c372493a-cbd1-4750-86c1-10c1fff178b2@EX4.ad.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 8398F265823
 for <alsa-devel@alsa-project.org>; Thu,  1 Dec 2016 22:15:39 +0100 (CET)
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
Cc: brian.austin@cirrus.com, tiwai@suse.com, paul.handrigan@cirrus.com, o-takashi@sakamocchi.jp, jeeja.kp@intel.com, ckeepax@opensource.wolfsonmicro.com, li.xu@cirrus.com
List-Id: alsa-devel@alsa-project.org

Add 12KHz, 24KHz, 352.8KHz and 384KHz audio sample rates

Signed-off-by: Li Xu <li.xu@cirrus.com>
---
 include/sound/pcm.h     | 27 +++++++++++++++++----------
 sound/core/pcm_native.c |  7 ++++---
 2 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index af1fb37..3ce4ad9 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -119,16 +119,20 @@ struct snd_pcm_ops {
 #define SNDRV_PCM_RATE_5512		(1<<0)		/* 5512Hz */
 #define SNDRV_PCM_RATE_8000		(1<<1)		/* 8000Hz */
 #define SNDRV_PCM_RATE_11025		(1<<2)		/* 11025Hz */
-#define SNDRV_PCM_RATE_16000		(1<<3)		/* 16000Hz */
-#define SNDRV_PCM_RATE_22050		(1<<4)		/* 22050Hz */
-#define SNDRV_PCM_RATE_32000		(1<<5)		/* 32000Hz */
-#define SNDRV_PCM_RATE_44100		(1<<6)		/* 44100Hz */
-#define SNDRV_PCM_RATE_48000		(1<<7)		/* 48000Hz */
-#define SNDRV_PCM_RATE_64000		(1<<8)		/* 64000Hz */
-#define SNDRV_PCM_RATE_88200		(1<<9)		/* 88200Hz */
-#define SNDRV_PCM_RATE_96000		(1<<10)		/* 96000Hz */
-#define SNDRV_PCM_RATE_176400		(1<<11)		/* 176400Hz */
-#define SNDRV_PCM_RATE_192000		(1<<12)		/* 192000Hz */
+#define SNDRV_PCM_RATE_12000		(1<<3)		/* 12000Hz */
+#define SNDRV_PCM_RATE_16000		(1<<4)		/* 16000Hz */
+#define SNDRV_PCM_RATE_22050		(1<<5)		/* 22050Hz */
+#define SNDRV_PCM_RATE_24000		(1<<6)		/* 24000Hz */
+#define SNDRV_PCM_RATE_32000		(1<<7)		/* 32000Hz */
+#define SNDRV_PCM_RATE_44100		(1<<8)		/* 44100Hz */
+#define SNDRV_PCM_RATE_48000		(1<<9)		/* 48000Hz */
+#define SNDRV_PCM_RATE_64000		(1<<10)		/* 64000Hz */
+#define SNDRV_PCM_RATE_88200		(1<<11)		/* 88200Hz */
+#define SNDRV_PCM_RATE_96000		(1<<12)		/* 96000Hz */
+#define SNDRV_PCM_RATE_176400		(1<<13)		/* 176400Hz */
+#define SNDRV_PCM_RATE_192000		(1<<14)		/* 192000Hz */
+#define SNDRV_PCM_RATE_352800		(1<<15)		/* 352800Hz */
+#define SNDRV_PCM_RATE_384000		(1<<16)		/* 384000Hz */
 
 #define SNDRV_PCM_RATE_CONTINUOUS	(1<<30)		/* continuous range */
 #define SNDRV_PCM_RATE_KNOT		(1<<31)		/* supports more non-continuos rates */
@@ -141,6 +145,9 @@ struct snd_pcm_ops {
 					 SNDRV_PCM_RATE_88200|SNDRV_PCM_RATE_96000)
 #define SNDRV_PCM_RATE_8000_192000	(SNDRV_PCM_RATE_8000_96000|SNDRV_PCM_RATE_176400|\
 					 SNDRV_PCM_RATE_192000)
+#define SNDRV_PCM_RATE_8000_384000	(SNDRV_PCM_RATE_8000_192000|\
+					 SNDRV_PCM_RATE_384000)
+
 #define _SNDRV_PCM_FMTBIT(fmt)		(1ULL << (__force int)SNDRV_PCM_FORMAT_##fmt)
 #define SNDRV_PCM_FMTBIT_S8		_SNDRV_PCM_FMTBIT(S8)
 #define SNDRV_PCM_FMTBIT_U8		_SNDRV_PCM_FMTBIT(U8)
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 9d33c1e..9bc1011 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -1981,12 +1981,13 @@ static int snd_pcm_hw_rule_sample_bits(struct snd_pcm_hw_params *params,
 	return snd_interval_refine(hw_param_interval(params, rule->var), &t);
 }
 
-#if SNDRV_PCM_RATE_5512 != 1 << 0 || SNDRV_PCM_RATE_192000 != 1 << 12
+#if SNDRV_PCM_RATE_5512 != 1 << 0 || SNDRV_PCM_RATE_384000 != 1 << 16
 #error "Change this table"
 #endif
 
-static unsigned int rates[] = { 5512, 8000, 11025, 16000, 22050, 32000, 44100,
-                                 48000, 64000, 88200, 96000, 176400, 192000 };
+static unsigned int rates[] = { 5512, 8000, 11025, 12000, 16000, 22050,
+				24000, 32000, 44100, 48000, 64000, 88200,
+				96000, 176400, 192000, 352800, 384000 };
 
 const struct snd_pcm_hw_constraint_list snd_pcm_known_rates = {
 	.count = ARRAY_SIZE(rates),
-- 
1.9.1
