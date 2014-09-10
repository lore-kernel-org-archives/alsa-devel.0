From: Harley Griggs <hgriggs@posteo.co.uk>
Subject: [PATCH] ALSA: virtuoso: add Xonar Xense support
Date: Wed, 10 Sep 2014 15:18:06 +0100
Message-ID: <20140910141813.B328C258D256@mx02.posteo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx02.posteo.de (mx02.posteo.de [89.146.194.165])
 by alsa0.perex.cz (Postfix) with ESMTP id E6BC5262606
 for <alsa-devel@alsa-project.org>; Wed, 10 Sep 2014 16:18:13 +0200 (CEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mx02.posteo.de (Postfix) with ESMTP id B328C258D256
 for <alsa-devel@alsa-project.org>; Wed, 10 Sep 2014 16:18:13 +0200 (CEST)
Received: from posteo.de ([10.125.125.178]) (using TLS)
 by localhost (amavis1.posteo.de [10.125.125.165]) (amavisd-new, port 10026)
 with ESMTPS id G3eJIf5gUA_H for <alsa-devel@alsa-project.org>;
 Wed, 10 Sep 2014 16:18:12 +0200 (CEST)
Received: from mail.posteo.de (localhost [127.0.0.1])
 by mail.posteo.de (Postfix) with ESMTPSA id 94C062C0110
 for <alsa-devel@alsa-project.org>; Wed, 10 Sep 2014 16:18:07 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This patch adds support for the Xonar Xense card. Has been working fine
for over a year and with the latest Xonar patches.

I have not touched the CS4362A (surround), nor am I sure how to go about
it without more code duplication or refactoring.


Signed-off-by: Harley Griggs <hgriggs@posteo.co.uk>
---
 sound/pci/oxygen/virtuoso.c      |   1 +
 sound/pci/oxygen/xonar_pcm179x.c | 135 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 136 insertions(+)

diff --git a/sound/pci/oxygen/virtuoso.c b/sound/pci/oxygen/virtuoso.c
index 7b317a2..83de6fb 100644
--- a/sound/pci/oxygen/virtuoso.c
+++ b/sound/pci/oxygen/virtuoso.c
@@ -52,6 +52,7 @@ static const struct pci_device_id xonar_ids[] = {
 	{ OXYGEN_PCI_SUBID(0x1043, 0x835d) },
 	{ OXYGEN_PCI_SUBID(0x1043, 0x835e) },
 	{ OXYGEN_PCI_SUBID(0x1043, 0x838e) },
+	{ OXYGEN_PCI_SUBID(0x1043, 0x8428) },
 	{ OXYGEN_PCI_SUBID(0x1043, 0x8522) },
 	{ OXYGEN_PCI_SUBID(0x1043, 0x85f4) },
 	{ OXYGEN_PCI_SUBID_BROKEN_EEPROM },
diff --git a/sound/pci/oxygen/xonar_pcm179x.c b/sound/pci/oxygen/xonar_pcm179x.c
index e026059..e06acfc 100644
--- a/sound/pci/oxygen/xonar_pcm179x.c
+++ b/sound/pci/oxygen/xonar_pcm179x.c
@@ -212,6 +212,9 @@
 #define GPIO_ST_MAGIC		0x0040
 #define GPIO_ST_HP		0x0080
 
+#define GPIO_XENSE_OUTPUT_ENABLE	(0x0001 | 0x0010 | 0x0020)
+#define GPIO_XENSE_SPEAKERS		0x0080
+
 #define I2C_DEVICE_PCM1796(i)	(0x98 + ((i) << 1))	/* 10011, ii, /W=0 */
 #define I2C_DEVICE_CS2000	0x9c			/* 100111, 0, /W=0 */
 
@@ -499,6 +502,52 @@ static void xonar_stx_init(struct oxygen *chip)
 	xonar_st_init_common(chip);
 }
 
+static void xonar_xense_init(struct oxygen *chip)
+{
+	struct xonar_pcm179x *data = chip->model_data;
+
+	data->generic.ext_power_reg = OXYGEN_GPI_DATA;
+	data->generic.ext_power_int_reg = OXYGEN_GPI_INTERRUPT_MASK;
+	data->generic.ext_power_bit = GPI_EXT_POWER;
+	xonar_init_ext_power(chip);
+
+	data->generic.anti_pop_delay = 100;
+	data->has_cs2000 = 1;
+	data->cs2000_regs[CS2000_FUN_CFG_1] = CS2000_REF_CLK_DIV_1;
+	data->broken_i2c = true;
+
+	oxygen_write16(chip, OXYGEN_I2S_A_FORMAT,
+		OXYGEN_RATE_48000 |
+		OXYGEN_I2S_FORMAT_I2S |
+		OXYGEN_I2S_MCLK(MCLK_512) |
+		OXYGEN_I2S_BITS_16 |
+		OXYGEN_I2S_MASTER |
+		OXYGEN_I2S_BCLK_64);
+
+	xonar_st_init_i2c(chip);
+	cs2000_registers_init(chip);
+
+	data->generic.output_enable_bit = GPIO_XENSE_OUTPUT_ENABLE;
+	data->dacs = chip->model.dac_channels_mixer / 2;
+	data->hp_gain_offset = 2*-18;
+
+	pcm1796_init(chip);
+
+	oxygen_set_bits16(chip, OXYGEN_GPIO_CONTROL,
+		GPIO_INPUT_ROUTE | GPIO_ST_HP_REAR |
+		GPIO_ST_MAGIC | GPIO_XENSE_SPEAKERS);
+	oxygen_clear_bits16(chip, OXYGEN_GPIO_DATA,
+		GPIO_INPUT_ROUTE | GPIO_ST_HP_REAR |
+		GPIO_XENSE_SPEAKERS);
+
+	xonar_init_cs53x1(chip);
+	xonar_enable_output(chip);
+
+	snd_component_add(chip->card, "PCM1796");
+	snd_component_add(chip->card, "CS5381");
+	snd_component_add(chip->card, "CS2000");
+}
+
 static void xonar_d2_cleanup(struct oxygen *chip)
 {
 	xonar_disable_output(chip);
@@ -859,6 +908,67 @@ static const struct snd_kcontrol_new st_controls[] = {
 	},
 };
 
+static int xense_output_switch_get(struct snd_kcontrol *ctl,
+               struct snd_ctl_elem_value *value)
+{
+	struct oxygen *chip = ctl->private_data;
+	u16 gpio;
+
+	gpio = oxygen_read16(chip, OXYGEN_GPIO_DATA);
+	if (gpio & GPIO_XENSE_SPEAKERS)
+		value->value.enumerated.item[0] = 0;
+	else if (!(gpio & GPIO_XENSE_SPEAKERS) && (gpio & GPIO_ST_HP_REAR))
+		value->value.enumerated.item[0] = 1;
+	else
+		value->value.enumerated.item[0] = 2;
+	return 0;
+}
+
+static int xense_output_switch_put(struct snd_kcontrol *ctl,
+               struct snd_ctl_elem_value *value)
+{
+	struct oxygen *chip = ctl->private_data;
+	struct xonar_pcm179x *data = chip->model_data;
+	u16 gpio_old, gpio;
+
+	mutex_lock(&chip->mutex);
+	gpio_old = oxygen_read16(chip, OXYGEN_GPIO_DATA);
+	gpio = gpio_old;
+	switch (value->value.enumerated.item[0]) {
+	case 0:
+		gpio |= GPIO_XENSE_SPEAKERS | GPIO_ST_HP_REAR;
+		break;
+	case 1:
+		gpio = (gpio | GPIO_ST_HP_REAR) & ~GPIO_XENSE_SPEAKERS;
+		break;
+	case 2:
+		gpio &= ~(GPIO_XENSE_SPEAKERS | GPIO_ST_HP_REAR);
+	break;
+	}
+	oxygen_write16(chip, OXYGEN_GPIO_DATA, gpio);
+	data->hp_active = !(gpio & GPIO_XENSE_SPEAKERS);
+	update_pcm1796_volume(chip);
+	mutex_unlock(&chip->mutex);
+	return gpio != gpio_old;
+}
+
+static const struct snd_kcontrol_new xense_controls[] = {
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Analog Output",
+		.info = st_output_switch_info,
+		.get = xense_output_switch_get,
+		.put = xense_output_switch_put,
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Headphones Impedance Playback Enum",
+		.info = st_hp_volume_offset_info,
+		.get = st_hp_volume_offset_get,
+		.put = st_hp_volume_offset_put,
+	},
+};
+
 static void xonar_line_mic_ac97_switch(struct oxygen *chip,
 				       unsigned int reg, unsigned int mute)
 {
@@ -946,6 +1056,23 @@ static int xonar_st_mixer_init(struct oxygen *chip)
 	return 0;
 }
 
+static int xonar_xense_mixer_init(struct oxygen *chip)
+{
+	unsigned int i;
+	int err;
+
+	for (i = 0; i < ARRAY_SIZE(xense_controls); ++i) {
+		err = snd_ctl_add(chip->card,
+		snd_ctl_new1(&xense_controls[i], chip));
+		if (err < 0)
+		return err;
+	}
+	err = add_pcm1796_controls(chip);
+	if (err < 0)
+		return err;
+	return 0;
+}
+
 static void dump_pcm1796_registers(struct oxygen *chip,
 				   struct snd_info_buffer *buffer)
 {
@@ -1146,6 +1273,14 @@ int get_xonar_pcm179x_model(struct oxygen *chip,
 		chip->model.resume = xonar_stx_resume;
 		chip->model.set_dac_params = set_pcm1796_params;
 		break;
+	case 0x8428:
+		chip->model = model_xonar_st;
+		chip->model.shortname = "Xonar Xense";
+		chip->model.chip = "AV100";
+		chip->model.init = xonar_xense_init;
+		chip->model.mixer_init = xonar_xense_mixer_init;
+		break;
+
 	default:
 		return -EINVAL;
 	}
-- 
1.8.5.5
