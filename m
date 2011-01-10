From: Nitin Daga <ndaga@nvidia.com>
Subject: [PATCH] ALSA: hda: Disable 4/6 channels on some NVIDIA
	GPUs.
Date: Mon, 10 Jan 2011 21:49:31 +0530
Message-ID: <1294676371-1401-1-git-send-email-ndaga@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate03.nvidia.com (hqemgate03.nvidia.com [216.228.121.140])
	by alsa0.perex.cz (Postfix) with ESMTP id C386C24508
	for <alsa-devel@alsa-project.org>; Mon, 10 Jan 2011 17:21:32 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Nitin Daga <ndaga@nvidia.com>
List-Id: alsa-devel@alsa-project.org

Added hardware constraint in patch_hdmi.c to disable
channels 4/6 which are not supported by some older
NVIDIA GPUs.

Signed-off-by: Nitin Daga <ndaga@nvidia.com>
Acked-By: Stephen Warren <swarren@nvidia.com>
---
 pci/hda/patch_hdmi.c |   42 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 42 insertions(+), 0 deletions(-)

diff --git a/pci/hda/patch_hdmi.c b/pci/hda/patch_hdmi.c
index d3e49aa..ddde59b 100644
--- a/pci/hda/patch_hdmi.c
+++ b/pci/hda/patch_hdmi.c
@@ -1166,11 +1166,53 @@ static int nvhdmi_7x_init(struct hda_codec *codec)
 	return 0;
 }
 
+static unsigned int channels_2_6_8[] = {
+	2, 6, 8
+};
+
+static unsigned int channels_2_8[] = {
+	2, 8
+};
+
+static struct snd_pcm_hw_constraint_list hw_constraints_2_6_8_channels = {
+	.count = ARRAY_SIZE(channels_2_6_8),
+	.list = channels_2_6_8,
+	.mask = 0,
+};
+
+static struct snd_pcm_hw_constraint_list hw_constraints_2_8_channels = {
+	.count = ARRAY_SIZE(channels_2_8),
+	.list = channels_2_8,
+	.mask = 0,
+};
+
 static int simple_playback_pcm_open(struct hda_pcm_stream *hinfo,
 				    struct hda_codec *codec,
 				    struct snd_pcm_substream *substream)
 {
 	struct hdmi_spec *spec = codec->spec;
+	struct snd_pcm_hw_constraint_list *hw_constraints_channels = NULL;
+
+	switch (codec->preset->id) {
+	case 0x10de0002:
+	case 0x10de0003:
+	case 0x10de0005:
+	case 0x10de0006:
+		hw_constraints_channels = &hw_constraints_2_8_channels;
+		break;
+	case 0x10de0007:
+		hw_constraints_channels = &hw_constraints_2_6_8_channels;
+		break;
+	default:
+		break;
+	}
+
+	if (hw_constraints_channels != NULL) {
+		snd_pcm_hw_constraint_list(substream->runtime, 0,
+				SNDRV_PCM_HW_PARAM_CHANNELS,
+				hw_constraints_channels);
+	}
+
 	return snd_hda_multi_out_dig_open(codec, &spec->multiout);
 }
 
-- 
1.7.0.4


-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
