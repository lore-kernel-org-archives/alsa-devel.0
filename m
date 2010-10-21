From: Andy Owen <andy-alsa@ultra-premium.com>
Subject: [PATCH - ca0106 3/6] ALSA: ca0106: Move enabling of
	front dac out of hardcoded setup sequence.
Date: Thu, 21 Oct 2010 23:39:21 +1100
Message-ID: <1287664764-4996-3-git-send-email-andy-alsa@ultra-premium.com>
References: <1287664764-4996-1-git-send-email-andy-alsa@ultra-premium.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from starfish.geekisp.com (starfish.geekisp.com [216.168.135.166])
	by alsa0.perex.cz (Postfix) with ESMTP id 1D5361038C0
	for <alsa-devel@alsa-project.org>;
	Thu, 21 Oct 2010 14:39:48 +0200 (CEST)
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
index 22d2f6b..46ae98d 100644
--- a/sound/pci/ca0106/ca0106_main.c
+++ b/sound/pci/ca0106/ca0106_main.c
@@ -1385,7 +1385,7 @@ static unsigned int spi_dac_init[] = {
 	SPI_REG(12,		0x00),
 	SPI_REG(SPI_LDA4_REG,	SPI_DA_BIT_0dB),
 	SPI_REG(SPI_RDA4_REG,	SPI_DA_BIT_0dB | SPI_DA_BIT_UPDATE),
-	SPI_REG(SPI_DACD4_REG,	0x00),
+	SPI_REG(SPI_DACD4_REG,	SPI_DACD4_BIT),
 };
 
 static unsigned int i2c_adc_init[][2] = {
@@ -1576,6 +1576,9 @@ static void ca0106_init_chip(struct snd_ca0106 *chip, int resume)
 			if (reg < ARRAY_SIZE(chip->spi_dac_reg))
 				chip->spi_dac_reg[reg] = spi_dac_init[n];
 		}
+
+		/* Enable front dac only */
+		snd_ca0106_pcm_power_dac(chip, PCM_FRONT_CHANNEL, 1);
 	}
 }
 
-- 
1.7.3.1.127.g1bb28
