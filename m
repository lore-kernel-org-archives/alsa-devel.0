From: Romain Perier <romain.perier@collabora.com>
Subject: [PATCH v2 2/4] ASoC: es8328: Add support for slave mode
Date: Mon, 16 Jan 2017 09:17:51 +0100
Message-ID: <20170116081753.13666-3-romain.perier@collabora.com>
References: <20170116081753.13666-1-romain.perier@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by alsa0.perex.cz (Postfix) with ESMTP id 0128B2667A5
 for <alsa-devel@alsa-project.org>; Mon, 16 Jan 2017 09:18:15 +0100 (CET)
In-Reply-To: <20170116081753.13666-1-romain.perier@collabora.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, Heiko Stuebner <heiko@sntech.de>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, linux-rockchip@lists.infradead.org, Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Rob Herring <robh+dt@kernel.org>, Kumar Gala <galak@codeaurora.org>, Romain Perier <romain.perier@collabora.com>
List-Id: alsa-devel@alsa-project.org

Currently, the function that changes the DAI format only supports master
mode. Trying to use a slave mode exits the function with -EINVAL and
leave the codec misconfigured. This commits adds support for enabling
the slave mode.

Signed-off-by: Romain Perier <romain.perier@collabora.com>
---

Changes in v2: None

 sound/soc/codecs/es8328.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/es8328.c b/sound/soc/codecs/es8328.c
index 37722194..054e123 100644
--- a/sound/soc/codecs/es8328.c
+++ b/sound/soc/codecs/es8328.c
@@ -588,10 +588,18 @@ static int es8328_set_dai_fmt(struct snd_soc_dai *codec_dai,
 	struct snd_soc_codec *codec = codec_dai->codec;
 	u8 dac_mode = 0;
 	u8 adc_mode = 0;
+	bool master;
 
-	/* set master/slave audio interface */
-	if ((fmt & SND_SOC_DAIFMT_MASTER_MASK) != SND_SOC_DAIFMT_CBM_CFM)
-		return -EINVAL;
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+		case SND_SOC_DAIFMT_CBM_CFM:
+			master = true;
+			break;
+		case SND_SOC_DAIFMT_CBS_CFS:
+			master = false;
+			break;
+		default:
+			return -EINVAL;
+	}
 
 	/* interface format */
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
@@ -620,9 +628,17 @@ static int es8328_set_dai_fmt(struct snd_soc_dai *codec_dai,
 	snd_soc_update_bits(codec, ES8328_ADCCONTROL4,
 			ES8328_ADCCONTROL4_ADCFORMAT_MASK, adc_mode);
 
-	/* Master serial port mode, with BCLK generated automatically */
-	snd_soc_update_bits(codec, ES8328_MASTERMODE,
-			ES8328_MASTERMODE_MSC, ES8328_MASTERMODE_MSC);
+	if (master) {
+		/* Master serial port mode, with BCLK generated automatically */
+		snd_soc_update_bits(codec, ES8328_MASTERMODE,
+				    ES8328_MASTERMODE_MSC,
+				    ES8328_MASTERMODE_MSC);
+	} else {
+		/* Slave serial port mode */
+		snd_soc_update_bits(codec, ES8328_MASTERMODE,
+				    ES8328_MASTERMODE_MSC,
+				    0);
+	}
 
 	return 0;
 }
-- 
2.9.3
