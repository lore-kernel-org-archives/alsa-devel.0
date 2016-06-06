From: Clive Messer <clive.messer@digitaldreamtime.co.uk>
Subject: [PATCH] ALSA: Add rate defines for 352k8 and 384k
Date: Mon,  6 Jun 2016 18:16:17 +0100
Message-ID: <1465233377-28037-1-git-send-email-clive.messer@digitaldreamtime.co.uk>
References: <s5h4m96mq1k.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.dreamtime.org (barcelona.digitaldreamtime.co.uk
 [85.158.46.130])
 by alsa0.perex.cz (Postfix) with ESMTP id 799D02658E5
 for <alsa-devel@alsa-project.org>; Mon,  6 Jun 2016 19:16:29 +0200 (CEST)
In-Reply-To: <s5h4m96mq1k.wl-tiwai@suse.de>
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
Cc: Clive Messer <clive.messer@digitaldreamtime.co.uk>
List-Id: alsa-devel@alsa-project.org

Add SNDRV_PCM_RATE_352800 and SNDRV_PCM_RATE_384000 defines to pcm.h,
 for 352k8 and 384k sample rates.

Add SNDRV_PCM_RATE_8000_384000 define to pcm.h.

Update rates list in pcm_native.c.

Yes, we can use CONTINUOUS/KNOT and constraints, to support the x8
 sample rates, but having the defines requires less code in drivers.
Many more DAC chips are now supporting the x8 44k1/48k multiples.
>From a high-res viewpoint, the DXD standard is 352k8, 24 bit.
That alone should justify the addition of a define for it.

Signed-off-by: Clive Messer <clive.messer@digitaldreamtime.co.uk>
---
 include/sound/pcm.h     | 5 +++++
 sound/core/pcm_native.c | 5 +++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index af1fb37..86e0bbe 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -129,6 +129,8 @@ struct snd_pcm_ops {
 #define SNDRV_PCM_RATE_96000		(1<<10)		/* 96000Hz */
 #define SNDRV_PCM_RATE_176400		(1<<11)		/* 176400Hz */
 #define SNDRV_PCM_RATE_192000		(1<<12)		/* 192000Hz */
+#define SNDRV_PCM_RATE_352800		(1<<13)		/* 352800Hz */
+#define SNDRV_PCM_RATE_384000		(1<<14)		/* 384000Hz */
 
 #define SNDRV_PCM_RATE_CONTINUOUS	(1<<30)		/* continuous range */
 #define SNDRV_PCM_RATE_KNOT		(1<<31)		/* supports more non-continuos rates */
@@ -141,6 +143,9 @@ struct snd_pcm_ops {
 					 SNDRV_PCM_RATE_88200|SNDRV_PCM_RATE_96000)
 #define SNDRV_PCM_RATE_8000_192000	(SNDRV_PCM_RATE_8000_96000|SNDRV_PCM_RATE_176400|\
 					 SNDRV_PCM_RATE_192000)
+#define SNDRV_PCM_RATE_8000_384000	(SNDRV_PCM_RATE_8000_192000 |\
+					 SNDRV_PCM_RATE_352800 |\
+					 SNDRV_PCM_RATE_384000)
 #define _SNDRV_PCM_FMTBIT(fmt)		(1ULL << (__force int)SNDRV_PCM_FORMAT_##fmt)
 #define SNDRV_PCM_FMTBIT_S8		_SNDRV_PCM_FMTBIT(S8)
 #define SNDRV_PCM_FMTBIT_U8		_SNDRV_PCM_FMTBIT(U8)
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index c61fd50..21cc13d 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -1981,12 +1981,13 @@ static int snd_pcm_hw_rule_sample_bits(struct snd_pcm_hw_params *params,
 	return snd_interval_refine(hw_param_interval(params, rule->var), &t);
 }
 
-#if SNDRV_PCM_RATE_5512 != 1 << 0 || SNDRV_PCM_RATE_192000 != 1 << 12
+#if SNDRV_PCM_RATE_5512 != 1 << 0 || SNDRV_PCM_RATE_384000 != 1 << 14
 #error "Change this table"
 #endif
 
 static unsigned int rates[] = { 5512, 8000, 11025, 16000, 22050, 32000, 44100,
-                                 48000, 64000, 88200, 96000, 176400, 192000 };
+				 48000, 64000, 88200, 96000, 176400, 192000,
+				 352800, 384000 };
 
 const struct snd_pcm_hw_constraint_list snd_pcm_known_rates = {
 	.count = ARRAY_SIZE(rates),
-- 
2.5.5
