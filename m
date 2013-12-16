From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH] ALSA: compress: change the way sample rates
	are sent to kernel
Date: Mon, 16 Dec 2013 14:55:34 +0530
Message-ID: <1387185934-3258-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id D4B4D261B0C
 for <alsa-devel@alsa-project.org>; Mon, 16 Dec 2013 11:24:24 +0100 (CET)
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
Cc: tiwai@suse.de, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

The usage of SNDRV_RATES is not effective as we can have rates like 12000 or
some other ones used by decoders. This change the usage of this to use the raw
Hz values to be sent to kernel

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 include/uapi/sound/compress_params.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/uapi/sound/compress_params.h b/include/uapi/sound/compress_params.h
index 602dc6c..1114e38 100644
--- a/include/uapi/sound/compress_params.h
+++ b/include/uapi/sound/compress_params.h
@@ -324,7 +324,7 @@ union snd_codec_options {
 
 /** struct snd_codec_desc - description of codec capabilities
  * @max_ch: Maximum number of audio channels
- * @sample_rates: Sampling rates in Hz, use SNDRV_PCM_RATE_xxx for this
+ * @sample_rates: Sampling rates in Hz, use values like 48000 for this
  * @bit_rate: Indexed array containing supported bit rates
  * @num_bitrates: Number of valid values in bit_rate array
  * @rate_control: value is specified by SND_RATECONTROLMODE defines.
-- 
1.7.0.4
