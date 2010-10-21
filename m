From: Andy Owen <andy-alsa@ultra-premium.com>
Subject: [PATCH - ca0106 6/6] ALSA: ca0106: Use card specific
	dac id for mute controls.
Date: Thu, 21 Oct 2010 23:39:24 +1100
Message-ID: <1287664764-4996-6-git-send-email-andy-alsa@ultra-premium.com>
References: <1287664764-4996-1-git-send-email-andy-alsa@ultra-premium.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from starfish.geekisp.com (starfish.geekisp.com [216.168.135.166])
	by alsa0.perex.cz (Postfix) with ESMTP id 4BC371038D7
	for <alsa-devel@alsa-project.org>;
	Thu, 21 Oct 2010 14:39:51 +0200 (CEST)
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

diff --git a/sound/pci/ca0106/ca0106_mixer.c b/sound/pci/ca0106/ca0106_mixer.c
index b522401..630aa49 100644
--- a/sound/pci/ca0106/ca0106_mixer.c
+++ b/sound/pci/ca0106/ca0106_mixer.c
@@ -676,28 +676,65 @@ static struct snd_kcontrol_new snd_ca0106_volume_i2c_adc_ctls[] __devinitdata =
         I2C_VOLUME("Aux Capture Volume", 3),
 };
 
-#define SPI_SWITCH(xname,reg,bit) \
-{								\
-	.iface	= SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname,	\
-	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,		\
-	.info	= spi_mute_info,				\
-	.get	= spi_mute_get,					\
-	.put	= spi_mute_put,					\
-	.private_value = (reg<<SPI_REG_SHIFT) | (bit)		\
-}
-
-static struct snd_kcontrol_new snd_ca0106_volume_spi_dac_ctls[]
-__devinitdata = {
-	SPI_SWITCH("Analog Front Playback Switch",
-		   SPI_DMUTE4_REG, SPI_DMUTE4_BIT),
-	SPI_SWITCH("Analog Rear Playback Switch",
-		   SPI_DMUTE0_REG, SPI_DMUTE0_BIT),
-	SPI_SWITCH("Analog Center/LFE Playback Switch",
-		   SPI_DMUTE2_REG, SPI_DMUTE2_BIT),
-	SPI_SWITCH("Analog Side Playback Switch",
-		   SPI_DMUTE1_REG, SPI_DMUTE1_BIT),
+static const int spi_dmute_reg[] = {
+	SPI_DMUTE0_REG,
+	SPI_DMUTE1_REG,
+	SPI_DMUTE2_REG,
+	0,
+	SPI_DMUTE4_REG,
+};
+static const int spi_dmute_bit[] = {
+	SPI_DMUTE0_BIT,
+	SPI_DMUTE1_BIT,
+	SPI_DMUTE2_BIT,
+	0,
+	SPI_DMUTE4_BIT,
 };
 
+static struct snd_kcontrol_new __devinit
+snd_ca0106_volume_spi_dac_ctl(struct snd_ca0106_details *details,
+			      int channel_id)
+{
+	struct snd_kcontrol_new spi_switch = {0};
+	int reg, bit;
+	int dac_id;
+
+	spi_switch.iface = SNDRV_CTL_ELEM_IFACE_MIXER;
+	spi_switch.access = SNDRV_CTL_ELEM_ACCESS_READWRITE;
+	spi_switch.info = spi_mute_info;
+	spi_switch.get = spi_mute_get;
+	spi_switch.put = spi_mute_put;
+
+	switch (channel_id) {
+	case PCM_FRONT_CHANNEL:
+		spi_switch.name = "Analog Front Playback Switch";
+		dac_id = (details->spi_dac & 0xf000) >> (4 * 3);
+		break;
+	case PCM_REAR_CHANNEL:
+		spi_switch.name = "Analog Rear Playback Switch";
+		dac_id = (details->spi_dac & 0x0f00) >> (4 * 2);
+		break;
+	case PCM_CENTER_LFE_CHANNEL:
+		spi_switch.name = "Analog Center/LFE Playback Switch";
+		dac_id = (details->spi_dac & 0x00f0) >> (4 * 1);
+		break;
+	case PCM_UNKNOWN_CHANNEL:
+		spi_switch.name = "Analog Side Playback Switch";
+		dac_id = (details->spi_dac & 0x000f) >> (4 * 0);
+		break;
+	default:
+		/* Unused channel */
+		spi_switch.name = NULL;
+		dac_id = 0;
+	}
+	reg = spi_dmute_reg[dac_id];
+	bit = spi_dmute_bit[dac_id];
+
+	spi_switch.private_value = (reg << SPI_REG_SHIFT) | bit;
+
+	return spi_switch;
+}
+
 static int __devinit remove_ctl(struct snd_card *card, const char *name)
 {
 	struct snd_ctl_elem_id id;
@@ -832,8 +869,18 @@ int __devinit snd_ca0106_mixer(struct snd_ca0106 *emu)
 		if (err < 0)
 			return err;
 	}
-	if (emu->details->spi_dac)
-		ADD_CTLS(emu, snd_ca0106_volume_spi_dac_ctls);
+	if (emu->details->spi_dac) {
+		int i;
+		for (i = 0;; i++) {
+			struct snd_kcontrol_new ctl;
+			ctl = snd_ca0106_volume_spi_dac_ctl(emu->details, i);
+			if (!ctl.name)
+				break;
+			err = snd_ctl_add(card, snd_ctl_new1(&ctl, emu));
+			if (err < 0)
+				return err;
+		}
+	}
 
 	/* Create virtual master controls */
 	vmaster = snd_ctl_make_virtual_master("Master Playback Volume",
-- 
1.7.3.1.127.g1bb28
