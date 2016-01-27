From: <brian.austin@cirrus.com>
Subject: [PATCH] ALSA: core: Add 384kHz Support
Date: Wed, 27 Jan 2016 07:53:45 -0600
Message-ID: <1453902825-27002-1-git-send-email-brian.austin@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id D8F6E26044B
 for <alsa-devel@alsa-project.org>; Wed, 27 Jan 2016 14:49:40 +0100 (CET)
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
Cc: tiwai@suse.de, Brian Austin <brian.austin@cirrus.com>, paul.handrigan@cirrus.com, charles.keepax@cirrus.com
List-Id: alsa-devel@alsa-project.org

From: Brian Austin <brian.austin@cirrus.com>

Adding support for 384kHz audio sample rates

Signed-off-by: Brian Austin <brian.austin@cirrus.com>
---
 include/sound/pcm.h     | 3 +++
 sound/core/pcm_native.c | 4 ++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index b0be092..050c0b7 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -129,6 +129,7 @@ struct snd_pcm_ops {
 #define SNDRV_PCM_RATE_96000		(1<<10)		/* 96000Hz */
 #define SNDRV_PCM_RATE_176400		(1<<11)		/* 176400Hz */
 #define SNDRV_PCM_RATE_192000		(1<<12)		/* 192000Hz */
+#define SNDRV_PCM_RATE_384000		(1<<13)		/* 384000Hz */
 
 #define SNDRV_PCM_RATE_CONTINUOUS	(1<<30)		/* continuous range */
 #define SNDRV_PCM_RATE_KNOT		(1<<31)		/* supports more non-continuos rates */
@@ -141,6 +142,8 @@ struct snd_pcm_ops {
 					 SNDRV_PCM_RATE_88200|SNDRV_PCM_RATE_96000)
 #define SNDRV_PCM_RATE_8000_192000	(SNDRV_PCM_RATE_8000_96000|SNDRV_PCM_RATE_176400|\
 					 SNDRV_PCM_RATE_192000)
+#define SNDRV_PCM_RATE_8000_384000	(SNDRV_PCM_RATE_8000_192000|SNDRV_PCM_RATE_384000)
+
 #define _SNDRV_PCM_FMTBIT(fmt)		(1ULL << (__force int)SNDRV_PCM_FORMAT_##fmt)
 #define SNDRV_PCM_FMTBIT_S8		_SNDRV_PCM_FMTBIT(S8)
 #define SNDRV_PCM_FMTBIT_U8		_SNDRV_PCM_FMTBIT(U8)
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index a8b27cd..2e10c3f 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -1969,12 +1969,12 @@ static int snd_pcm_hw_rule_sample_bits(struct snd_pcm_hw_params *params,
 	return snd_interval_refine(hw_param_interval(params, rule->var), &t);
 }
 
-#if SNDRV_PCM_RATE_5512 != 1 << 0 || SNDRV_PCM_RATE_192000 != 1 << 12
+#if SNDRV_PCM_RATE_5512 != 1 << 0 || SNDRV_PCM_RATE_384000 != 1 << 13
 #error "Change this table"
 #endif
 
 static unsigned int rates[] = { 5512, 8000, 11025, 16000, 22050, 32000, 44100,
-                                 48000, 64000, 88200, 96000, 176400, 192000 };
+			48000, 64000, 88200, 96000, 176400, 192000, 384000 };
 
 const struct snd_pcm_hw_constraint_list snd_pcm_known_rates = {
 	.count = ARRAY_SIZE(rates),
-- 
1.9.1
