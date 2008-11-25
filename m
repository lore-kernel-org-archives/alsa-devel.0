From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 09/13] ASoC: OMAP: Apply channel constrains to
	N810 machine driver
Date: Tue, 25 Nov 2008 15:44:45 +0000
Message-ID: <1227627889-8373-9-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20081125154302.GA8319@rakim.wolfsonmicro.main>
	<1227627889-8373-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227627889-8373-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227627889-8373-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227627889-8373-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227627889-8373-5-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227627889-8373-6-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227627889-8373-7-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227627889-8373-8-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DA66924489
	for <alsa-devel@alsa-project.org>; Tue, 25 Nov 2008 16:44:52 +0100 (CET)
In-Reply-To: <1227627889-8373-8-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jarkko Nikula <jarkko.nikula@nokia.com>
List-Id: alsa-devel@alsa-project.org

From: Jarkko Nikula <jarkko.nikula@nokia.com>

Prepare for upcoming McBSP DAI update adding support for mono links by
restricting number of channels to 2 in N810. This is due tlv320aic3x which
claims channels_min = 1 and playing pure mono audio over I2S would cause
it to be played only from left channel if both cpu and codec DAI's claim to
support mono.

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/omap/n810.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/sound/soc/omap/n810.c b/sound/soc/omap/n810.c
index d216b4f..18e2062 100644
--- a/sound/soc/omap/n810.c
+++ b/sound/soc/omap/n810.c
@@ -70,9 +70,13 @@ static void n810_ext_control(struct snd_soc_codec *codec)
 
 static int n810_startup(struct snd_pcm_substream *substream)
 {
+	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_codec *codec = rtd->socdev->codec;
 
+	snd_pcm_hw_constraint_minmax(runtime,
+				     SNDRV_PCM_HW_PARAM_CHANNELS, 2, 2);
+
 	n810_ext_control(codec);
 	return clk_enable(sys_clkout2);
 }
-- 
1.5.6.5
