From: Thomas Klausner <tk@giga.or.at>
Subject: [PATCH 3/3] Use uint*_t instead of __le*.
Date: Mon, 29 Feb 2016 16:05:21 +0100
Message-ID: <1456758321-2256-3-git-send-email-tk@giga.or.at>
References: <56D010C4.3000804@ladisch.de>
 <1456758321-2256-1-git-send-email-tk@giga.or.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vie01a-dmta-pe02-3.mx.upcmail.net
 (vie01a-dmta-pe02-3.mx.upcmail.net [62.179.121.159])
 by alsa0.perex.cz (Postfix) with ESMTP id 95701260698
 for <alsa-devel@alsa-project.org>; Mon, 29 Feb 2016 16:22:11 +0100 (CET)
Received: from [172.31.216.44] (helo=vie01a-pemc-psmtp-pe02)
 by vie01a-dmta-pe02.mx.upcmail.net with esmtp (Exim 4.72)
 (envelope-from <wiz@yt.nih.at>) id 1aaPeF-0002Gu-Do
 for alsa-devel@alsa-project.org; Mon, 29 Feb 2016 16:22:11 +0100
In-Reply-To: <1456758321-2256-1-git-send-email-tk@giga.or.at>
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
Cc: Thomas Klausner <wiz@NetBSD.org>
List-Id: alsa-devel@alsa-project.org

From: Thomas Klausner <wiz@NetBSD.org>

For better portability.
---
 include/sound/asoc.h | 178 +++++++++++++++++++++++++--------------------------
 1 file changed, 89 insertions(+), 89 deletions(-)

diff --git a/include/sound/asoc.h b/include/sound/asoc.h
index a29c05c..05bdae7 100644
--- a/include/sound/asoc.h
+++ b/include/sound/asoc.h
@@ -112,15 +112,15 @@
  * This header precedes all object and object arrays below.
  */
 struct snd_soc_tplg_hdr {
-	__le32 magic;		/* magic number */
-	__le32 abi;		/* ABI version */
-	__le32 version;		/* optional vendor specific version details */
-	__le32 type;		/* SND_SOC_TPLG_TYPE_ */
-	__le32 size;		/* size of this structure */
-	__le32 vendor_type;	/* optional vendor specific type info */
-	__le32 payload_size;	/* data bytes, excluding this header */
-	__le32 index;		/* identifier for block */
-	__le32 count;		/* number of elements in block */
+	uint32_t magic;		/* magic number */
+	uint32_t abi;		/* ABI version */
+	uint32_t version;		/* optional vendor specific version details */
+	uint32_t type;		/* SND_SOC_TPLG_TYPE_ */
+	uint32_t size;		/* size of this structure */
+	uint32_t vendor_type;	/* optional vendor specific type info */
+	uint32_t payload_size;	/* data bytes, excluding this header */
+	uint32_t index;		/* identifier for block */
+	uint32_t count;		/* number of elements in block */
 } __attribute__((packed));
 
 /*
@@ -129,7 +129,7 @@ struct snd_soc_tplg_hdr {
  * firmware. Core will ignore this data.
  */
 struct snd_soc_tplg_private {
-	__le32 size;	/* in bytes of private data */
+	uint32_t size;	/* in bytes of private data */
 	char data[0];
 } __attribute__((packed));
 
@@ -137,16 +137,16 @@ struct snd_soc_tplg_private {
  * Kcontrol TLV data.
  */
 struct snd_soc_tplg_tlv_dbscale {
-	__le32 min;
-	__le32 step;
-	__le32 mute;
+	uint32_t min;
+	uint32_t step;
+	uint32_t mute;
 } __attribute__((packed));
 
 struct snd_soc_tplg_ctl_tlv {
-	__le32 size;	/* in bytes of this structure */
-	__le32 type;	/* SNDRV_CTL_TLVT_*, type of TLV */
+	uint32_t size;	/* in bytes of this structure */
+	uint32_t type;	/* SNDRV_CTL_TLVT_*, type of TLV */
 	union {
-		__le32 data[SND_SOC_TPLG_TLV_SIZE];
+		uint32_t data[SND_SOC_TPLG_TLV_SIZE];
 		struct snd_soc_tplg_tlv_dbscale scale;
 	};
 } __attribute__((packed));
@@ -155,10 +155,10 @@ struct snd_soc_tplg_ctl_tlv {
  * Kcontrol channel data
  */
 struct snd_soc_tplg_channel {
-	__le32 size;	/* in bytes of this structure */
-	__le32 reg;
-	__le32 shift;
-	__le32 id;	/* ID maps to Left, Right, LFE etc */
+	uint32_t size;	/* in bytes of this structure */
+	uint32_t reg;
+	uint32_t shift;
+	uint32_t id;	/* ID maps to Left, Right, LFE etc */
 } __attribute__((packed));
 
 /*
@@ -167,19 +167,19 @@ struct snd_soc_tplg_channel {
  * Bytes ext ops need get/put.
  */
 struct snd_soc_tplg_io_ops {
-	__le32 get;
-	__le32 put;
-	__le32 info;
+	uint32_t get;
+	uint32_t put;
+	uint32_t info;
 } __attribute__((packed));
 
 /*
  * kcontrol header
  */
 struct snd_soc_tplg_ctl_hdr {
-	__le32 size;	/* in bytes of this structure */
-	__le32 type;
+	uint32_t size;	/* in bytes of this structure */
+	uint32_t type;
 	char name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
-	__le32 access;
+	uint32_t access;
 	struct snd_soc_tplg_io_ops ops;
 	struct snd_soc_tplg_ctl_tlv tlv;
 } __attribute__((packed));
@@ -188,33 +188,33 @@ struct snd_soc_tplg_ctl_hdr {
  * Stream Capabilities
  */
 struct snd_soc_tplg_stream_caps {
-	__le32 size;		/* in bytes of this structure */
+	uint32_t size;		/* in bytes of this structure */
 	char name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
-	__le64 formats;	/* supported formats SNDRV_PCM_FMTBIT_* */
-	__le32 rates;		/* supported rates SNDRV_PCM_RATE_* */
-	__le32 rate_min;	/* min rate */
-	__le32 rate_max;	/* max rate */
-	__le32 channels_min;	/* min channels */
-	__le32 channels_max;	/* max channels */
-	__le32 periods_min;	/* min number of periods */
-	__le32 periods_max;	/* max number of periods */
-	__le32 period_size_min;	/* min period size bytes */
-	__le32 period_size_max;	/* max period size bytes */
-	__le32 buffer_size_min;	/* min buffer size bytes */
-	__le32 buffer_size_max;	/* max buffer size bytes */
+	uint64_t formats;	/* supported formats SNDRV_PCM_FMTBIT_* */
+	uint32_t rates;		/* supported rates SNDRV_PCM_RATE_* */
+	uint32_t rate_min;	/* min rate */
+	uint32_t rate_max;	/* max rate */
+	uint32_t channels_min;	/* min channels */
+	uint32_t channels_max;	/* max channels */
+	uint32_t periods_min;	/* min number of periods */
+	uint32_t periods_max;	/* max number of periods */
+	uint32_t period_size_min;	/* min period size bytes */
+	uint32_t period_size_max;	/* max period size bytes */
+	uint32_t buffer_size_min;	/* min buffer size bytes */
+	uint32_t buffer_size_max;	/* max buffer size bytes */
 } __attribute__((packed));
 
 /*
  * FE or BE Stream configuration supported by SW/FW
  */
 struct snd_soc_tplg_stream {
-	__le32 size;		/* in bytes of this structure */
+	uint32_t size;		/* in bytes of this structure */
 	char name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN]; /* Name of the stream */
-	__le64 format;		/* SNDRV_PCM_FMTBIT_* */
-	__le32 rate;		/* SNDRV_PCM_RATE_* */
-	__le32 period_bytes;	/* size of period in bytes */
-	__le32 buffer_bytes;	/* size of buffer in bytes */
-	__le32 channels;	/* channels */
+	uint64_t format;		/* SNDRV_PCM_FMTBIT_* */
+	uint32_t rate;		/* SNDRV_PCM_RATE_* */
+	uint32_t period_bytes;	/* size of period in bytes */
+	uint32_t buffer_bytes;	/* size of buffer in bytes */
+	uint32_t channels;	/* channels */
 } __attribute__((packed));
 
 /*
@@ -230,12 +230,12 @@ struct snd_soc_tplg_stream {
  * +-----------------------------------+----+
  */
 struct snd_soc_tplg_manifest {
-	__le32 size;		/* in bytes of this structure */
-	__le32 control_elems;	/* number of control elements */
-	__le32 widget_elems;	/* number of widget elements */
-	__le32 graph_elems;	/* number of graph elements */
-	__le32 pcm_elems;	/* number of PCM elements */
-	__le32 dai_link_elems;	/* number of DAI link elements */
+	uint32_t size;		/* in bytes of this structure */
+	uint32_t control_elems;	/* number of control elements */
+	uint32_t widget_elems;	/* number of widget elements */
+	uint32_t graph_elems;	/* number of graph elements */
+	uint32_t pcm_elems;	/* number of PCM elements */
+	uint32_t dai_link_elems;	/* number of DAI link elements */
 	struct snd_soc_tplg_private priv;
 } __attribute__((packed));
 
@@ -251,12 +251,12 @@ struct snd_soc_tplg_manifest {
  */
 struct snd_soc_tplg_mixer_control {
 	struct snd_soc_tplg_ctl_hdr hdr;
-	__le32 size;	/* in bytes of this structure */
-	__le32 min;
-	__le32 max;
-	__le32 platform_max;
-	__le32 invert;
-	__le32 num_channels;
+	uint32_t size;	/* in bytes of this structure */
+	uint32_t min;
+	uint32_t max;
+	uint32_t platform_max;
+	uint32_t invert;
+	uint32_t num_channels;
 	struct snd_soc_tplg_channel channel[SND_SOC_TPLG_MAX_CHAN];
 	struct snd_soc_tplg_private priv;
 } __attribute__((packed));
@@ -273,14 +273,14 @@ struct snd_soc_tplg_mixer_control {
  */
 struct snd_soc_tplg_enum_control {
 	struct snd_soc_tplg_ctl_hdr hdr;
-	__le32 size;	/* in bytes of this structure */
-	__le32 num_channels;
+	uint32_t size;	/* in bytes of this structure */
+	uint32_t num_channels;
 	struct snd_soc_tplg_channel channel[SND_SOC_TPLG_MAX_CHAN];
-	__le32 items;
-	__le32 mask;
-	__le32 count;
+	uint32_t items;
+	uint32_t mask;
+	uint32_t count;
 	char texts[SND_SOC_TPLG_NUM_TEXTS][SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
-	__le32 values[SND_SOC_TPLG_NUM_TEXTS * SNDRV_CTL_ELEM_ID_NAME_MAXLEN / 4];
+	uint32_t values[SND_SOC_TPLG_NUM_TEXTS * SNDRV_CTL_ELEM_ID_NAME_MAXLEN / 4];
 	struct snd_soc_tplg_private priv;
 } __attribute__((packed));
 
@@ -296,11 +296,11 @@ struct snd_soc_tplg_enum_control {
  */
 struct snd_soc_tplg_bytes_control {
 	struct snd_soc_tplg_ctl_hdr hdr;
-	__le32 size;	/* in bytes of this structure */
-	__le32 max;
-	__le32 mask;
-	__le32 base;
-	__le32 num_regs;
+	uint32_t size;	/* in bytes of this structure */
+	uint32_t max;
+	uint32_t mask;
+	uint32_t base;
+	uint32_t num_regs;
 	struct snd_soc_tplg_io_ops ext_ops;
 	struct snd_soc_tplg_private priv;
 } __attribute__((packed));
@@ -338,20 +338,20 @@ struct snd_soc_tplg_dapm_graph_elem {
  * in the block.
  */
 struct snd_soc_tplg_dapm_widget {
-	__le32 size;		/* in bytes of this structure */
-	__le32 id;		/* SND_SOC_DAPM_CTL */
+	uint32_t size;		/* in bytes of this structure */
+	uint32_t id;		/* SND_SOC_DAPM_CTL */
 	char name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
 	char sname[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
 
-	__le32 reg;		/* negative reg = no direct dapm */
-	__le32 shift;		/* bits to shift */
-	__le32 mask;		/* non-shifted mask */
-	__le32 subseq;		/* sort within widget type */
-	__le32 invert;		/* invert the power bit */
-	__le32 ignore_suspend;	/* kept enabled over suspend */
-	__le16 event_flags;
-	__le16 event_type;
-	__le32 num_kcontrols;
+	uint32_t reg;		/* negative reg = no direct dapm */
+	uint32_t shift;		/* bits to shift */
+	uint32_t mask;		/* non-shifted mask */
+	uint32_t subseq;		/* sort within widget type */
+	uint32_t invert;		/* invert the power bit */
+	uint32_t ignore_suspend;	/* kept enabled over suspend */
+	uint16_t event_flags;
+	uint16_t event_type;
+	uint32_t num_kcontrols;
 	struct snd_soc_tplg_private priv;
 	/*
 	 * kcontrols that relate to this widget
@@ -371,16 +371,16 @@ struct snd_soc_tplg_dapm_widget {
  * +-----------------------------------+-----+
  */
 struct snd_soc_tplg_pcm {
-	__le32 size;		/* in bytes of this structure */
+	uint32_t size;		/* in bytes of this structure */
 	char pcm_name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
 	char dai_name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
-	__le32 pcm_id;		/* unique ID - used to match */
-	__le32 dai_id;		/* unique ID - used to match */
-	__le32 playback;	/* supports playback mode */
-	__le32 capture;		/* supports capture mode */
-	__le32 compress;	/* 1 = compressed; 0 = PCM */
+	uint32_t pcm_id;		/* unique ID - used to match */
+	uint32_t dai_id;		/* unique ID - used to match */
+	uint32_t playback;	/* supports playback mode */
+	uint32_t capture;		/* supports capture mode */
+	uint32_t compress;	/* 1 = compressed; 0 = PCM */
 	struct snd_soc_tplg_stream stream[SND_SOC_TPLG_STREAM_CONFIG_MAX]; /* for DAI link */
-	__le32 num_streams;	/* number of streams */
+	uint32_t num_streams;	/* number of streams */
 	struct snd_soc_tplg_stream_caps caps[2]; /* playback and capture for DAI */
 } __attribute__((packed));
 
@@ -396,9 +396,9 @@ struct snd_soc_tplg_pcm {
  * +-----------------------------------+-----+
  */
 struct snd_soc_tplg_link_config {
-	__le32 size;            /* in bytes of this structure */
-	__le32 id;              /* unique ID - used to match */
+	uint32_t size;            /* in bytes of this structure */
+	uint32_t id;              /* unique ID - used to match */
 	struct snd_soc_tplg_stream stream[SND_SOC_TPLG_STREAM_CONFIG_MAX]; /* supported configs playback and captrure */
-	__le32 num_streams;     /* number of streams */
+	uint32_t num_streams;     /* number of streams */
 } __attribute__((packed));
 #endif
-- 
2.7.1
