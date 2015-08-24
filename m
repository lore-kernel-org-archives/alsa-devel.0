From: Qais Yousef <qais.yousef@imgtec.com>
Subject: [PATCH 09/10] ALSA: axd: add alsa compress offload operations
Date: Mon, 24 Aug 2015 13:39:18 +0100
Message-ID: <1440419959-14315-10-git-send-email-qais.yousef@imgtec.com>
References: <1440419959-14315-1-git-send-email-qais.yousef@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1440419959-14315-1-git-send-email-qais.yousef@imgtec.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: Qais Yousef <qais.yousef@imgtec.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Add implementation of alsa compress offload operations.
At the moment we only support playback only.

Signed-off-by: Qais Yousef <qais.yousef@imgtec.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: linux-kernel@vger.kernel.org
---
 sound/soc/img/axd/axd_alsa_ops.c | 211 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 211 insertions(+)
 create mode 100644 sound/soc/img/axd/axd_alsa_ops.c

diff --git a/sound/soc/img/axd/axd_alsa_ops.c b/sound/soc/img/axd/axd_alsa_ops.c
new file mode 100644
index 000000000000..91e17119b306
--- /dev/null
+++ b/sound/soc/img/axd/axd_alsa_ops.c
@@ -0,0 +1,211 @@
+/*
+ * Copyright (C) 2015 Imagination Technologies Ltd.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License version
+ * 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * AXD ALSA Compressed ops
+ */
+#include <sound/compress_driver.h>
+#include <sound/soc.h>
+
+#include "axd_cmds.h"
+#include "axd_module.h"
+
+static struct axd_dev *get_axd_from_cstream(struct snd_compr_stream *cstream)
+{
+	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
+	return snd_soc_platform_get_drvdata(rtd->platform);
+}
+
+static int copied_total;
+
+static int axd_compr_open(struct snd_compr_stream *cstream)
+{
+	struct axd_dev *axd = get_axd_from_cstream(cstream);
+
+	axd_cmd_output_set_sink(&axd->cmd, 0, 1);
+	return axd_cmd_inpipe_start(&axd->cmd, 0);
+}
+
+static int axd_compr_free(struct snd_compr_stream *cstream)
+{
+	struct axd_dev *axd = get_axd_from_cstream(cstream);
+
+	axd_cmd_inpipe_stop(&axd->cmd, 0);
+	copied_total = 0;
+
+	return 0;
+}
+
+static int axd_compr_set_params(struct snd_compr_stream *cstream,
+				struct snd_compr_params *params)
+{
+	int ret;
+	struct axd_dev *axd = get_axd_from_cstream(cstream);
+
+	ret = axd_cmd_input_set_decoder_params(&axd->cmd, 0, &params->codec);
+	if (ret)
+		return -EINVAL;
+	return 0;
+}
+
+static int axd_compr_get_params(struct snd_compr_stream *cstream,
+				struct snd_codec *params)
+{
+	int ret;
+	struct axd_dev *axd = get_axd_from_cstream(cstream);
+
+	ret = axd_cmd_input_get_decoder_params(&axd->cmd, 0, params);
+	if (ret)
+		return -EIO;
+	return 0;
+}
+
+static int axd_compr_trigger(struct snd_compr_stream *cstream, int cmd)
+{
+	struct axd_dev *axd = get_axd_from_cstream(cstream);
+
+	if (cmd == SND_COMPR_TRIGGER_PARTIAL_DRAIN ||
+		cmd == SND_COMPR_TRIGGER_DRAIN) {
+		/* stop to send EOS which will cause the stream to be drained */
+		axd_cmd_inpipe_stop(&axd->cmd, 0);
+
+		/*
+		 * start again, repeating if EAGAIN is returned meaning we're
+		 * being drained
+		 */
+		while (axd_cmd_inpipe_start(&axd->cmd, 0) == -EAGAIN)
+			cpu_relax();
+
+		copied_total = 0;
+	}
+	return 0;
+}
+
+static int axd_compr_pointer(struct snd_compr_stream *cstream,
+			     struct snd_compr_tstamp *tstamp)
+{
+	tstamp->copied_total = copied_total;
+	return 0;
+}
+
+static int axd_compr_copy(struct snd_compr_stream *cstream, char __user *buf,
+			  size_t count)
+{
+	struct axd_dev *axd = get_axd_from_cstream(cstream);
+	int ret;
+
+	ret = axd_cmd_send_buffer(&axd->cmd, 0, buf, count);
+	if (ret < 0) {
+		dev_err(axd->dev, "failed to write buffer %d\n", ret);
+		return ret;
+	}
+	copied_total += ret;
+
+	return ret;
+}
+
+static int axd_compr_get_caps(struct snd_compr_stream *cstream,
+			      struct snd_compr_caps *caps)
+{
+	struct axd_dev *axd = get_axd_from_cstream(cstream);
+
+	caps->min_fragment_size = 1024*2;
+	caps->max_fragment_size = 1024*2;
+	caps->min_fragments= 1;
+	caps->max_fragments= 5;
+
+	axd_cmd_get_decoders(&axd->cmd, caps);
+
+	return 0;
+}
+
+static int axd_compr_get_codec_caps(struct snd_compr_stream *cstream,
+				    struct snd_compr_codec_caps *codec)
+{
+	switch (codec->codec) {
+	case SND_AUDIOCODEC_PCM:
+		codec->num_descriptors = 1;
+		codec->descriptor[0].max_ch = 2;
+		codec->descriptor[0].sample_rates[0] = 96000;
+		codec->descriptor[0].sample_rates[1] = 64000;
+		codec->descriptor[0].sample_rates[2] = 48000;
+		codec->descriptor[0].sample_rates[3] = 44100;
+		codec->descriptor[0].sample_rates[4] = 32000;
+		codec->descriptor[0].sample_rates[5] = 16000;
+		codec->descriptor[0].sample_rates[6] = 8000;
+		codec->descriptor[0].num_sample_rates = 7;
+		codec->descriptor[0].num_bitrates = 0;
+		codec->descriptor[0].profiles = 0;
+		codec->descriptor[0].modes = 0;
+		codec->descriptor[0].formats = 0;
+		break;
+	case SND_AUDIOCODEC_MP3:
+		codec->num_descriptors = 1;
+		codec->descriptor[0].max_ch = 2;
+		codec->descriptor[0].num_sample_rates = 0;
+		codec->descriptor[0].num_bitrates = 0;
+		codec->descriptor[0].profiles = 0;
+		codec->descriptor[0].modes = 0;
+		codec->descriptor[0].formats = 0;
+		break;
+	case SND_AUDIOCODEC_AAC:
+		codec->num_descriptors = 1;
+		codec->descriptor[0].max_ch = 6;
+		codec->descriptor[0].num_sample_rates = 0;
+		codec->descriptor[0].num_bitrates = 0;
+		codec->descriptor[0].profiles = 0;
+		codec->descriptor[0].modes = SND_AUDIOMODE_AAC_MAIN |
+			SND_AUDIOMODE_AAC_LC | SND_AUDIOMODE_AAC_SSR;
+		codec->descriptor[0].formats = SND_AUDIOSTREAMFORMAT_MP2ADTS |
+			SND_AUDIOSTREAMFORMAT_MP4ADTS | SND_AUDIOSTREAMFORMAT_ADIF |
+			SND_AUDIOSTREAMFORMAT_RAW;
+		break;
+	case SND_AUDIOCODEC_VORBIS:
+		codec->num_descriptors = 0;
+		break;
+	case SND_AUDIOCODEC_FLAC:
+		codec->num_descriptors = 1;
+		codec->descriptor[0].max_ch = 6;
+		codec->descriptor[0].num_sample_rates = 0;
+		codec->descriptor[0].num_bitrates = 0;
+		codec->descriptor[0].profiles = 0;
+		codec->descriptor[0].modes = 0;
+		codec->descriptor[0].formats = SND_AUDIOSTREAMFORMAT_FLAC;
+		break;
+	case SND_AUDIOCODEC_WMA:
+		codec->num_descriptors = 1;
+		codec->descriptor[0].max_ch = 6;
+		codec->descriptor[0].num_sample_rates = 0;
+		codec->descriptor[0].num_bitrates = 0;
+		codec->descriptor[0].profiles = SND_AUDIOPROFILE_WMA7 |
+			SND_AUDIOPROFILE_WMA8 | SND_AUDIOPROFILE_WMA9 |
+			SND_AUDIOPROFILE_WMA10;
+		codec->descriptor[0].modes = 0;
+		codec->descriptor[0].formats = SND_AUDIOSTREAMFORMAT_WMA_NOASF_HDR;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+struct snd_compr_ops axd_compr_ops = {
+	.open		= axd_compr_open,
+	.free		= axd_compr_free,
+	.set_params	= axd_compr_set_params,
+	.get_params	= axd_compr_get_params,
+	.trigger	= axd_compr_trigger,
+	.pointer	= axd_compr_pointer,
+	.copy		= axd_compr_copy,
+	.get_caps	= axd_compr_get_caps,
+	.get_codec_caps	= axd_compr_get_codec_caps
+};
-- 
2.1.0
