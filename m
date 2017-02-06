From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH -next] ASoC: hdmi-codec: fix non static symbol warnings
Date: Mon,  6 Feb 2017 14:38:30 +0000
Message-ID: <20170206143830.6871-1-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Philipp Zabel <p.zabel@pengutronix.de>, "Jon Medhurst (Tixy)" <tixy@linaro.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Arnaud Pouliquen <arnaud.pouliquen@st.com>, Jyri Sarha <jsarha@ti.com>, PC Liao <pc.liao@mediatek.com>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Wei Yongjun <weiyongjun1@huawei.com>

Fixes the following sparse warnings:

sound/soc/codecs/hdmi-codec.c:34:1: warning:
 symbol 'hdmi_device_list' was not declared. Should it be static?
sound/soc/codecs/hdmi-codec.c:80:33: warning:
 symbol 'hdmi_codec_stereo_chmaps' was not declared. Should it be static?
sound/soc/codecs/hdmi-codec.c:87:33: warning:
 symbol 'hdmi_codec_8ch_chmaps' was not declared. Should it be static?
sound/soc/codecs/hdmi-codec.c:354:6: warning:
 symbol 'hdmi_codec_eld_chmap' was not declared. Should it be static?

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 sound/soc/codecs/hdmi-codec.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index dc6715a..4982c91 100644
--- a/sound/soc/codecs/hdmi-codec.c
+++ b/sound/soc/codecs/hdmi-codec.c
@@ -31,7 +31,7 @@ struct hdmi_device {
 	int cnt;
 };
 #define pos_to_hdmi_device(pos)	container_of((pos), struct hdmi_device, list)
-LIST_HEAD(hdmi_device_list);
+static LIST_HEAD(hdmi_device_list);
 
 #define DAI_NAME_SIZE 16
 
@@ -77,14 +77,14 @@ struct hdmi_codec_cea_spk_alloc {
 };
 
 /* Channel maps  stereo HDMI */
-const struct snd_pcm_chmap_elem hdmi_codec_stereo_chmaps[] = {
+static const struct snd_pcm_chmap_elem hdmi_codec_stereo_chmaps[] = {
 	{ .channels = 2,
 	  .map = { SNDRV_CHMAP_FL, SNDRV_CHMAP_FR } },
 	{ }
 };
 
 /* Channel maps for multi-channel playbacks, up to 8 n_ch */
-const struct snd_pcm_chmap_elem hdmi_codec_8ch_chmaps[] = {
+static const struct snd_pcm_chmap_elem hdmi_codec_8ch_chmaps[] = {
 	{ .channels = 2, /* CA_ID 0x00 */
 	  .map = { SNDRV_CHMAP_FL, SNDRV_CHMAP_FR } },
 	{ .channels = 4, /* CA_ID 0x01 */
@@ -351,7 +351,7 @@ static unsigned long hdmi_codec_spk_mask_from_alloc(int spk_alloc)
 	return spk_mask;
 }
 
-void hdmi_codec_eld_chmap(struct hdmi_codec_priv *hcp)
+static void hdmi_codec_eld_chmap(struct hdmi_codec_priv *hcp)
 {
 	u8 spk_alloc;
 	unsigned long spk_mask;
