From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 3/3] ALSA: compress: update struct
	snd_codec_desc for sample rate
Date: Sat,  4 Jan 2014 16:59:13 +0530
Message-ID: <1388834953-3200-4-git-send-email-vinod.koul@intel.com>
References: <1388834953-3200-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 82F00261A8C
 for <alsa-devel@alsa-project.org>; Sat,  4 Jan 2014 13:29:41 +0100 (CET)
In-Reply-To: <1388834953-3200-1-git-send-email-vinod.koul@intel.com>
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
Cc: tiwai@suse.de, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Now that we don't use SNDRV_PCM_RATE_xxx bit fields for sample rate, we need to
change the description to an array for describing the sample rates supported by
the sink/source

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 include/uapi/sound/compress_params.h |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/include/uapi/sound/compress_params.h b/include/uapi/sound/compress_params.h
index 5224a06..7cb9d5f 100644
--- a/include/uapi/sound/compress_params.h
+++ b/include/uapi/sound/compress_params.h
@@ -57,6 +57,7 @@
 #define MAX_NUM_CODECS 32
 #define MAX_NUM_CODEC_DESCRIPTORS 32
 #define MAX_NUM_BITRATES 32
+#define MAX_NUM_SAMPLE_RATES 32
 
 /* Codecs are listed linearly to allow for extensibility */
 #define SND_AUDIOCODEC_PCM                   ((__u32) 0x00000001)
@@ -346,7 +347,7 @@ union snd_codec_options {
 
 struct snd_codec_desc {
 	__u32 max_ch;
-	__u32 sample_rates;
+	__u32 sample_rates[MAX_NUM_SAMPLE_RATES];
 	__u32 bit_rate[MAX_NUM_BITRATES];
 	__u32 num_bitrates;
 	__u32 rate_control;
-- 
1.7.0.4
