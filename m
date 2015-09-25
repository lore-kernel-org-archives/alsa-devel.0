From: Gianluca Renzi <gianlucarenzi@eurekelettronica.it>
Subject: [PATCH] ASoC: sgtl5000: fix bad register
	MIC_BIAS_VOLTAGE setup on probe
Date: Fri, 25 Sep 2015 16:21:27 +0200
Message-ID: <1443190887-18080-1-git-send-email-gianlucarenzi@eurekelettronica.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gianlinux (unknown [77.89.4.21])
 by alsa0.perex.cz (Postfix) with ESMTP id EA086260502
 for <alsa-devel@alsa-project.org>; Fri, 25 Sep 2015 16:22:39 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, Gianluca Renzi <gianlucarenzi@eurekelettronica.it>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>
Cc: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Gianluca Renzi <gianlucarenzi@eurekelettronica.it>
---
 sound/soc/codecs/sgtl5000.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
 
diff -up a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c 
--- a/sound/soc/codecs/sgtl5000.c	2015-09-25 15:24:10.597051191 +0200
+++ b/sound/soc/codecs/sgtl5000.c	2015-09-25 15:24:21.000000000 +0200
@@ -1377,7 +1377,7 @@ static int sgtl5000_probe(struct snd_soc
 
 	snd_soc_update_bits(codec, SGTL5000_CHIP_MIC_CTRL,
 			SGTL5000_BIAS_R_MASK,
-			sgtl5000->micbias_voltage << SGTL5000_BIAS_R_SHIFT);
+			sgtl5000->micbias_voltage << SGTL5000_BIAS_VOLT_SHIFT);
 	/*
 	 * disable DAP
 	 * TODO:
@@ -1549,7 +1549,7 @@ static int sgtl5000_i2c_probe(struct i2c
 			else {
 				sgtl5000->micbias_voltage = 0;
 				dev_err(&client->dev,
-					"Unsuitable MicBias resistor\n");
+					"Unsuitable MicBias voltage\n");
 			}
 		} else {
 			sgtl5000->micbias_voltage = 0;
