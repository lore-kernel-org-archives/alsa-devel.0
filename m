From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v2 7/8] ASoC: Intel: remove codec memeber from
	codec structs
Date: Mon,  5 May 2014 22:19:24 +0530
Message-ID: <1399308565-14620-8-git-send-email-vinod.koul@intel.com>
References: <1399308565-14620-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id EFC152610D4
 for <alsa-devel@alsa-project.org>; Mon,  5 May 2014 19:03:00 +0200 (CEST)
In-Reply-To: <1399308565-14620-1-git-send-email-vinod.koul@intel.com>
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
Cc: Vinod Koul <vinod.koul@intel.com>, jeeja.kp@intel.com, broonie@kernel.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

as we already have a memeber struct snd_sst_params.codec to fill this.
so removing duplicate instance

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/sst-mfld-dsp.h               |    4 ----
 sound/soc/intel/sst-mfld-platform-compress.c |    2 --
 sound/soc/intel/sst-mfld-platform-pcm.c      |    1 -
 3 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/sound/soc/intel/sst-mfld-dsp.h b/sound/soc/intel/sst-mfld-dsp.h
index a74477a..8d482d7 100644
--- a/sound/soc/intel/sst-mfld-dsp.h
+++ b/sound/soc/intel/sst-mfld-dsp.h
@@ -36,7 +36,6 @@ enum stream_type {
 };
 
 struct snd_pcm_params {
-	u16 codec;	/* codec type */
 	u8 num_chan;	/* 1=Mono, 2=Stereo */
 	u8 pcm_wd_sz;	/* 16/24 - bit*/
 	u32 reserved;	/* Bitrate in bits per second */
@@ -49,7 +48,6 @@ struct snd_pcm_params {
 
 /* MP3 Music Parameters Message */
 struct snd_mp3_params {
-	u16 codec;
 	u8  num_chan;	/* 1=Mono, 2=Stereo	*/
 	u8  pcm_wd_sz; /* 16/24 - bit*/
 	u8  crc_check; /* crc_check - disable (0) or enable (1) */
@@ -63,7 +61,6 @@ struct snd_mp3_params {
 
 /* AAC Music Parameters Message */
 struct snd_aac_params {
-	u16 codec;
 	u8 num_chan; /* 1=Mono, 2=Stereo*/
 	u8 pcm_wd_sz; /* 16/24 - bit*/
 	u8 bdownsample; /*SBR downsampling 0 - disable 1 -enabled AAC+ only */
@@ -77,7 +74,6 @@ struct snd_aac_params {
 
 /* WMA Music Parameters Message */
 struct snd_wma_params {
-	u16 codec;
 	u8  num_chan;	/* 1=Mono, 2=Stereo */
 	u8  pcm_wd_sz;	/* 16/24 - bit*/
 	u32 brate;	/* Use the hard coded value. */
diff --git a/sound/soc/intel/sst-mfld-platform-compress.c b/sound/soc/intel/sst-mfld-platform-compress.c
index 5c3e234..02abd19 100644
--- a/sound/soc/intel/sst-mfld-platform-compress.c
+++ b/sound/soc/intel/sst-mfld-platform-compress.c
@@ -112,7 +112,6 @@ static int sst_platform_compr_set_params(struct snd_compr_stream *cstream,
 	switch (params->codec.id) {
 	case SND_AUDIOCODEC_MP3: {
 		str_params.codec = SST_CODEC_TYPE_MP3;
-		str_params.sparams.uc.mp3_params.codec = SST_CODEC_TYPE_MP3;
 		str_params.sparams.uc.mp3_params.num_chan = params->codec.ch_in;
 		str_params.sparams.uc.mp3_params.pcm_wd_sz = 16;
 		break;
@@ -120,7 +119,6 @@ static int sst_platform_compr_set_params(struct snd_compr_stream *cstream,
 
 	case SND_AUDIOCODEC_AAC: {
 		str_params.codec = SST_CODEC_TYPE_AAC;
-		str_params.sparams.uc.aac_params.codec = SST_CODEC_TYPE_AAC;
 		str_params.sparams.uc.aac_params.num_chan = params->codec.ch_in;
 		str_params.sparams.uc.aac_params.pcm_wd_sz = 16;
 		if (params->codec.format == SND_AUDIOSTREAMFORMAT_MP4ADTS)
diff --git a/sound/soc/intel/sst-mfld-platform-pcm.c b/sound/soc/intel/sst-mfld-platform-pcm.c
index 3f9cd77..380802a 100644
--- a/sound/soc/intel/sst-mfld-platform-pcm.c
+++ b/sound/soc/intel/sst-mfld-platform-pcm.c
@@ -151,7 +151,6 @@ static void sst_fill_pcm_params(struct snd_pcm_substream *substream,
 				struct sst_pcm_params *param)
 {
 
-	param->codec = SST_CODEC_TYPE_PCM;
 	param->num_chan = (u8) substream->runtime->channels;
 	param->pcm_wd_sz = substream->runtime->sample_bits;
 	param->reserved = 0;
-- 
1.7.0.4
