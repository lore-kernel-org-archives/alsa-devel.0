From: Andy Owen <andy-alsa@ultra-premium.com>
Subject: [PATCH - ca0106 4/6] ALSA: ca0106: Create a nice spot
	for mapping channels to dacs.
Date: Thu, 21 Oct 2010 23:39:22 +1100
Message-ID: <1287664764-4996-4-git-send-email-andy-alsa@ultra-premium.com>
References: <1287664764-4996-1-git-send-email-andy-alsa@ultra-premium.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from starfish.geekisp.com (starfish.geekisp.com [216.168.135.166])
	by alsa0.perex.cz (Postfix) with ESMTP id 6E5B21038C2
	for <alsa-devel@alsa-project.org>;
	Thu, 21 Oct 2010 14:39:49 +0200 (CEST)
In-Reply-To: <1287664764-4996-1-git-send-email-andy-alsa@ultra-premium.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org, Andy Owen <andy-alsa@ultra-premium.com>
List-Id: alsa-devel@alsa-project.org


Signed-off-by: Andy Owen <andy-alsa@ultra-premium.com>

diff --git a/sound/pci/ca0106/ca0106_main.c b/sound/pci/ca0106/ca0106_main.c
index 46ae98d..da91003 100644
--- a/sound/pci/ca0106/ca0106_main.c
+++ b/sound/pci/ca0106/ca0106_main.c
@@ -493,16 +493,18 @@ static void snd_ca0106_pcm_free_substream(struct snd_pcm_runtime *runtime)
 }
 
 static const int spi_dacd_reg[] = {
-	[PCM_FRONT_CHANNEL]	= SPI_DACD4_REG,
-	[PCM_REAR_CHANNEL]	= SPI_DACD0_REG,
-	[PCM_CENTER_LFE_CHANNEL]= SPI_DACD2_REG,
-	[PCM_UNKNOWN_CHANNEL]	= SPI_DACD1_REG,
+	SPI_DACD0_REG,
+	SPI_DACD1_REG,
+	SPI_DACD2_REG,
+	0,
+	SPI_DACD4_REG,
 };
 static const int spi_dacd_bit[] = {
-	[PCM_FRONT_CHANNEL]	= SPI_DACD4_BIT,
-	[PCM_REAR_CHANNEL]	= SPI_DACD0_BIT,
-	[PCM_CENTER_LFE_CHANNEL]= SPI_DACD2_BIT,
-	[PCM_UNKNOWN_CHANNEL]	= SPI_DACD1_BIT,
+	SPI_DACD0_BIT,
+	SPI_DACD1_BIT,
+	SPI_DACD2_BIT,
+	0,
+	SPI_DACD4_BIT,
 };
 
 static void restore_spdif_bits(struct snd_ca0106 *chip, int idx)
@@ -514,18 +516,34 @@ static void restore_spdif_bits(struct snd_ca0106 *chip, int idx)
 	}
 }
 
+static int snd_ca0106_channel_dac(struct snd_ca0106_details *details,
+				  int channel_id)
+{
+	switch (channel_id) {
+	case PCM_FRONT_CHANNEL:		return 4;
+	case PCM_REAR_CHANNEL:		return 0;
+	case PCM_CENTER_LFE_CHANNEL:	return 2;
+	case PCM_UNKNOWN_CHANNEL:	return 1;
+	}
+	snd_printk(KERN_DEBUG "ca0106: unknown channel_id %d\n", channel_id);
+	return 0;
+}
+
 static int snd_ca0106_pcm_power_dac(struct snd_ca0106 *chip, int channel_id,
 				    int power)
 {
 	if (chip->details->spi_dac) {
-		const int reg = spi_dacd_reg[channel_id];
+		const int dac = snd_ca0106_channel_dac(chip->details,
+						       channel_id);
+		const int reg = spi_dacd_reg[dac];
+		const int bit = spi_dacd_bit[dac];
 
 		if (power)
 			/* Power up */
-			chip->spi_dac_reg[reg] &= ~spi_dacd_bit[channel_id];
+			chip->spi_dac_reg[reg] &= ~bit;
 		else
 			/* Power down */
-			chip->spi_dac_reg[reg] |= spi_dacd_bit[channel_id];
+			chip->spi_dac_reg[reg] |= bit;
 		return snd_ca0106_spi_write(chip, chip->spi_dac_reg[reg]);
 	}
 	return 0;
-- 
1.7.3.1.127.g1bb28
