From: pavel.hofman@ivitera.com
Subject: [PATCH 3/7] ak4113 support
Date: Wed, 16 Sep 2009 22:25:37 +0200
Message-ID: <1253132741-15688-3-git-send-email-pavel.hofman@ivitera.com>
References: <1253132741-15688-1-git-send-email-pavel.hofman@ivitera.com>
	<1253132741-15688-2-git-send-email-pavel.hofman@ivitera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1253132741-15688-2-git-send-email-pavel.hofman@ivitera.com>
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
Cc: Pavel Hofman <pavel.hofman@ivitera.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Pavel Hofman <pavel.hofman@ivitera.com>

* complete support for ak4113
* based on code for ak4114 and ak4117

Signed-off-by: Pavel Hofman <pavel.hofman@ivitera.com>

diff --git a/i2c/other/Makefile b/i2c/other/Makefile
index 703d954..2dad40f 100644
--- a/i2c/other/Makefile
+++ b/i2c/other/Makefile
@@ -5,6 +5,7 @@
 
 snd-ak4114-objs := ak4114.o
 snd-ak4117-objs := ak4117.o
+snd-ak4113-objs := ak4113.o
 snd-ak4xxx-adda-objs := ak4xxx-adda.o
 snd-pt2258-objs := pt2258.o
 snd-tea575x-tuner-objs := tea575x-tuner.o
@@ -12,5 +13,5 @@ snd-tea575x-tuner-objs := tea575x-tuner.o
 # Module Dependency
 obj-$(CONFIG_SND_PDAUDIOCF) += snd-ak4117.o
 obj-$(CONFIG_SND_ICE1712) += snd-ak4xxx-adda.o
-obj-$(CONFIG_SND_ICE1724) += snd-ak4114.o snd-ak4xxx-adda.o snd-pt2258.o
+obj-$(CONFIG_SND_ICE1724) += snd-ak4114.o snd-ak4113.o snd-ak4xxx-adda.o snd-pt2258.o
 obj-$(CONFIG_SND_FM801_TEA575X) += snd-tea575x-tuner.o
diff --git a/i2c/other/ak4113.c b/i2c/other/ak4113.c
new file mode 100644
index 0000000..fff62cc
--- /dev/null
+++ b/i2c/other/ak4113.c
@@ -0,0 +1,639 @@
+/*
+ *  Routines for control of the AK4113 via I2C/4-wire serial interface
+ *  IEC958 (S/PDIF) receiver by Asahi Kasei
+ *  Copyright (c) by Jaroslav Kysela <perex@perex.cz>
+ *  Copyright (c) by Pavel Hofman <pavel.hofman@ivitera.com>
+ *
+ *
+ *   This program is free software; you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program; if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ *
+ */
+
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <sound/core.h>
+#include <sound/control.h>
+#include <sound/pcm.h>
+#include <sound/ak4113.h>
+#include <sound/asoundef.h>
+#include <sound/info.h>
+
+MODULE_AUTHOR("Pavel Hofman <pavel.hofman@ivitera.com>");
+MODULE_DESCRIPTION("AK4113 IEC958 (S/PDIF) receiver by Asahi Kasei");
+MODULE_LICENSE("GPL");
+
+#define AK4113_ADDR			0x00 /* fixed address */
+
+static void ak4113_stats(struct work_struct *work);
+static void ak4113_init_regs(struct ak4113 *chip);
+
+
+static void reg_write(struct ak4113 *ak4113, unsigned char reg,
+		unsigned char val)
+{
+	ak4113->write(ak4113->private_data, reg, val);
+	if (reg < sizeof(ak4113->regmap))
+		ak4113->regmap[reg] = val;
+}
+
+static inline unsigned char reg_read(struct ak4113 *ak4113, unsigned char reg)
+{
+	return ak4113->read(ak4113->private_data, reg);
+}
+
+static void snd_ak4113_free(struct ak4113 *chip)
+{
+	chip->init = 1;	/* don't schedule new work */
+	mb();
+	cancel_delayed_work(&chip->work);
+	flush_scheduled_work();
+	kfree(chip);
+}
+
+static int snd_ak4113_dev_free(struct snd_device *device)
+{
+	struct ak4113 *chip = device->device_data;
+	snd_ak4113_free(chip);
+	return 0;
+}
+
+int snd_ak4113_create(struct snd_card *card, ak4113_read_t *read,
+		ak4113_write_t *write, const unsigned char pgm[5],
+		void *private_data, struct ak4113 **r_ak4113)
+{
+	struct ak4113 *chip;
+	int err = 0;
+	unsigned char reg;
+	static struct snd_device_ops ops = {
+		.dev_free =     snd_ak4113_dev_free,
+	};
+
+	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
+	if (chip == NULL)
+		return -ENOMEM;
+	spin_lock_init(&chip->lock);
+	chip->card = card;
+	chip->read = read;
+	chip->write = write;
+	chip->private_data = private_data;
+	INIT_DELAYED_WORK(&chip->work, ak4113_stats);
+
+	for (reg = 0; reg < AK4113_WRITABLE_REGS ; reg++)
+		chip->regmap[reg] = pgm[reg];
+	ak4113_init_regs(chip);
+
+	chip->rcs0 = reg_read(chip, AK4113_REG_RCS0) & ~(AK4113_QINT |
+			AK4113_CINT | AK4113_STC);
+	chip->rcs1 = reg_read(chip, AK4113_REG_RCS1);
+	chip->rcs2 = reg_read(chip, AK4113_REG_RCS2);
+	err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops);
+	if (err < 0)
+		goto __fail;
+
+	if (r_ak4113)
+		*r_ak4113 = chip;
+	return 0;
+
+__fail:
+	snd_ak4113_free(chip);
+	return err < 0 ? err : -EIO;
+}
+EXPORT_SYMBOL_GPL(snd_ak4113_create);
+
+void snd_ak4113_reg_write(struct ak4113 *chip, unsigned char reg,
+		unsigned char mask, unsigned char val)
+{
+	if (reg >= AK4113_WRITABLE_REGS)
+		return;
+	reg_write(chip, reg, (chip->regmap[reg] & ~mask) | val);
+}
+EXPORT_SYMBOL_GPL(snd_ak4113_reg_write);
+
+static void ak4113_init_regs(struct ak4113 *chip)
+{
+	unsigned char old = chip->regmap[AK4113_REG_PWRDN], reg;
+
+	/* bring the chip to reset state and powerdown state */
+	reg_write(chip, AK4113_REG_PWRDN, old & ~(AK4113_RST|AK4113_PWN));
+	udelay(200);
+	/* release reset, but leave powerdown */
+	reg_write(chip, AK4113_REG_PWRDN, (old | AK4113_RST) & ~AK4113_PWN);
+	udelay(200);
+	for (reg = 1; reg < AK4113_WRITABLE_REGS; reg++)
+		reg_write(chip, reg, chip->regmap[reg]);
+	/* release powerdown, everything is initialized now */
+	reg_write(chip, AK4113_REG_PWRDN, old | AK4113_RST | AK4113_PWN);
+}
+
+void snd_ak4113_reinit(struct ak4113 *chip)
+{
+	chip->init = 1;
+	mb();
+	flush_scheduled_work();
+	ak4113_init_regs(chip);
+	/* bring up statistics / event queing */
+	chip->init = 0;
+	if (chip->kctls[0])
+		schedule_delayed_work(&chip->work, HZ / 10);
+}
+EXPORT_SYMBOL_GPL(snd_ak4113_reinit);
+
+static unsigned int external_rate(unsigned char rcs1)
+{
+	switch (rcs1 & (AK4113_FS0|AK4113_FS1|AK4113_FS2|AK4113_FS3)) {
+	case AK4113_FS_8000HZ:
+		return 8000;
+	case AK4113_FS_11025HZ:
+		return 11025;
+	case AK4113_FS_16000HZ:
+		return 16000;
+	case AK4113_FS_22050HZ:
+		return 22050;
+	case AK4113_FS_24000HZ:
+		return 24000;
+	case AK4113_FS_32000HZ:
+		return 32000;
+	case AK4113_FS_44100HZ:
+		return 44100;
+	case AK4113_FS_48000HZ:
+		return 48000;
+	case AK4113_FS_64000HZ:
+		return 64000;
+	case AK4113_FS_88200HZ:
+		return 88200;
+	case AK4113_FS_96000HZ:
+		return 96000;
+	case AK4113_FS_176400HZ:
+		return 176400;
+	case AK4113_FS_192000HZ:
+		return 192000;
+	default:
+		return 0;
+	}
+}
+
+static int snd_ak4113_in_error_info(struct snd_kcontrol *kcontrol,
+				    struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = 1;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = LONG_MAX;
+	return 0;
+}
+
+static int snd_ak4113_in_error_get(struct snd_kcontrol *kcontrol,
+				   struct snd_ctl_elem_value *ucontrol)
+{
+	struct ak4113 *chip = snd_kcontrol_chip(kcontrol);
+	long *ptr;
+
+	spin_lock_irq(&chip->lock);
+	ptr = (long *)(((char *)chip) + kcontrol->private_value);
+	ucontrol->value.integer.value[0] = *ptr;
+	*ptr = 0;
+	spin_unlock_irq(&chip->lock);
+	return 0;
+}
+
+#define snd_ak4113_in_bit_info		snd_ctl_boolean_mono_info
+
+static int snd_ak4113_in_bit_get(struct snd_kcontrol *kcontrol,
+				 struct snd_ctl_elem_value *ucontrol)
+{
+	struct ak4113 *chip = snd_kcontrol_chip(kcontrol);
+	unsigned char reg = kcontrol->private_value & 0xff;
+	unsigned char bit = (kcontrol->private_value >> 8) & 0xff;
+	unsigned char inv = (kcontrol->private_value >> 31) & 1;
+
+	ucontrol->value.integer.value[0] =
+		((reg_read(chip, reg) & (1 << bit)) ? 1 : 0) ^ inv;
+	return 0;
+}
+
+static int snd_ak4113_rx_info(struct snd_kcontrol *kcontrol,
+			      struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = 1;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = 5;
+	return 0;
+}
+
+static int snd_ak4113_rx_get(struct snd_kcontrol *kcontrol,
+			     struct snd_ctl_elem_value *ucontrol)
+{
+	struct ak4113 *chip = snd_kcontrol_chip(kcontrol);
+
+	ucontrol->value.integer.value[0] =
+		(AK4113_IPS(chip->regmap[AK4113_REG_IO1]));
+	return 0;
+}
+
+static int snd_ak4113_rx_put(struct snd_kcontrol *kcontrol,
+			     struct snd_ctl_elem_value *ucontrol)
+{
+	struct ak4113 *chip = snd_kcontrol_chip(kcontrol);
+	int change;
+	u8 old_val;
+
+	spin_lock_irq(&chip->lock);
+	old_val = chip->regmap[AK4113_REG_IO1];
+	change = ucontrol->value.integer.value[0] != AK4113_IPS(old_val);
+	if (change)
+		reg_write(chip, AK4113_REG_IO1,
+				(old_val & (~AK4113_IPS(0xff))) |
+				(AK4113_IPS(ucontrol->value.integer.value[0])));
+	spin_unlock_irq(&chip->lock);
+	return change;
+}
+
+static int snd_ak4113_rate_info(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = 1;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = 192000;
+	return 0;
+}
+
+static int snd_ak4113_rate_get(struct snd_kcontrol *kcontrol,
+			       struct snd_ctl_elem_value *ucontrol)
+{
+	struct ak4113 *chip = snd_kcontrol_chip(kcontrol);
+
+	ucontrol->value.integer.value[0] = external_rate(reg_read(chip,
+				AK4113_REG_RCS1));
+	return 0;
+}
+
+static int snd_ak4113_spdif_info(struct snd_kcontrol *kcontrol,
+		struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_IEC958;
+	uinfo->count = 1;
+	return 0;
+}
+
+static int snd_ak4113_spdif_get(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct ak4113 *chip = snd_kcontrol_chip(kcontrol);
+	unsigned i;
+
+	for (i = 0; i < AK4113_REG_RXCSB_SIZE; i++)
+		ucontrol->value.iec958.status[i] = reg_read(chip,
+				AK4113_REG_RXCSB0 + i);
+	return 0;
+}
+
+static int snd_ak4113_spdif_mask_info(struct snd_kcontrol *kcontrol,
+		struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_IEC958;
+	uinfo->count = 1;
+	return 0;
+}
+
+static int snd_ak4113_spdif_mask_get(struct snd_kcontrol *kcontrol,
+				      struct snd_ctl_elem_value *ucontrol)
+{
+	memset(ucontrol->value.iec958.status, 0xff, AK4113_REG_RXCSB_SIZE);
+	return 0;
+}
+
+static int snd_ak4113_spdif_pinfo(struct snd_kcontrol *kcontrol,
+		struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = 0xffff;
+	uinfo->count = 4;
+	return 0;
+}
+
+static int snd_ak4113_spdif_pget(struct snd_kcontrol *kcontrol,
+				 struct snd_ctl_elem_value *ucontrol)
+{
+	struct ak4113 *chip = snd_kcontrol_chip(kcontrol);
+	unsigned short tmp;
+
+	ucontrol->value.integer.value[0] = 0xf8f2;
+	ucontrol->value.integer.value[1] = 0x4e1f;
+	tmp = reg_read(chip, AK4113_REG_Pc0) |
+		(reg_read(chip, AK4113_REG_Pc1) << 8);
+	ucontrol->value.integer.value[2] = tmp;
+	tmp = reg_read(chip, AK4113_REG_Pd0) |
+		(reg_read(chip, AK4113_REG_Pd1) << 8);
+	ucontrol->value.integer.value[3] = tmp;
+	return 0;
+}
+
+static int snd_ak4113_spdif_qinfo(struct snd_kcontrol *kcontrol,
+		struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_BYTES;
+	uinfo->count = AK4113_REG_QSUB_SIZE;
+	return 0;
+}
+
+static int snd_ak4113_spdif_qget(struct snd_kcontrol *kcontrol,
+				 struct snd_ctl_elem_value *ucontrol)
+{
+	struct ak4113 *chip = snd_kcontrol_chip(kcontrol);
+	unsigned i;
+
+	for (i = 0; i < AK4113_REG_QSUB_SIZE; i++)
+		ucontrol->value.bytes.data[i] = reg_read(chip,
+				AK4113_REG_QSUB_ADDR + i);
+	return 0;
+}
+
+/* Don't forget to change AK4113_CONTROLS define!!! */
+static struct snd_kcontrol_new snd_ak4113_iec958_controls[] = {
+{
+	.iface =	SNDRV_CTL_ELEM_IFACE_PCM,
+	.name =		"IEC958 Parity Errors",
+	.access =	SNDRV_CTL_ELEM_ACCESS_READ |
+		SNDRV_CTL_ELEM_ACCESS_VOLATILE,
+	.info =		snd_ak4113_in_error_info,
+	.get =		snd_ak4113_in_error_get,
+	.private_value = offsetof(struct ak4113, parity_errors),
+},
+{
+	.iface =	SNDRV_CTL_ELEM_IFACE_PCM,
+	.name =		"IEC958 V-Bit Errors",
+	.access =	SNDRV_CTL_ELEM_ACCESS_READ |
+		SNDRV_CTL_ELEM_ACCESS_VOLATILE,
+	.info =		snd_ak4113_in_error_info,
+	.get =		snd_ak4113_in_error_get,
+	.private_value = offsetof(struct ak4113, v_bit_errors),
+},
+{
+	.iface =	SNDRV_CTL_ELEM_IFACE_PCM,
+	.name =		"IEC958 C-CRC Errors",
+	.access =	SNDRV_CTL_ELEM_ACCESS_READ |
+		SNDRV_CTL_ELEM_ACCESS_VOLATILE,
+	.info =		snd_ak4113_in_error_info,
+	.get =		snd_ak4113_in_error_get,
+	.private_value = offsetof(struct ak4113, ccrc_errors),
+},
+{
+	.iface =	SNDRV_CTL_ELEM_IFACE_PCM,
+	.name =		"IEC958 Q-CRC Errors",
+	.access =	SNDRV_CTL_ELEM_ACCESS_READ |
+		SNDRV_CTL_ELEM_ACCESS_VOLATILE,
+	.info =		snd_ak4113_in_error_info,
+	.get =		snd_ak4113_in_error_get,
+	.private_value = offsetof(struct ak4113, qcrc_errors),
+},
+{
+	.iface =	SNDRV_CTL_ELEM_IFACE_PCM,
+	.name =		"IEC958 External Rate",
+	.access =	SNDRV_CTL_ELEM_ACCESS_READ |
+		SNDRV_CTL_ELEM_ACCESS_VOLATILE,
+	.info =		snd_ak4113_rate_info,
+	.get =		snd_ak4113_rate_get,
+},
+{
+	.iface =	SNDRV_CTL_ELEM_IFACE_PCM,
+	.name =		SNDRV_CTL_NAME_IEC958("", CAPTURE, MASK),
+	.access =	SNDRV_CTL_ELEM_ACCESS_READ,
+	.info =		snd_ak4113_spdif_mask_info,
+	.get =		snd_ak4113_spdif_mask_get,
+},
+{
+	.iface =	SNDRV_CTL_ELEM_IFACE_PCM,
+	.name =		SNDRV_CTL_NAME_IEC958("", CAPTURE, DEFAULT),
+	.access =	SNDRV_CTL_ELEM_ACCESS_READ |
+		SNDRV_CTL_ELEM_ACCESS_VOLATILE,
+	.info =		snd_ak4113_spdif_info,
+	.get =		snd_ak4113_spdif_get,
+},
+{
+	.iface =	SNDRV_CTL_ELEM_IFACE_PCM,
+	.name =		"IEC958 Preample Capture Default",
+	.access =	SNDRV_CTL_ELEM_ACCESS_READ |
+		SNDRV_CTL_ELEM_ACCESS_VOLATILE,
+	.info =		snd_ak4113_spdif_pinfo,
+	.get =		snd_ak4113_spdif_pget,
+},
+{
+	.iface =	SNDRV_CTL_ELEM_IFACE_PCM,
+	.name =		"IEC958 Q-subcode Capture Default",
+	.access =	SNDRV_CTL_ELEM_ACCESS_READ |
+		SNDRV_CTL_ELEM_ACCESS_VOLATILE,
+	.info =		snd_ak4113_spdif_qinfo,
+	.get =		snd_ak4113_spdif_qget,
+},
+{
+	.iface =	SNDRV_CTL_ELEM_IFACE_PCM,
+	.name =		"IEC958 Audio",
+	.access =	SNDRV_CTL_ELEM_ACCESS_READ |
+		SNDRV_CTL_ELEM_ACCESS_VOLATILE,
+	.info =		snd_ak4113_in_bit_info,
+	.get =		snd_ak4113_in_bit_get,
+	.private_value = (1<<31) | (1<<8) | AK4113_REG_RCS0,
+},
+{
+	.iface =	SNDRV_CTL_ELEM_IFACE_PCM,
+	.name =		"IEC958 Non-PCM Bitstream",
+	.access =	SNDRV_CTL_ELEM_ACCESS_READ |
+		SNDRV_CTL_ELEM_ACCESS_VOLATILE,
+	.info =		snd_ak4113_in_bit_info,
+	.get =		snd_ak4113_in_bit_get,
+	.private_value = (0<<8) | AK4113_REG_RCS1,
+},
+{
+	.iface =	SNDRV_CTL_ELEM_IFACE_PCM,
+	.name =		"IEC958 DTS Bitstream",
+	.access =	SNDRV_CTL_ELEM_ACCESS_READ |
+		SNDRV_CTL_ELEM_ACCESS_VOLATILE,
+	.info =		snd_ak4113_in_bit_info,
+	.get =		snd_ak4113_in_bit_get,
+	.private_value = (1<<8) | AK4113_REG_RCS1,
+},
+{
+	.iface =	SNDRV_CTL_ELEM_IFACE_PCM,
+	.name =		"AK4113 Input Select",
+	.access =	SNDRV_CTL_ELEM_ACCESS_READ |
+		SNDRV_CTL_ELEM_ACCESS_WRITE,
+	.info =		snd_ak4113_rx_info,
+	.get =		snd_ak4113_rx_get,
+	.put =		snd_ak4113_rx_put,
+}
+};
+
+static void snd_ak4113_proc_regs_read(struct snd_info_entry *entry,
+		struct snd_info_buffer *buffer)
+{
+	struct ak4113 *ak4113 = entry->private_data;
+	int reg, val;
+	/* all ak4113 registers 0x00 - 0x1c */
+	for (reg = 0; reg < 0x1d; reg++) {
+		val = reg_read(ak4113, reg);
+		snd_iprintf(buffer, "0x%02x = 0x%02x\n", reg, val);
+	}
+}
+
+static void snd_ak4113_proc_init(struct ak4113 *ak4113)
+{
+	struct snd_info_entry *entry;
+	if (!snd_card_proc_new(ak4113->card, "ak4113", &entry))
+		snd_info_set_text_ops(entry, ak4113, snd_ak4113_proc_regs_read);
+}
+
+int snd_ak4113_build(struct ak4113 *ak4113,
+		struct snd_pcm_substream *cap_substream)
+{
+	struct snd_kcontrol *kctl;
+	unsigned int idx;
+	int err;
+
+	if (snd_BUG_ON(!cap_substream))
+		return -EINVAL;
+	ak4113->substream = cap_substream;
+	for (idx = 0; idx < AK4113_CONTROLS; idx++) {
+		kctl = snd_ctl_new1(&snd_ak4113_iec958_controls[idx], ak4113);
+		if (kctl == NULL)
+			return -ENOMEM;
+		kctl->id.device = cap_substream->pcm->device;
+		kctl->id.subdevice = cap_substream->number;
+		err = snd_ctl_add(ak4113->card, kctl);
+		if (err < 0)
+			return err;
+		ak4113->kctls[idx] = kctl;
+	}
+	snd_ak4113_proc_init(ak4113);
+	/* trigger workq */
+	schedule_delayed_work(&ak4113->work, HZ / 10);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_ak4113_build);
+
+int snd_ak4113_external_rate(struct ak4113 *ak4113)
+{
+	unsigned char rcs1;
+
+	rcs1 = reg_read(ak4113, AK4113_REG_RCS1);
+	return external_rate(rcs1);
+}
+EXPORT_SYMBOL_GPL(snd_ak4113_external_rate);
+
+int snd_ak4113_check_rate_and_errors(struct ak4113 *ak4113, unsigned int flags)
+{
+	struct snd_pcm_runtime *runtime =
+		ak4113->substream ? ak4113->substream->runtime : NULL;
+	unsigned long _flags;
+	int res = 0;
+	unsigned char rcs0, rcs1, rcs2;
+	unsigned char c0, c1;
+
+	rcs1 = reg_read(ak4113, AK4113_REG_RCS1);
+	if (flags & AK4113_CHECK_NO_STAT)
+		goto __rate;
+	rcs0 = reg_read(ak4113, AK4113_REG_RCS0);
+	rcs2 = reg_read(ak4113, AK4113_REG_RCS2);
+	spin_lock_irqsave(&ak4113->lock, _flags);
+	if (rcs0 & AK4113_PAR)
+		ak4113->parity_errors++;
+	if (rcs0 & AK4113_V)
+		ak4113->v_bit_errors++;
+	if (rcs2 & AK4113_CCRC)
+		ak4113->ccrc_errors++;
+	if (rcs2 & AK4113_QCRC)
+		ak4113->qcrc_errors++;
+	c0 = (ak4113->rcs0 & (AK4113_QINT | AK4113_CINT | AK4113_STC |
+				AK4113_AUDION | AK4113_AUTO | AK4113_UNLCK)) ^
+		(rcs0 & (AK4113_QINT | AK4113_CINT | AK4113_STC |
+			 AK4113_AUDION | AK4113_AUTO | AK4113_UNLCK));
+	c1 = (ak4113->rcs1 & (AK4113_DTSCD | AK4113_NPCM | AK4113_PEM |
+				AK4113_DAT | 0xf0)) ^
+		(rcs1 & (AK4113_DTSCD | AK4113_NPCM | AK4113_PEM |
+			 AK4113_DAT | 0xf0));
+	ak4113->rcs0 = rcs0 & ~(AK4113_QINT | AK4113_CINT | AK4113_STC);
+	ak4113->rcs1 = rcs1;
+	ak4113->rcs2 = rcs2;
+	spin_unlock_irqrestore(&ak4113->lock, _flags);
+
+	if (rcs0 & AK4113_PAR)
+		snd_ctl_notify(ak4113->card, SNDRV_CTL_EVENT_MASK_VALUE,
+				&ak4113->kctls[0]->id);
+	if (rcs0 & AK4113_V)
+		snd_ctl_notify(ak4113->card, SNDRV_CTL_EVENT_MASK_VALUE,
+				&ak4113->kctls[1]->id);
+	if (rcs2 & AK4113_CCRC)
+		snd_ctl_notify(ak4113->card, SNDRV_CTL_EVENT_MASK_VALUE,
+				&ak4113->kctls[2]->id);
+	if (rcs2 & AK4113_QCRC)
+		snd_ctl_notify(ak4113->card, SNDRV_CTL_EVENT_MASK_VALUE,
+				&ak4113->kctls[3]->id);
+
+	/* rate change */
+	if (c1 & 0xf0)
+		snd_ctl_notify(ak4113->card, SNDRV_CTL_EVENT_MASK_VALUE,
+				&ak4113->kctls[4]->id);
+
+	if ((c1 & AK4113_PEM) | (c0 & AK4113_CINT))
+		snd_ctl_notify(ak4113->card, SNDRV_CTL_EVENT_MASK_VALUE,
+				&ak4113->kctls[6]->id);
+	if (c0 & AK4113_QINT)
+		snd_ctl_notify(ak4113->card, SNDRV_CTL_EVENT_MASK_VALUE,
+				&ak4113->kctls[8]->id);
+
+	if (c0 & AK4113_AUDION)
+		snd_ctl_notify(ak4113->card, SNDRV_CTL_EVENT_MASK_VALUE,
+				&ak4113->kctls[9]->id);
+	if (c1 & AK4113_NPCM)
+		snd_ctl_notify(ak4113->card, SNDRV_CTL_EVENT_MASK_VALUE,
+				&ak4113->kctls[10]->id);
+	if (c1 & AK4113_DTSCD)
+		snd_ctl_notify(ak4113->card, SNDRV_CTL_EVENT_MASK_VALUE,
+				&ak4113->kctls[11]->id);
+
+	if (ak4113->change_callback && (c0 | c1) != 0)
+		ak4113->change_callback(ak4113, c0, c1);
+
+__rate:
+	/* compare rate */
+	res = external_rate(rcs1);
+	if (!(flags & AK4113_CHECK_NO_RATE) && runtime &&
+			(runtime->rate != res)) {
+		snd_pcm_stream_lock_irqsave(ak4113->substream, _flags);
+		if (snd_pcm_running(ak4113->substream)) {
+			/*printk(KERN_DEBUG "rate changed (%i <- %i)\n",
+			 * runtime->rate, res); */
+			snd_pcm_stop(ak4113->substream,
+					SNDRV_PCM_STATE_DRAINING);
+			wake_up(&runtime->sleep);
+			res = 1;
+		}
+		snd_pcm_stream_unlock_irqrestore(ak4113->substream, _flags);
+	}
+	return res;
+}
+EXPORT_SYMBOL_GPL(snd_ak4113_check_rate_and_errors);
+
+static void ak4113_stats(struct work_struct *work)
+{
+	struct ak4113 *chip = container_of(work, struct ak4113, work.work);
+
+	if (!chip->init)
+		snd_ak4113_check_rate_and_errors(chip, chip->check_flags);
+
+	schedule_delayed_work(&chip->work, HZ / 10);
+}
diff --git a/include/ak4113.h b/include/ak4113.h
new file mode 100644
index 0000000..8988eda
--- /dev/null
+++ b/include/ak4113.h
@@ -0,0 +1,321 @@
+#ifndef __SOUND_AK4113_H
+#define __SOUND_AK4113_H
+
+/*
+ *  Routines for Asahi Kasei AK4113
+ *  Copyright (c) by Jaroslav Kysela <perex@perex.cz>,
+ *  Copyright (c) by Pavel Hofman <pavel.hofman@ivitera.com>,
+ *
+ *
+ *   This program is free software; you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program; if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ *
+ */
+
+/* AK4113 registers */
+/* power down */
+#define AK4113_REG_PWRDN	0x00
+/* format control */
+#define AK4113_REG_FORMAT	0x01
+/* input/output control */
+#define AK4113_REG_IO0		0x02
+/* input/output control */
+#define AK4113_REG_IO1		0x03
+/* interrupt0 mask */
+#define AK4113_REG_INT0_MASK	0x04
+/* interrupt1 mask */
+#define AK4113_REG_INT1_MASK	0x05
+/* DAT mask & DTS select */
+#define AK4113_REG_DATDTS	0x06
+/* receiver status 0 */
+#define AK4113_REG_RCS0		0x07
+/* receiver status 1 */
+#define AK4113_REG_RCS1		0x08
+/* receiver status 2 */
+#define AK4113_REG_RCS2		0x09
+/* RX channel status byte 0 */
+#define AK4113_REG_RXCSB0	0x0a
+/* RX channel status byte 1 */
+#define AK4113_REG_RXCSB1	0x0b
+/* RX channel status byte 2 */
+#define AK4113_REG_RXCSB2	0x0c
+/* RX channel status byte 3 */
+#define AK4113_REG_RXCSB3	0x0d
+/* RX channel status byte 4 */
+#define AK4113_REG_RXCSB4	0x0e
+/* burst preamble Pc byte 0 */
+#define AK4113_REG_Pc0		0x0f
+/* burst preamble Pc byte 1 */
+#define AK4113_REG_Pc1		0x10
+/* burst preamble Pd byte 0 */
+#define AK4113_REG_Pd0		0x11
+/* burst preamble Pd byte 1 */
+#define AK4113_REG_Pd1		0x12
+/* Q-subcode address + control */
+#define AK4113_REG_QSUB_ADDR	0x13
+/* Q-subcode track */
+#define AK4113_REG_QSUB_TRACK	0x14
+/* Q-subcode index */
+#define AK4113_REG_QSUB_INDEX	0x15
+/* Q-subcode minute */
+#define AK4113_REG_QSUB_MINUTE	0x16
+/* Q-subcode second */
+#define AK4113_REG_QSUB_SECOND	0x17
+/* Q-subcode frame */
+#define AK4113_REG_QSUB_FRAME	0x18
+/* Q-subcode zero */
+#define AK4113_REG_QSUB_ZERO	0x19
+/* Q-subcode absolute minute */
+#define AK4113_REG_QSUB_ABSMIN	0x1a
+/* Q-subcode absolute second */
+#define AK4113_REG_QSUB_ABSSEC	0x1b
+/* Q-subcode absolute frame */
+#define AK4113_REG_QSUB_ABSFRM	0x1c
+
+/* sizes */
+#define AK4113_REG_RXCSB_SIZE	((AK4113_REG_RXCSB4-AK4113_REG_RXCSB0)+1)
+#define AK4113_REG_QSUB_SIZE	((AK4113_REG_QSUB_ABSFRM-AK4113_REG_QSUB_ADDR)\
+		+1)
+
+#define AK4113_WRITABLE_REGS	(AK4113_REG_DATDTS + 1)
+
+/* AK4113_REG_PWRDN bits */
+/* Channel Status Select */
+#define AK4113_CS12		(1<<7)
+/* Block Start & C/U Output Mode */
+#define AK4113_BCU		(1<<6)
+/* Master Clock Operation Select */
+#define AK4113_CM1		(1<<5)
+/* Master Clock Operation Select */
+#define AK4113_CM0		(1<<4)
+/* Master Clock Frequency Select */
+#define AK4113_OCKS1		(1<<3)
+/* Master Clock Frequency Select */
+#define AK4113_OCKS0		(1<<2)
+/* 0 = power down, 1 = normal operation */
+#define AK4113_PWN		(1<<1)
+/* 0 = reset & initialize (except thisregister), 1 = normal operation */
+#define AK4113_RST		(1<<0)
+
+/* AK4113_REQ_FORMAT bits */
+/* V/TX Output select: 0 = Validity Flag Output, 1 = TX */
+#define AK4113_VTX		(1<<7)
+/* Audio Data Control */
+#define AK4113_DIF2		(1<<6)
+/* Audio Data Control */
+#define AK4113_DIF1		(1<<5)
+/* Audio Data Control */
+#define AK4113_DIF0		(1<<4)
+/* Deemphasis Autodetect Enable (1 = enable) */
+#define AK4113_DEAU		(1<<3)
+/* 32kHz-48kHz Deemphasis Control */
+#define AK4113_DEM1		(1<<2)
+/* 32kHz-48kHz Deemphasis Control */
+#define AK4113_DEM0		(1<<1)
+#define AK4113_DEM_OFF		(AK4113_DEM0)
+#define AK4113_DEM_44KHZ	(0)
+#define AK4113_DEM_48KHZ	(AK4113_DEM1)
+#define AK4113_DEM_32KHZ	(AK4113_DEM0|AK4113_DEM1)
+/* STDO: 16-bit, right justified */
+#define AK4113_DIF_16R		(0)
+/* STDO: 18-bit, right justified */
+#define AK4113_DIF_18R		(AK4113_DIF0)
+/* STDO: 20-bit, right justified */
+#define AK4113_DIF_20R		(AK4113_DIF1)
+/* STDO: 24-bit, right justified */
+#define AK4113_DIF_24R		(AK4113_DIF1|AK4113_DIF0)
+/* STDO: 24-bit, left justified */
+#define AK4113_DIF_24L		(AK4113_DIF2)
+/* STDO: I2S */
+#define AK4113_DIF_24I2S	(AK4113_DIF2|AK4113_DIF0)
+/* STDO: 24-bit, left justified; LRCLK, BICK = Input */
+#define AK4113_DIF_I24L		(AK4113_DIF2|AK4113_DIF1)
+/* STDO: I2S;  LRCLK, BICK = Input */
+#define AK4113_DIF_I24I2S	(AK4113_DIF2|AK4113_DIF1|AK4113_DIF0)
+
+/* AK4113_REG_IO0 */
+/* XTL1=0,XTL0=0 -> 11.2896Mhz; XTL1=0,XTL0=1 -> 12.288Mhz */
+#define AK4113_XTL1		(1<<6)
+/* XTL1=1,XTL0=0 -> 24.576Mhz; XTL1=1,XTL0=1 -> use channel status */
+#define AK4113_XTL0		(1<<5)
+/* Block Start Signal Output: 0 = U-bit, 1 = C-bit (req. BCU = 1) */
+#define AK4113_UCE		(1<<4)
+/* TX Output Enable (1 = enable) */
+#define AK4113_TXE		(1<<3)
+/* Output Through Data Selector for TX pin */
+#define AK4113_OPS2		(1<<2)
+/* Output Through Data Selector for TX pin */
+#define AK4113_OPS1		(1<<1)
+/* Output Through Data Selector for TX pin */
+#define AK4113_OPS0		(1<<0)
+/* 11.2896 MHz ref. Xtal freq. */
+#define AK4113_XTL_11_2896M	(0)
+/* 12.288 MHz ref. Xtal freq. */
+#define AK4113_XTL_12_288M	(AK4113_XTL0)
+/* 24.576 MHz ref. Xtal freq. */
+#define AK4113_XTL_24_576M	(AK4113_XTL1)
+
+/* AK4113_REG_IO1 */
+/* Interrupt 0 pin Hold */
+#define AK4113_EFH1		(1<<7)
+/* Interrupt 0 pin Hold */
+#define AK4113_EFH0		(1<<6)
+#define AK4113_EFH_512LRCLK	(0)
+#define AK4113_EFH_1024LRCLK	(AK4113_EFH0)
+#define AK4113_EFH_2048LRCLK	(AK4113_EFH1)
+#define AK4113_EFH_4096LRCLK	(AK4113_EFH1|AK4113_EFH0)
+/* PLL Lock Time: 0 = 384/fs, 1 = 1/fs */
+#define AK4113_FAST		(1<<5)
+/* MCKO2 Output Select: 0 = CMx/OCKSx, 1 = Xtal */
+#define AK4113_XMCK		(1<<4)
+/* MCKO2 Output Freq. Select: 0 = x1, 1 = x0.5  (req. XMCK = 1) */
+#define AK4113_DIV		(1<<3)
+/* Input Recovery Data Select */
+#define AK4113_IPS2		(1<<2)
+/* Input Recovery Data Select */
+#define AK4113_IPS1		(1<<1)
+/* Input Recovery Data Select */
+#define AK4113_IPS0		(1<<0)
+#define AK4113_IPS(x)		((x)&7)
+
+/* AK4113_REG_INT0_MASK && AK4113_REG_INT1_MASK*/
+/* mask enable for QINT bit */
+#define AK4113_MQI		(1<<7)
+/* mask enable for AUTO bit */
+#define AK4113_MAUT		(1<<6)
+/* mask enable for CINT bit */
+#define AK4113_MCIT		(1<<5)
+/* mask enable for UNLOCK bit */
+#define AK4113_MULK		(1<<4)
+/* mask enable for V bit */
+#define AK4113_V		(1<<3)
+/* mask enable for STC bit */
+#define AK4113_STC		(1<<2)
+/* mask enable for AUDN bit */
+#define AK4113_MAN		(1<<1)
+/* mask enable for PAR bit */
+#define AK4113_MPR		(1<<0)
+
+/* AK4113_REG_DATDTS */
+/* DAT Start ID Counter */
+#define AK4113_DCNT		(1<<4)
+/* DTS-CD 16-bit Sync Word Detect */
+#define AK4113_DTS16		(1<<3)
+/* DTS-CD 14-bit Sync Word Detect */
+#define AK4113_DTS14		(1<<2)
+/* mask enable for DAT bit (if 1, no INT1 effect */
+#define AK4113_MDAT1		(1<<1)
+/* mask enable for DAT bit (if 1, no INT0 effect */
+#define AK4113_MDAT0		(1<<0)
+
+/* AK4113_REG_RCS0 */
+/* Q-subcode buffer interrupt, 0 = no change, 1 = changed */
+#define AK4113_QINT		(1<<7)
+/* Non-PCM or DTS stream auto detection, 0 = no detect, 1 = detect */
+#define AK4113_AUTO		(1<<6)
+/* channel status buffer interrupt, 0 = no change, 1 = change */
+#define AK4113_CINT		(1<<5)
+/* PLL lock status, 0 = lock, 1 = unlock */
+#define AK4113_UNLCK		(1<<4)
+/* Validity bit, 0 = valid, 1 = invalid */
+#define AK4113_V		(1<<3)
+/* sampling frequency or Pre-emphasis change, 0 = no detect, 1 = detect */
+#define AK4113_STC		(1<<2)
+/* audio bit output, 0 = audio, 1 = non-audio */
+#define AK4113_AUDION		(1<<1)
+/* parity error or biphase error status, 0 = no error, 1 = error */
+#define AK4113_PAR		(1<<0)
+
+/* AK4113_REG_RCS1 */
+/* sampling frequency detection */
+#define AK4113_FS3		(1<<7)
+#define AK4113_FS2		(1<<6)
+#define AK4113_FS1		(1<<5)
+#define AK4113_FS0		(1<<4)
+/* Pre-emphasis detect, 0 = OFF, 1 = ON */
+#define AK4113_PEM		(1<<3)
+/* DAT Start ID Detect, 0 = no detect, 1 = detect */
+#define AK4113_DAT		(1<<2)
+/* DTS-CD bit audio stream detect, 0 = no detect, 1 = detect */
+#define AK4113_DTSCD		(1<<1)
+/* Non-PCM bit stream detection, 0 = no detect, 1 = detect */
+#define AK4113_NPCM		(1<<0)
+#define AK4113_FS_8000HZ	(AK4113_FS3|AK4113_FS0)
+#define AK4113_FS_11025HZ	(AK4113_FS2|AK4113_FS0)
+#define AK4113_FS_16000HZ	(AK4113_FS2|AK4113_FS1|AK4113_FS0)
+#define AK4113_FS_22050HZ	(AK4113_FS2)
+#define AK4113_FS_24000HZ	(AK4113_FS2|AK4113_FS1)
+#define AK4113_FS_32000HZ	(AK4113_FS1|AK4113_FS0)
+#define AK4113_FS_44100HZ	(0)
+#define AK4113_FS_48000HZ	(AK4113_FS1)
+#define AK4113_FS_64000HZ	(AK4113_FS3|AK4113_FS1|AK4113_FS0)
+#define AK4113_FS_88200HZ	(AK4113_FS3)
+#define AK4113_FS_96000HZ	(AK4113_FS3|AK4113_FS1)
+#define AK4113_FS_176400HZ	(AK4113_FS3|AK4113_FS2)
+#define AK4113_FS_192000HZ	(AK4113_FS3|AK4113_FS2|AK4113_FS1)
+
+/* AK4113_REG_RCS2 */
+/* CRC for Q-subcode, 0 = no error, 1 = error */
+#define AK4113_QCRC		(1<<1)
+/* CRC for channel status, 0 = no error, 1 = error */
+#define AK4113_CCRC		(1<<0)
+
+/* flags for snd_ak4113_check_rate_and_errors() */
+#define AK4113_CHECK_NO_STAT	(1<<0)	/* no statistics */
+#define AK4113_CHECK_NO_RATE	(1<<1)	/* no rate check */
+
+#define AK4113_CONTROLS		13
+
+typedef void (ak4113_write_t)(void *private_data, unsigned char addr,
+		unsigned char data);
+typedef unsigned char (ak4113_read_t)(void *private_data, unsigned char addr);
+
+struct ak4113 {
+	struct snd_card *card;
+	ak4113_write_t *write;
+	ak4113_read_t *read;
+	void *private_data;
+	unsigned int init:1;
+	spinlock_t lock;
+	unsigned char regmap[AK4113_WRITABLE_REGS];
+	struct snd_kcontrol *kctls[AK4113_CONTROLS];
+	struct snd_pcm_substream *substream;
+	unsigned long parity_errors;
+	unsigned long v_bit_errors;
+	unsigned long qcrc_errors;
+	unsigned long ccrc_errors;
+	unsigned char rcs0;
+	unsigned char rcs1;
+	unsigned char rcs2;
+	struct delayed_work work;
+	unsigned int check_flags;
+	void *change_callback_private;
+	void (*change_callback)(struct ak4113 *ak4113, unsigned char c0,
+			unsigned char c1);
+};
+
+int snd_ak4113_create(struct snd_card *card, ak4113_read_t *read,
+		ak4113_write_t *write,
+		const unsigned char pgm[AK4113_WRITABLE_REGS],
+		void *private_data, struct ak4113 **r_ak4113);
+void snd_ak4113_reg_write(struct ak4113 *ak4113, unsigned char reg,
+		unsigned char mask, unsigned char val);
+void snd_ak4113_reinit(struct ak4113 *ak4113);
+int snd_ak4113_build(struct ak4113 *ak4113,
+		struct snd_pcm_substream *capture_substream);
+int snd_ak4113_external_rate(struct ak4113 *ak4113);
+int snd_ak4113_check_rate_and_errors(struct ak4113 *ak4113, unsigned int flags);
+
+#endif /* __SOUND_AK4113_H */
+
diff --git a/scripts/ksync.conf b/scripts/ksync.conf
index 65cfde1..e3bbceb 100644
--- a/scripts/ksync.conf
+++ b/scripts/ksync.conf
@@ -174,6 +174,8 @@ comment.map.alsa-driver::= \
 	/i2c/l3:"L3 drivers" \
 	/include/tea575x-tuner.h:"TEA575x tuner" \
 	/i2c/other/tea575x-tuner.c:"TEA575x tuner" \
+	/include/ak4113.h:"AK4113 receiver" \
+	/i2c/other/ak4113.c:"AK4113 receiver" \
 	/include/ak4114.h:"AK4114 receiver" \
 	/i2c/other/ak4114.c:"AK4114 receiver" \
 	/include/ak4117.h:"AK4117 receiver" \
-- 
1.5.6.3
