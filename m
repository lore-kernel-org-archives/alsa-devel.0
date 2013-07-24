From: Vinod Koul <vinod.koul@intel.com>
Subject: RFC: support for 12 & 24Khz
Date: Wed, 24 Jul 2013 22:56:40 +0530
Message-ID: <20130724172640.GE18642@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 22DF526553D
 for <alsa-devel@alsa-project.org>; Wed, 24 Jul 2013 20:05:16 +0200 (CEST)
Content-Disposition: inline
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
Cc: alsa-devel@alsa-project.org, pierre-louis.bossart@linux.jf.intel.com
List-Id: alsa-devel@alsa-project.org

Hey Takashi,

For compressed audio we also need to support the PCM rates of 12 and 24KHz.

Looking at pcm.h these are not defined so we can simply add them at the end.
But am worried about wider impact of adding these rates.

Can you let me know if more is required to be done or below is fine

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index 84b10f9..e418d8d 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -126,6 +126,8 @@ struct snd_pcm_ops {
 #define SNDRV_PCM_RATE_96000           (1<<10)         /* 96000Hz */
 #define SNDRV_PCM_RATE_176400          (1<<11)         /* 176400Hz */
 #define SNDRV_PCM_RATE_192000          (1<<12)         /* 192000Hz */
+#define SNDRV_PCM_RATE_12000           <1<<13>         /* 12000Hz */
+#define SNDRV_PCM_RATE_24000           <1<<14>         /* 24000Hz */

 #define SNDRV_PCM_RATE_CONTINUOUS      (1<<30)         /* continuous range */
 #define SNDRV_PCM_RATE_KNOT            (1<<31)         /* supports more
non-continuos rates */
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index a68d4c6..42600b0 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -1779,12 +1779,13 @@ static int snd_pcm_hw_rule_sample_bits(struct
snd_pcm_hw_params *params,
        return snd_interval_refine(hw_param_interval(params, rule->var), &t);
 }

-#if SNDRV_PCM_RATE_5512 != 1 << 0 || SNDRV_PCM_RATE_192000 != 1 << 12
+#if SNDRV_PCM_RATE_5512 != 1 << 0 || SNDRV_PCM_RATE_24000 != 1 << 14
 #error "Change this table"
 #endif

 static unsigned int rates[] = { 5512, 8000, 11025, 16000, 22050, 32000, 44100,
-                                 48000, 64000, 88200, 96000, 176400, 192000 };
+                                 48000, 64000, 88200, 96000, 176400, 192000,
+                                 12000, 24000 };

 const struct snd_pcm_hw_constraint_list snd_pcm_known_rates = {
        .count = ARRAY_SIZE(rates),

~Vinod
-- 
