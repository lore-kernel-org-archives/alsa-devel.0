From: andy-alsa@ultra-premium.com
Subject: [PATCH 2/2] ALSA: ca0106: Fix mixer and dac channel
	assignments.
Date: Tue, 21 Sep 2010 23:51:19 +1000
Message-ID: <1285077079-5519-2-git-send-email-andy-alsa@ultra-premium.com>
References: <1285077079-5519-1-git-send-email-andy-alsa@ultra-premium.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from starfish.geekisp.com (mail.geekisp.com [216.168.135.169])
	by alsa0.perex.cz (Postfix) with ESMTP id 2E27524141
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Sep 2010 15:51:36 +0200 (CEST)
In-Reply-To: <1285077079-5519-1-git-send-email-andy-alsa@ultra-premium.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-preoject.org
Cc: alsa-devel@alsa-project.org, Andy Owen <andy-alsa@ultra-premium.com>
List-Id: alsa-devel@alsa-project.org

From: Andy Owen <andy-alsa@ultra-premium.com>

---
 sound/pci/ca0106/ca0106_main.c  |   14 +++++++-------
 sound/pci/ca0106/ca0106_mixer.c |    6 +++---
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/sound/pci/ca0106/ca0106_main.c b/sound/pci/ca0106/ca0106_main.c
index 6dc9a5d..a98df19 100644
--- a/sound/pci/ca0106/ca0106_main.c
+++ b/sound/pci/ca0106/ca0106_main.c
@@ -493,16 +493,16 @@ static void snd_ca0106_pcm_free_substream(struct snd_pcm_runtime *runtime)
 }
 
 static const int spi_dacd_reg[] = {
-	[PCM_FRONT_CHANNEL]	= SPI_DACD4_REG,
-	[PCM_REAR_CHANNEL]	= SPI_DACD0_REG,
+	[PCM_FRONT_CHANNEL]	= SPI_DACD0_REG,
+	[PCM_REAR_CHANNEL]	= SPI_DACD1_REG,
 	[PCM_CENTER_LFE_CHANNEL]= SPI_DACD2_REG,
-	[PCM_UNKNOWN_CHANNEL]	= SPI_DACD1_REG,
+	[PCM_UNKNOWN_CHANNEL]	= SPI_DACD4_REG,
 };
 static const int spi_dacd_bit[] = {
-	[PCM_FRONT_CHANNEL]	= SPI_DACD4_BIT,
-	[PCM_REAR_CHANNEL]	= SPI_DACD0_BIT,
+	[PCM_FRONT_CHANNEL]	= SPI_DACD0_BIT,
+	[PCM_REAR_CHANNEL]	= SPI_DACD1_BIT,
 	[PCM_CENTER_LFE_CHANNEL]= SPI_DACD2_BIT,
-	[PCM_UNKNOWN_CHANNEL]	= SPI_DACD1_BIT,
+	[PCM_UNKNOWN_CHANNEL]	= SPI_DACD4_BIT,
 };
 
 static void restore_spdif_bits(struct snd_ca0106 *chip, int idx)
@@ -553,7 +553,7 @@ static int snd_ca0106_pcm_open_playback_channel(struct snd_pcm_substream *substr
                 return err;
 	snd_pcm_set_sync(substream);
 
-	if (chip->details->spi_dac && channel_id != PCM_FRONT_CHANNEL) {
+	if (chip->details->spi_dac) {
 		const int reg = spi_dacd_reg[channel_id];
 
 		/* Power up dac */
diff --git a/sound/pci/ca0106/ca0106_mixer.c b/sound/pci/ca0106/ca0106_mixer.c
index 85fd315..bafb9c8 100644
--- a/sound/pci/ca0106/ca0106_mixer.c
+++ b/sound/pci/ca0106/ca0106_mixer.c
@@ -689,13 +689,13 @@ static struct snd_kcontrol_new snd_ca0106_volume_i2c_adc_ctls[] __devinitdata =
 static struct snd_kcontrol_new snd_ca0106_volume_spi_dac_ctls[]
 __devinitdata = {
 	SPI_SWITCH("Analog Front Playback Switch",
-		   SPI_DMUTE4_REG, SPI_DMUTE4_BIT),
-	SPI_SWITCH("Analog Rear Playback Switch",
 		   SPI_DMUTE0_REG, SPI_DMUTE0_BIT),
+	SPI_SWITCH("Analog Rear Playback Switch",
+		   SPI_DMUTE1_REG, SPI_DMUTE1_BIT),
 	SPI_SWITCH("Analog Center/LFE Playback Switch",
 		   SPI_DMUTE2_REG, SPI_DMUTE2_BIT),
 	SPI_SWITCH("Analog Side Playback Switch",
-		   SPI_DMUTE1_REG, SPI_DMUTE1_BIT),
+		   SPI_DMUTE4_REG, SPI_DMUTE4_BIT),
 };
 
 static int __devinit remove_ctl(struct snd_card *card, const char *name)
-- 
1.7.0.4
