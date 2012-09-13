From: Eric Millbrandt <emillbrandt@dekaresearch.com>
Subject: [PATCH 3/7] ASoC: fsl: mpc5200 add missing information
	to snd_soc_dai_driver
Date: Thu, 13 Sep 2012 17:43:12 -0400
Message-ID: <1347572596-37540-4-git-send-email-emillbrandt@dekaresearch.com>
References: <1347572596-37540-1-git-send-email-emillbrandt@dekaresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from norco.coldhaus.com (norco.coldhaus.com [64.32.230.18])
 by alsa0.perex.cz (Postfix) with ESMTP id 31FCB265345
 for <alsa-devel@alsa-project.org>; Thu, 13 Sep 2012 23:43:27 +0200 (CEST)
In-Reply-To: <1347572596-37540-1-git-send-email-emillbrandt@dekaresearch.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Grant Likely <grant.likely@secretlab.ca>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Anatolij Gustschin <agust@denx.de>
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, Eric Millbrandt <emillbrandt@dekaresearch.com>
List-Id: alsa-devel@alsa-project.org

Add missing dai_driver information to avoid these runtime errors

[   16.433788] asoc: error - multiple DAI f0002c00.i2s registered with no name
[   16.453551] Failed to register DAI
[   16.461222] mpc5200-psc-i2s: probe of f0002c00.i2s failed with error -22
[   16.475242] asoc: error - multiple DAI f0002000.ac97 registered with no name
[   16.488087] mpc5200-psc-ac97 f0002000.ac97: Failed to register DAI
[   16.502222] mpc5200-psc-ac97: probe of f0002000.ac97 failed with error -22

Signed-off-by: Eric Millbrandt <emillbrandt@dekaresearch.com>

diff --git a/sound/soc/fsl/mpc5200_psc_ac97.c b/sound/soc/fsl/mpc5200_psc_ac97.c
index 9a09453..a313c0a 100644
--- a/sound/soc/fsl/mpc5200_psc_ac97.c
+++ b/sound/soc/fsl/mpc5200_psc_ac97.c
@@ -237,15 +237,18 @@ static const struct snd_soc_dai_ops psc_ac97_digital_ops = {
 
 static struct snd_soc_dai_driver psc_ac97_dai[] = {
 {
+	.name = "mpc5200-psc-ac97.0",
 	.ac97_control = 1,
 	.probe	= psc_ac97_probe,
 	.playback = {
+		.stream_name	= "AC97 Playback",
 		.channels_min   = 1,
 		.channels_max   = 6,
 		.rates          = SNDRV_PCM_RATE_8000_48000,
 		.formats = SNDRV_PCM_FMTBIT_S32_BE,
 	},
 	.capture = {
+		.stream_name	= "AC97 Capture",
 		.channels_min   = 1,
 		.channels_max   = 2,
 		.rates          = SNDRV_PCM_RATE_8000_48000,
@@ -254,8 +257,10 @@ static struct snd_soc_dai_driver psc_ac97_dai[] = {
 	.ops = &psc_ac97_analog_ops,
 },
 {
+	.name = "mpc5200-psc-ac97.1",
 	.ac97_control = 1,
 	.playback = {
+		.stream_name	= "AC97 SPDIF",
 		.channels_min   = 1,
 		.channels_max   = 2,
 		.rates          = SNDRV_PCM_RATE_32000 | \
diff --git a/sound/soc/fsl/mpc5200_psc_i2s.c b/sound/soc/fsl/mpc5200_psc_i2s.c
index c0b7a23..ba1f0a6 100644
--- a/sound/soc/fsl/mpc5200_psc_i2s.c
+++ b/sound/soc/fsl/mpc5200_psc_i2s.c
@@ -130,13 +130,16 @@ static const struct snd_soc_dai_ops psc_i2s_dai_ops = {
 };
 
 static struct snd_soc_dai_driver psc_i2s_dai[] = {{
+	.name = "mpc5200-psc-i2s.0",
 	.playback = {
+		.stream_name = "I2S Playback",
 		.channels_min = 2,
 		.channels_max = 2,
 		.rates = PSC_I2S_RATES,
 		.formats = PSC_I2S_FORMATS,
 	},
 	.capture = {
+		.stream_name = "I2S Capture",
 		.channels_min = 2,
 		.channels_max = 2,
 		.rates = PSC_I2S_RATES,
-- 
1.7.2.5
