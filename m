From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: hdmi-codec: make a function and two arrays static" to the asoc tree
Date: Mon, 14 Aug 2017 17:42:29 +0100
Message-ID: <E1dhIRh-00054N-P2@finisterre>
References: <20170812225028.7437-1-colin.king@canonical.com>
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20170812225028.7437-1-colin.king@canonical.com>
Sender: kernel-janitors-owner@vger.kernel.org
To: Colin Ian King <colin.king@canonical.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Arnaud Pouliquen <arnaud.pouliquen@st.com>, Bhumika Goyal <bhumirks@gmail.com>, Vincent Abriou <vincent.abriou@st.com>, Jon Medhurst <tixy@linaro.org>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: hdmi-codec: make a function and two arrays static

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 3013c75fadc581160be8d89c2c0f29219971c58f Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Sat, 12 Aug 2017 23:50:28 +0100
Subject: [PATCH] ASoC: hdmi-codec: make a function and two arrays static

The function hdmi_codec_eld_chmap and arrays hdmi_codec_stereo_chmaps
and hdmi_codec_8ch_chmaps are local to the source and do not need to
be in global scope, so make them static.

Cleans up sparse warnings:
symbol 'hdmi_codec_eld_chmap' was not declared. Should it be static?
symbol 'hdmi_codec_stereo_chmaps' was not declared. Should it be static?
symbol 'hdmi_codec_8ch_chmaps' was not declared. Should it be static?

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/hdmi-codec.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index 509ab513b4b2..f7520413c671 100644
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
2.13.2

