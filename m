From: Takashi Sakamoto <takashi.sakamoto@miraclelinux.com>
Subject: [PATCH v2] ASoC: hdmi-codec: fix non static symbol
	warnings
Date: Mon, 13 Mar 2017 11:26:18 +0900
Message-ID: <20170313022618.21103-1-takashi.sakamoto@miraclelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f47.google.com (mail-pg0-f47.google.com [74.125.83.47])
 by alsa0.perex.cz (Postfix) with ESMTP id 50E132666E1
 for <alsa-devel@alsa-project.org>; Mon, 13 Mar 2017 03:26:39 +0100 (CET)
Received: by mail-pg0-f47.google.com with SMTP id 77so57981360pgc.1
 for <alsa-devel@alsa-project.org>; Sun, 12 Mar 2017 19:26:39 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, kuninori.morimoto.gx@renesas.com, arnaud.pouliquen@st.com, weiyongjun1@huawei.com
Cc: ichiro.suzuki@miraclelinux.com, alsa-devel@alsa-project.org, Takashi Sakamoto <o-takashi@sakamocchi.jp>, yukie.kato@miraclelinux.com
List-Id: alsa-devel@alsa-project.org

Fixes the following sparse warnings:

$ make C=2 sound/soc/codecs/hdmi-codec.o
sound/soc/codecs/hdmi-codec.c:34:1: warning:
 symbol 'hdmi_device_list' was not declared. Should it be static?
sound/soc/codecs/hdmi-codec.c:80:33: warning:
 symbol 'hdmi_codec_stereo_chmaps' was not declared. Should it be static?
sound/soc/codecs/hdmi-codec.c:87:33: warning:
 symbol 'hdmi_codec_8ch_chmaps' was not declared. Should it be static?
sound/soc/codecs/hdmi-codec.c:354:6: warning:
 symbol 'hdmi_codec_eld_chmap' was not declared. Should it be static?

Cc: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Signed-off-by: Takashi Sakamoto <takashi.sakamoto@miraclelinux.com>
---
 sound/soc/codecs/hdmi-codec.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index 8c5ae1f..6ba6aa5 100644
--- a/sound/soc/codecs/hdmi-codec.c
+++ b/sound/soc/codecs/hdmi-codec.c
@@ -31,7 +31,7 @@ struct hdmi_device {
 	int cnt;
 };
 #define pos_to_hdmi_device(pos)	container_of((pos), struct hdmi_device, list)
-LIST_HEAD(hdmi_device_list);
+static LIST_HEAD(hdmi_device_list);
 static DEFINE_MUTEX(hdmi_mutex);
 
 #define DAI_NAME_SIZE 16
@@ -78,14 +78,14 @@ struct hdmi_codec_cea_spk_alloc {
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
@@ -352,7 +352,7 @@ static unsigned long hdmi_codec_spk_mask_from_alloc(int spk_alloc)
 	return spk_mask;
 }
 
-void hdmi_codec_eld_chmap(struct hdmi_codec_priv *hcp)
+static void hdmi_codec_eld_chmap(struct hdmi_codec_priv *hcp)
 {
 	u8 spk_alloc;
 	unsigned long spk_mask;
-- 
2.9.3
