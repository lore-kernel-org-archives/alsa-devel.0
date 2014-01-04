From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 2/3] ALSA: compress: update comment for sample
	rate in snd_codec
Date: Sat,  4 Jan 2014 16:59:12 +0530
Message-ID: <1388834953-3200-3-git-send-email-vinod.koul@intel.com>
References: <1388834953-3200-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id C4887261A89
 for <alsa-devel@alsa-project.org>; Sat,  4 Jan 2014 13:29:39 +0100 (CET)
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

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 include/uapi/sound/compress_params.h |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/include/uapi/sound/compress_params.h b/include/uapi/sound/compress_params.h
index 1114e38..5224a06 100644
--- a/include/uapi/sound/compress_params.h
+++ b/include/uapi/sound/compress_params.h
@@ -364,7 +364,8 @@ struct snd_codec_desc {
  * @ch_out: Number of output channels. In case of contradiction between
  *		this field and the channelMode field, the channelMode field
  *		overrides.
- * @sample_rate: Audio sample rate of input data
+ * @sample_rate: Audio sample rate of input data in Hz, use values like 48000
+ *		for this.
  * @bit_rate: Bitrate of encoded data. May be ignored by decoders
  * @rate_control: Encoding rate control. See SND_RATECONTROLMODE defines.
  *               Encoders may rely on profiles for quality levels.
-- 
1.7.0.4
