From: Matt Flax <flatmax@flatmax.org>
Subject: [PATCH] ASoC: bcm2835: Remove redundant channel
	checking code in hw_params
Date: Sun, 15 Jan 2017 12:17:23 +1100
Message-ID: <1484443043-13623-1-git-send-email-flatmax@flatmax.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nskntmtas02p.mx.bigpond.com (nskntmtas02p.mx.bigpond.com
 [61.9.168.140]) by alsa0.perex.cz (Postfix) with ESMTP id 426DD266D6A
 for <alsa-devel@alsa-project.org>; Sun, 15 Jan 2017 02:17:40 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@wwwdotorg.org>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Takashi Iwai <tiwai@suse.de>, flatmax@flatmax.org
List-Id: alsa-devel@alsa-project.org

Due to channels_max and channels_min in the bcm2835_i2s_dai structure,
the channel guard code in bcm2835_i2s_hw_params is redundant.

The bcm2835_i2s_hw_params function checks that the channel count is
2 before continuing. This code never gets executed because core soc
checks prevent the execution (upon channel mismatch) of the
bcm2835_i2s_hw_params function.

The redundancy has been tested and checked for the case when
the bcm2835_i2s_dai structure has channels_max = 2 and a request
for 8 channels has been made. The test has confirmed that the
removed code is redundant as it never gets executed when a
channel mismatch occurs.

This redundant channel count check may seem like it will not cause
any problems however some sound cards (such as the 8 channel
AudioInjector Octo sound card) require the execution of the
bcm2835_i2s_hw_params function when channels_max in the
bcm2835_i2s_dai structure has been increased to 8.

As the channel checking code in bcm2835_i2s_hw_params is redundant
and stops certain cards from working it has been removed.

Signed-off-by: Matt Flax <flatmax@flatmax.org>
---
 sound/soc/bcm/bcm2835-i2s.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/sound/soc/bcm/bcm2835-i2s.c b/sound/soc/bcm/bcm2835-i2s.c
index 6ba2049..1773b83 100644
--- a/sound/soc/bcm/bcm2835-i2s.c
+++ b/sound/soc/bcm/bcm2835-i2s.c
@@ -310,15 +310,9 @@ static int bcm2835_i2s_hw_params(struct snd_pcm_substream *substream,
 	ch1pos = data_delay;
 	ch2pos = bclk_ratio / 2 + data_delay;
 
-	switch (params_channels(params)) {
-	case 2:
-		format = BCM2835_I2S_CH1(format) | BCM2835_I2S_CH2(format);
-		format |= BCM2835_I2S_CH1(BCM2835_I2S_CHPOS(ch1pos));
-		format |= BCM2835_I2S_CH2(BCM2835_I2S_CHPOS(ch2pos));
-		break;
-	default:
-		return -EINVAL;
-	}
+	format = BCM2835_I2S_CH1(format) | BCM2835_I2S_CH2(format);
+	format |= BCM2835_I2S_CH1(BCM2835_I2S_CHPOS(ch1pos));
+	format |= BCM2835_I2S_CH2(BCM2835_I2S_CHPOS(ch2pos));
 
 	/*
 	 * Set format for both streams.
-- 
2.7.4
