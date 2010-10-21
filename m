From: Andy Owen <andy-alsa@ultra-premium.com>
Subject: [PATCH - ca0106 2/6] ALSA: ca0106: Pull out dac
	powering routine into separate function.
Date: Thu, 21 Oct 2010 23:39:20 +1100
Message-ID: <1287664764-4996-2-git-send-email-andy-alsa@ultra-premium.com>
References: <1287664764-4996-1-git-send-email-andy-alsa@ultra-premium.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from starfish.geekisp.com (starfish.geekisp.com [216.168.135.166])
	by alsa0.perex.cz (Postfix) with ESMTP id EBE1F103830
	for <alsa-devel@alsa-project.org>;
	Thu, 21 Oct 2010 14:39:38 +0200 (CEST)
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
index 6dc9a5d..22d2f6b 100644
--- a/sound/pci/ca0106/ca0106_main.c
+++ b/sound/pci/ca0106/ca0106_main.c
@@ -514,6 +514,23 @@ static void restore_spdif_bits(struct snd_ca0106 *chip, int idx)
 	}
 }
 
+static int snd_ca0106_pcm_power_dac(struct snd_ca0106 *chip, int channel_id,
+				    int power)
+{
+	if (chip->details->spi_dac) {
+		const int reg = spi_dacd_reg[channel_id];
+
+		if (power)
+			/* Power up */
+			chip->spi_dac_reg[reg] &= ~spi_dacd_bit[channel_id];
+		else
+			/* Power down */
+			chip->spi_dac_reg[reg] |= spi_dacd_bit[channel_id];
+		return snd_ca0106_spi_write(chip, chip->spi_dac_reg[reg]);
+	}
+	return 0;
+}
+
 /* open_playback callback */
 static int snd_ca0106_pcm_open_playback_channel(struct snd_pcm_substream *substream,
 						int channel_id)
@@ -553,12 +570,9 @@ static int snd_ca0106_pcm_open_playback_channel(struct snd_pcm_substream *substr
                 return err;
 	snd_pcm_set_sync(substream);
 
-	if (chip->details->spi_dac && channel_id != PCM_FRONT_CHANNEL) {
-		const int reg = spi_dacd_reg[channel_id];
-
-		/* Power up dac */
-		chip->spi_dac_reg[reg] &= ~spi_dacd_bit[channel_id];
-		err = snd_ca0106_spi_write(chip, chip->spi_dac_reg[reg]);
+	/* Front channel dac should already be on */
+	if (channel_id != PCM_FRONT_CHANNEL) {
+		err = snd_ca0106_pcm_power_dac(chip, channel_id, 1);
 		if (err < 0)
 			return err;
 	}
@@ -578,13 +592,14 @@ static int snd_ca0106_pcm_close_playback(struct snd_pcm_substream *substream)
 
 	restore_spdif_bits(chip, epcm->channel_id);
 
-	if (chip->details->spi_dac && epcm->channel_id != PCM_FRONT_CHANNEL) {
-		const int reg = spi_dacd_reg[epcm->channel_id];
-
-		/* Power down DAC */
-		chip->spi_dac_reg[reg] |= spi_dacd_bit[epcm->channel_id];
-		snd_ca0106_spi_write(chip, chip->spi_dac_reg[reg]);
+	/* Front channel dac should stay on */
+	if (epcm->channel_id != PCM_FRONT_CHANNEL) {
+		int err;
+		err = snd_ca0106_pcm_power_dac(chip, epcm->channel_id, 0);
+		if (err < 0)
+			return err;
 	}
+
 	/* FIXME: maybe zero others */
 	return 0;
 }
-- 
1.7.3.1.127.g1bb28
