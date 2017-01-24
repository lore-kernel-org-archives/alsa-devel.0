From: Romain Perier <romain.perier@collabora.com>
Subject: [PATCH v5 2/4] ASoC: es8328: Add support for slave mode
Date: Tue, 24 Jan 2017 11:08:33 +0100
Message-ID: <20170124100835.9540-3-romain.perier@collabora.com>
References: <20170124100835.9540-1-romain.perier@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by alsa0.perex.cz (Postfix) with ESMTP id DCF2C266991
 for <alsa-devel@alsa-project.org>; Tue, 24 Jan 2017 11:09:04 +0100 (CET)
In-Reply-To: <20170124100835.9540-1-romain.perier@collabora.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, Heiko Stuebner <heiko@sntech.de>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, linux-rockchip@lists.infradead.org, Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Rob Herring <robh+dt@kernel.org>, Kumar Gala <galak@codeaurora.org>, Romain Perier <romain.perier@collabora.com>
List-Id: alsa-devel@alsa-project.org

Currently, the function that changes the DAI format only supports master
mode. Trying to use a slave mode exits the function with -EINVAL and
leave the codec misconfigured. This commits adds support for enabling
the slave mode.

Signed-off-by: Romain Perier <romain.perier@collabora.com>
---

Changes in v5:
 - Fixed coding style issue for the switch case
 - Moved the code for master mode and slave mode to the switch case

Changes in v4: None
Changes in v3: None
Changes in v2: None

 sound/soc/codecs/es8328.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/es8328.c b/sound/soc/codecs/es8328.c
index 37722194..3f84fbd 100644
--- a/sound/soc/codecs/es8328.c
+++ b/sound/soc/codecs/es8328.c
@@ -589,9 +589,21 @@ static int es8328_set_dai_fmt(struct snd_soc_dai *codec_dai,
 	u8 dac_mode = 0;
 	u8 adc_mode = 0;
 
-	/* set master/slave audio interface */
-	if ((fmt & SND_SOC_DAIFMT_MASTER_MASK) != SND_SOC_DAIFMT_CBM_CFM)
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBM_CFM:
+		/* Master serial port mode, with BCLK generated automatically */
+		snd_soc_update_bits(codec, ES8328_MASTERMODE,
+				    ES8328_MASTERMODE_MSC,
+				    ES8328_MASTERMODE_MSC);
+		break;
+	case SND_SOC_DAIFMT_CBS_CFS:
+		/* Slave serial port mode */
+		snd_soc_update_bits(codec, ES8328_MASTERMODE,
+				    ES8328_MASTERMODE_MSC, 0);
+		break;
+	default:
 		return -EINVAL;
+	}
 
 	/* interface format */
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
@@ -620,10 +632,6 @@ static int es8328_set_dai_fmt(struct snd_soc_dai *codec_dai,
 	snd_soc_update_bits(codec, ES8328_ADCCONTROL4,
 			ES8328_ADCCONTROL4_ADCFORMAT_MASK, adc_mode);
 
-	/* Master serial port mode, with BCLK generated automatically */
-	snd_soc_update_bits(codec, ES8328_MASTERMODE,
-			ES8328_MASTERMODE_MSC, ES8328_MASTERMODE_MSC);
-
 	return 0;
 }
 
-- 
2.9.3
