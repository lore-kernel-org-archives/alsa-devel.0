From: Colin King <colin.king@canonical.com>
Subject: [PATCH] ASoC: hdmi-codec: make a function and two
	arrays static
Date: Sat, 12 Aug 2017 23:50:28 +0100
Message-ID: <20170812225028.7437-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 7957A2671F1
 for <alsa-devel@alsa-project.org>; Sun, 13 Aug 2017 00:51:07 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Arnaud Pouliquen <arnaud.pouliquen@st.com>, Bhumika Goyal <bhumirks@gmail.com>, Vincent Abriou <vincent.abriou@st.com>, Jon Medhurst <tixy@linaro.org>, alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

The function hdmi_codec_eld_chmap and arrays hdmi_codec_stereo_chmaps
and hdmi_codec_8ch_chmaps are local to the source and do not need to
be in global scope, so make them static.

Cleans up sparse warnings:
symbol 'hdmi_codec_eld_chmap' was not declared. Should it be static?
symbol 'hdmi_codec_stereo_chmaps' was not declared. Should it be static?
symbol 'hdmi_codec_8ch_chmaps' was not declared. Should it be static?

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/codecs/hdmi-codec.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index f288404f0a61..7aba4f312809 100644
--- a/sound/soc/codecs/hdmi-codec.c
+++ b/sound/soc/codecs/hdmi-codec.c
@@ -67,14 +67,14 @@ struct hdmi_codec_cea_spk_alloc {
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
@@ -340,7 +340,7 @@ static unsigned long hdmi_codec_spk_mask_from_alloc(int spk_alloc)
 	return spk_mask;
 }
 
-void hdmi_codec_eld_chmap(struct hdmi_codec_priv *hcp)
+static void hdmi_codec_eld_chmap(struct hdmi_codec_priv *hcp)
 {
 	u8 spk_alloc;
 	unsigned long spk_mask;
-- 
2.11.0
