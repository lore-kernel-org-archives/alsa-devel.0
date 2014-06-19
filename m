From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 1/2] tinycompress: update compress headers for
	sample rate field
Date: Thu, 19 Jun 2014 15:07:02 +0530
Message-ID: <1403170623-6288-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 30DC5261A81
 for <alsa-devel@alsa-project.org>; Thu, 19 Jun 2014 11:36:31 +0200 (CEST)
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
Cc: Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

commit "929559b: ALSA: compress: add num_sample_rates in snd_codec_desc" adds
array for passing sample rate instead of bit map. Update the local header as
well

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 include/sound/compress_params.h |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/include/sound/compress_params.h b/include/sound/compress_params.h
index deda425..378417a 100644
--- a/include/sound/compress_params.h
+++ b/include/sound/compress_params.h
@@ -23,6 +23,7 @@
 #define MAX_NUM_CODECS 32
 #define MAX_NUM_CODEC_DESCRIPTORS 32
 #define MAX_NUM_BITRATES 32
+#define MAX_NUM_SAMPLE_RATES 32
 
 #define SND_AUDIOCODEC_PCM ((__u32) 0x00000001)
 #define SND_AUDIOCODEC_MP3 ((__u32) 0x00000002)
@@ -209,7 +210,8 @@ union snd_codec_options {
 
 struct snd_codec_desc {
  __u32 max_ch;
- __u32 sample_rates;
+ __u32 sample_rates[MAX_NUM_SAMPLE_RATES];
+ __u32 num_sample_rates;
  __u32 bit_rate[MAX_NUM_BITRATES];
  __u32 num_bitrates;
  __u32 rate_control;
-- 
1.7.0.4
