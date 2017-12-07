From: Colin King <colin.king@canonical.com>
Subject: [PATCH][next] ASoC: pcm186x: make pcm186x_dai_ops and pcm186x_adc_input_channel_sel_value static
Date: Thu,  7 Dec 2017 14:11:32 +0000
Message-ID: <20171207141132.25928-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Michael Stecklein <m-stecklein@ti.com>, Andreas Dannenberg <dannenberg@ti.com>, alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

pcm186x_dai_ops and pcm186x_adc_input_channel_sel_value are local to the
source and do not need to be in global scope, so make them static.

Cleans up sparse warnings:
symbol 'pcm186x_dai_ops' was not declared. Should it be static?
symbol 'pcm186x_adc_input_channel_sel_value' was not declared. Should it
be static?

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/codecs/pcm186x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/pcm186x.c b/sound/soc/codecs/pcm186x.c
index f7aa56e20169..cdb51427facc 100644
--- a/sound/soc/codecs/pcm186x.c
+++ b/sound/soc/codecs/pcm186x.c
@@ -59,7 +59,7 @@ static const struct snd_kcontrol_new pcm1865_snd_controls[] = {
 			   pcm186x_pga_tlv),
 };
 
-const unsigned int pcm186x_adc_input_channel_sel_value[] = {
+static const unsigned int pcm186x_adc_input_channel_sel_value[] = {
 	0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
 	0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
 	0x10, 0x20, 0x30
@@ -475,7 +475,7 @@ static int pcm186x_set_dai_sysclk(struct snd_soc_dai *dai, int clk_id,
 	return 0;
 }
 
-const struct snd_soc_dai_ops pcm186x_dai_ops = {
+static const struct snd_soc_dai_ops pcm186x_dai_ops = {
 	.set_sysclk = pcm186x_set_dai_sysclk,
 	.set_tdm_slot = pcm186x_set_tdm_slot,
 	.set_fmt = pcm186x_set_fmt,
-- 
2.14.1
