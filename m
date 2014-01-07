From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH] ALSA: compress: add num_sample_rates in
	snd_codec_desc
Date: Tue,  7 Jan 2014 21:55:42 +0530
Message-ID: <1389111942-20810-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
 by alsa0.perex.cz (Postfix) with ESMTP id D5444261A7C
 for <alsa-devel@alsa-project.org>; Tue,  7 Jan 2014 18:26:19 +0100 (CET)
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

this gives ability to convey the valid values of supported rates in
sample_rates array

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 include/uapi/sound/compress_params.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/uapi/sound/compress_params.h b/include/uapi/sound/compress_params.h
index b62b24b..165e705 100644
--- a/include/uapi/sound/compress_params.h
+++ b/include/uapi/sound/compress_params.h
@@ -326,6 +326,7 @@ union snd_codec_options {
 /** struct snd_codec_desc - description of codec capabilities
  * @max_ch: Maximum number of audio channels
  * @sample_rates: Sampling rates in Hz, use values like 48000 for this
+ * @num_sample_rates: Number of valid values in sample_rates array
  * @bit_rate: Indexed array containing supported bit rates
  * @num_bitrates: Number of valid values in bit_rate array
  * @rate_control: value is specified by SND_RATECONTROLMODE defines.
@@ -348,6 +349,7 @@ union snd_codec_options {
 struct snd_codec_desc {
 	__u32 max_ch;
 	__u32 sample_rates[MAX_NUM_SAMPLE_RATES];
+	__u32 num_sample_rates;
 	__u32 bit_rate[MAX_NUM_BITRATES];
 	__u32 num_bitrates;
 	__u32 rate_control;
-- 
1.7.0.4
