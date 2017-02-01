From: Matt Flax <flatmax@flatmax.org>
Subject: [PATCH] ASoC: bcm2835: Increase channels_max to 8
Date: Thu,  2 Feb 2017 10:37:44 +1100
Message-ID: <1485992264-9058-1-git-send-email-flatmax@flatmax.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nskntmtas03p.mx.bigpond.com (nskntmtas03p.mx.bigpond.com
 [61.9.168.143]) by alsa0.perex.cz (Postfix) with ESMTP id 53122267500
 for <alsa-devel@alsa-project.org>; Thu,  2 Feb 2017 00:37:56 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, Eric Anholt <eric@anholt.net>, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Florian Meier <florian.meier@koalo.de>, broonie@kernel.org, phil@raspberrypi.org
Cc: Matt Flax <flatmax@flatmax.org>
List-Id: alsa-devel@alsa-project.org

The AudioInjector Octo sound card operates with 8 channels,
however the bcm2835 I2S driver was limited to 2 channels.

This patch increases the channel capability to 8 by setting
channels_max to 8 in the bcm2835_i2s_dai structure. It also
adds the 8 channel condition to the channel guard in the
bcm2835_i2s_hw_params function.

Signed-off-by: Matt Flax <flatmax@flatmax.org>
---
 sound/soc/bcm/bcm2835-i2s.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/bcm/bcm2835-i2s.c b/sound/soc/bcm/bcm2835-i2s.c
index 6ba2049..c65ce28 100644
--- a/sound/soc/bcm/bcm2835-i2s.c
+++ b/sound/soc/bcm/bcm2835-i2s.c
@@ -312,6 +312,7 @@ static int bcm2835_i2s_hw_params(struct snd_pcm_substream *substream,
 
 	switch (params_channels(params)) {
 	case 2:
+	case 8:
 		format = BCM2835_I2S_CH1(format) | BCM2835_I2S_CH2(format);
 		format |= BCM2835_I2S_CH1(BCM2835_I2S_CHPOS(ch1pos));
 		format |= BCM2835_I2S_CH2(BCM2835_I2S_CHPOS(ch2pos));
@@ -577,7 +578,7 @@ static struct snd_soc_dai_driver bcm2835_i2s_dai = {
 	.probe	= bcm2835_i2s_dai_probe,
 	.playback = {
 		.channels_min = 2,
-		.channels_max = 2,
+		.channels_max = 8,
 		.rates =	SNDRV_PCM_RATE_8000_192000,
 		.formats =	SNDRV_PCM_FMTBIT_S16_LE
 				| SNDRV_PCM_FMTBIT_S24_LE
@@ -585,7 +586,7 @@ static struct snd_soc_dai_driver bcm2835_i2s_dai = {
 		},
 	.capture = {
 		.channels_min = 2,
-		.channels_max = 2,
+		.channels_max = 8,
 		.rates =	SNDRV_PCM_RATE_8000_192000,
 		.formats =	SNDRV_PCM_FMTBIT_S16_LE
 				| SNDRV_PCM_FMTBIT_S24_LE
-- 
2.7.4
