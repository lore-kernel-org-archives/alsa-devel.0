From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 9/9] ALSA: compress: use rate values for passing sampling rates
Date: Tue, 27 Aug 2013 12:10:39 +0530
Message-ID: <1377585639-29516-10-git-send-email-vinod.koul@intel.com>
References: <1377585639-29516-1-git-send-email-vinod.koul@intel.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1377585639-29516-1-git-send-email-vinod.koul@intel.com>
Sender: stable-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: broonie@kernel.org, lgirdwood@gmail.com, Vinod Koul <vinod.koul@intel.com>, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Clarify that its better to use the rate values like 8000, 12000, 11025, 44100,
48000 etc to send sampling rate values to driver. The changes kernel ABI but no
drivers exist upstream so okay to change now
Tinycompress to be fixed as well

For this change bump the API version as well

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Cc: <stable@vger.kernel.org>
---
 include/uapi/sound/compress_offload.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/uapi/sound/compress_offload.h b/include/uapi/sound/compress_offload.h
index d630163..cad87ff 100644
--- a/include/uapi/sound/compress_offload.h
+++ b/include/uapi/sound/compress_offload.h
@@ -62,7 +62,7 @@ struct snd_compr_params {
  *	progress. It shall not be used for timing estimates.
  * @pcm_io_frames: Frames rendered or received by DSP into a mixer or an audio
  * output/input. This field should be used for A/V sync or time estimates.
- * @sampling_rate: sampling rate of audio
+ * @sampling_rate: sampling rate value of audio,  eg 12000, 48000
  */
 struct snd_compr_tstamp {
 	__u32 byte_offset;
-- 
1.7.0.4
