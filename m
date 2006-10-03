From: Jochen Voss <voss@seehuhn.de>
Subject: [PATCH 2/2] enable the analog loopback of the
	Revolution 5.1
Date: Wed, 4 Oct 2006 00:28:48 +0100
Message-ID: <20061003232845.GC1871@tarte.seehuhn.de>
References: <20061003232655.GA1871@tarte.seehuhn.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0929531604=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20061003232655.GA1871@tarte.seehuhn.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: ALSA development list <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--===============0929531604==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="96YOpH+ONegL0A3E"
Content-Disposition: inline


--96YOpH+ONegL0A3E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Enable the analog loopback of the Revolution 5.1 card.

This patch adds support for the PT2258 volume controller and modifies
the Revolution 5.1 driver to make use of this facility.  This allows
to control the analog loopback of the card.

Signed-off-by: Jochen Voss <voss@seehuhn.de>

diff -ur -x sound -x Modules.symvers -x Makefile.conf alsa-driver-hg2006092=
9.p1/alsa-kernel/i2c/Makefile alsa-driver-hg20060929.p2/alsa-kernel/i2c/Mak=
efile
--- alsa-driver-hg20060929.p1/alsa-kernel/i2c/Makefile	2006-08-28 18:20:17.=
000000000 +0100
+++ alsa-driver-hg20060929.p2/alsa-kernel/i2c/Makefile	2006-10-03 22:42:07.=
387170975 +0100
@@ -16,3 +16,4 @@
 # Toplevel Module Dependency
 obj-$(CONFIG_SND_INTERWAVE_STB) +=3D snd-tea6330t.o snd-i2c.o
 obj-$(CONFIG_SND_ICE1712) +=3D snd-cs8427.o snd-i2c.o
+obj-$(CONFIG_SND_ICE1724) +=3D snd-i2c.o
diff -ur -x sound -x Modules.symvers -x Makefile.conf alsa-driver-hg2006092=
9.p1/alsa-kernel/i2c/other/Makefile alsa-driver-hg20060929.p2/alsa-kernel/i=
2c/other/Makefile
--- alsa-driver-hg20060929.p1/alsa-kernel/i2c/other/Makefile	2006-08-28 18:=
20:17.000000000 +0100
+++ alsa-driver-hg20060929.p2/alsa-kernel/i2c/other/Makefile	2006-10-03 22:=
42:07.387170975 +0100
@@ -6,11 +6,11 @@
 snd-ak4114-objs :=3D ak4114.o
 snd-ak4117-objs :=3D ak4117.o
 snd-ak4xxx-adda-objs :=3D ak4xxx-adda.o
+snd-pt2258-objs :=3D pt2258.o
 snd-tea575x-tuner-objs :=3D tea575x-tuner.o
=20
 # Module Dependency
 obj-$(CONFIG_SND_PDAUDIOCF) +=3D snd-ak4117.o
 obj-$(CONFIG_SND_ICE1712) +=3D snd-ak4xxx-adda.o
-obj-$(CONFIG_SND_ICE1724) +=3D snd-ak4xxx-adda.o
-obj-$(CONFIG_SND_ICE1724) +=3D snd-ak4114.o
+obj-$(CONFIG_SND_ICE1724) +=3D snd-ak4114.o snd-ak4xxx-adda.o snd-pt2258.o
 obj-$(CONFIG_SND_FM801_TEA575X) +=3D snd-tea575x-tuner.o
diff -ur -x sound -x Modules.symvers -x Makefile.conf alsa-driver-hg2006092=
9.p1/alsa-kernel/i2c/other/pt2258.c alsa-driver-hg20060929.p2/alsa-kernel/i=
2c/other/pt2258.c
--- alsa-driver-hg20060929.p1/alsa-kernel/i2c/other/pt2258.c	2006-10-03 21:=
40:29.839466517 +0100
+++ alsa-driver-hg20060929.p2/alsa-kernel/i2c/other/pt2258.c	2006-10-03 22:=
42:07.387170975 +0100
@@ -0,0 +1,233 @@
+/*
+ *   ALSA Driver for the PT2258 volume controller.
+ *
+ *	Copyright (c) 2006  Jochen Voss <voss@seehuhn.de>
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
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 =
USA
+ *
+ */     =20
+
+#include <sound/driver.h>
+#include <sound/core.h>
+#include <sound/control.h>
+#include <sound/tlv.h>
+#include <sound/i2c.h>
+#include <sound/pt2258.h>
+
+MODULE_AUTHOR("Jochen Voss <voss@seehuhn.de>");
+MODULE_DESCRIPTION("PT2258 volume controller (Princeton Technology Corp.)"=
);
+MODULE_LICENSE("GPL");
+
+#define PT2258_CMD_RESET 0xc0
+#define PT2258_CMD_UNMUTE 0xf8
+#define PT2258_CMD_MUTE 0xf9
+
+static const unsigned char pt2258_channel_code[12] =3D {
+	0x80, 0x90,		/* channel 1: -10dB, -1dB */
+	0x40, 0x50,		/* channel 2: -10dB, -1dB */
+	0x00, 0x10,		/* channel 3: -10dB, -1dB */
+	0x20, 0x30,		/* channel 4: -10dB, -1dB */
+	0x60, 0x70,		/* channel 5: -10dB, -1dB */
+	0xa0, 0xb0		/* channel 6: -10dB, -1dB */
+};
+
+int snd_pt2258_reset(struct snd_pt2258 *pt)
+{
+	unsigned char bytes[2];
+	int i;
+
+	/* reset chip */
+	bytes[0] =3D PT2258_CMD_RESET;
+	snd_i2c_lock(pt->i2c_bus);
+	if (snd_i2c_sendbytes(pt->i2c_dev, bytes, 1) !=3D 1)
+		goto __error;
+	snd_i2c_unlock(pt->i2c_bus);
+
+	/* mute all channels */
+	pt->mute =3D 1;
+	bytes[0] =3D PT2258_CMD_MUTE;
+	snd_i2c_lock(pt->i2c_bus);
+	if (snd_i2c_sendbytes(pt->i2c_dev, bytes, 1) !=3D 1)
+		goto __error;
+	snd_i2c_unlock(pt->i2c_bus);
+
+	/* set all channels to 0dB */
+	for (i =3D 0; i < 6; ++i)
+		pt->volume[i] =3D 0;
+	bytes[0] =3D 0xd0;
+	bytes[1] =3D 0xe0;
+	snd_i2c_lock(pt->i2c_bus);
+	if (snd_i2c_sendbytes(pt->i2c_dev, bytes, 2) !=3D 2)
+		goto __error;
+	snd_i2c_unlock(pt->i2c_bus);
+
+	return 0;
+
+      __error:
+	snd_i2c_unlock(pt->i2c_bus);
+	snd_printk(KERN_ERR "PT2258 reset failed\n");
+	return -EIO;
+}
+
+static int pt2258_stereo_volume_info(struct snd_kcontrol *kcontrol,
+				     struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type =3D SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count =3D 2;
+	uinfo->value.integer.min =3D 0;
+	uinfo->value.integer.max =3D 79;
+	return 0;
+}
+
+static int pt2258_stereo_volume_get(struct snd_kcontrol *kcontrol,
+				    struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_pt2258 *pt =3D kcontrol->private_data;
+	int base =3D kcontrol->private_value;
+
+	/* chip does not support register reads */
+	ucontrol->value.integer.value[0] =3D 79 - pt->volume[base];
+	ucontrol->value.integer.value[1] =3D 79 - pt->volume[base + 1];
+	return 0;
+}
+
+static int pt2258_stereo_volume_put(struct snd_kcontrol *kcontrol,
+				    struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_pt2258 *pt =3D kcontrol->private_data;
+	int base =3D kcontrol->private_value;
+	unsigned char bytes[2];
+	int val0, val1;
+
+	val0 =3D 79 - ucontrol->value.integer.value[0];
+	val1 =3D 79 - ucontrol->value.integer.value[1];
+	if (val0 =3D=3D pt->volume[base] && val1 =3D=3D pt->volume[base + 1])
+		return 0;
+
+	pt->volume[base] =3D val0;
+	bytes[0] =3D pt2258_channel_code[2 * base] | (val0 / 10);
+	bytes[1] =3D pt2258_channel_code[2 * base + 1] | (val0 % 10);
+	snd_i2c_lock(pt->i2c_bus);
+	if (snd_i2c_sendbytes(pt->i2c_dev, bytes, 2) !=3D 2)
+		goto __error;
+	snd_i2c_unlock(pt->i2c_bus);
+
+	pt->volume[base + 1] =3D val1;
+	bytes[0] =3D pt2258_channel_code[2 * base + 2] | (val1 / 10);
+	bytes[1] =3D pt2258_channel_code[2 * base + 3] | (val1 % 10);
+	snd_i2c_lock(pt->i2c_bus);
+	if (snd_i2c_sendbytes(pt->i2c_dev, bytes, 2) !=3D 2)
+		goto __error;
+	snd_i2c_unlock(pt->i2c_bus);
+
+	return 1;
+
+      __error:
+	snd_i2c_unlock(pt->i2c_bus);
+	snd_printk(KERN_ERR "PT2258 access failed\n");
+	return -EIO;
+}
+
+static int pt2258_switch_info(struct snd_kcontrol *kcontrol,
+			      struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type =3D SNDRV_CTL_ELEM_TYPE_BOOLEAN;
+	uinfo->count =3D 1;
+	uinfo->value.integer.min =3D 0;
+	uinfo->value.integer.max =3D 1;
+	return 0;
+}
+
+static int pt2258_switch_get(struct snd_kcontrol *kcontrol,
+			     struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_pt2258 *pt =3D kcontrol->private_data;
+
+	ucontrol->value.integer.value[0] =3D !pt->mute;
+	return 0;
+}
+
+static int pt2258_switch_put(struct snd_kcontrol *kcontrol,
+			     struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_pt2258 *pt =3D kcontrol->private_data;
+	unsigned char bytes[2];
+	int val;
+
+	val =3D !ucontrol->value.integer.value[0];
+	if (pt->mute =3D=3D val)
+		return 0;
+
+	pt->mute =3D val;
+	bytes[0] =3D val ? PT2258_CMD_MUTE : PT2258_CMD_UNMUTE;
+	snd_i2c_lock(pt->i2c_bus);
+	if (snd_i2c_sendbytes(pt->i2c_dev, bytes, 1) !=3D 1)
+		goto __error;
+	snd_i2c_unlock(pt->i2c_bus);
+
+	return 1;
+
+      __error:
+	snd_i2c_unlock(pt->i2c_bus);
+	snd_printk(KERN_ERR "PT2258 access failed 2\n");
+	return -EIO;
+}
+
+static DECLARE_TLV_DB_SCALE(pt2258_db_scale, -7900, 100, 0);
+
+int snd_pt2258_build_controls(struct snd_pt2258 *pt)
+{
+	struct snd_kcontrol_new knew;
+	char *names[3] =3D {
+		"Mic Loopback Playback Volume",
+		"Line Loopback Playback Volume",
+		"CD Loopback Playback Volume"
+	};
+	int i, err;
+
+	for (i =3D 0; i < 3; ++i) {
+		memset(&knew, 0, sizeof(knew));
+		knew.name =3D names[i];
+		knew.iface =3D SNDRV_CTL_ELEM_IFACE_MIXER;
+		knew.count =3D 1;
+		knew.access =3D SNDRV_CTL_ELEM_ACCESS_READWRITE |
+		    SNDRV_CTL_ELEM_ACCESS_TLV_READ;
+		knew.private_value =3D 2 * i;
+		knew.info =3D pt2258_stereo_volume_info;
+		knew.get =3D pt2258_stereo_volume_get;
+		knew.put =3D pt2258_stereo_volume_put;
+		knew.tlv.p =3D pt2258_db_scale;
+
+		err =3D snd_ctl_add(pt->card, snd_ctl_new1(&knew, pt));
+		if (err < 0)
+			return err;
+	}
+
+	memset(&knew, 0, sizeof(knew));
+	knew.name =3D "Loopback Switch";
+	knew.iface =3D SNDRV_CTL_ELEM_IFACE_MIXER;
+	knew.info =3D pt2258_switch_info;
+	knew.get =3D pt2258_switch_get;
+	knew.put =3D pt2258_switch_put;
+	knew.access =3D 0;
+	err =3D snd_ctl_add(pt->card, snd_ctl_new1(&knew, pt));
+	if (err < 0)
+		return err;
+
+	return 0;
+}
+
+EXPORT_SYMBOL(snd_pt2258_reset);
+EXPORT_SYMBOL(snd_pt2258_build_controls);
diff -ur -x sound -x Modules.symvers -x Makefile.conf alsa-driver-hg2006092=
9.p1/alsa-kernel/include/pt2258.h alsa-driver-hg20060929.p2/alsa-kernel/inc=
lude/pt2258.h
--- alsa-driver-hg20060929.p1/alsa-kernel/include/pt2258.h	2006-10-03 21:40=
:21.990979090 +0100
+++ alsa-driver-hg20060929.p2/alsa-kernel/include/pt2258.h	2006-10-03 22:42=
:07.387170975 +0100
@@ -0,0 +1,37 @@
+/*
+ *   ALSA Driver for the PT2258 volume controller.
+ *
+ *	Copyright (c) 2006  Jochen Voss <voss@seehuhn.de>
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
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 =
USA
+ *
+ */     =20
+
+#ifndef __SOUND_PT2258_H
+#define __SOUND_PT2258_H
+
+struct snd_pt2258 {
+	struct snd_card *card;
+	struct snd_i2c_bus *i2c_bus;
+	struct snd_i2c_device *i2c_dev;
+
+	unsigned char volume[6];
+	int mute;
+};
+
+extern int snd_pt2258_reset(struct snd_pt2258 *pt);
+extern int snd_pt2258_build_controls(struct snd_pt2258 *pt);
+
+#endif /* __SOUND_PT2258_H */
diff -ur -x sound -x Modules.symvers -x Makefile.conf alsa-driver-hg2006092=
9.p1/alsa-kernel/pci/ice1712/ice1712.h alsa-driver-hg20060929.p2/alsa-kerne=
l/pci/ice1712/ice1712.h
--- alsa-driver-hg20060929.p1/alsa-kernel/pci/ice1712/ice1712.h	2006-08-28 =
18:20:18.000000000 +0100
+++ alsa-driver-hg20060929.p2/alsa-kernel/pci/ice1712/ice1712.h	2006-10-03 =
22:42:07.387170975 +0100
@@ -28,6 +28,7 @@
 #include <sound/i2c.h>
 #include <sound/ak4xxx-adda.h>
 #include <sound/ak4114.h>
+#include <sound/pt2258.h>
 #include <sound/pcm.h>
 #include <sound/mpu401.h>
=20
@@ -381,6 +382,11 @@
 			unsigned short master[2];
 			unsigned short vol[8];
 		} phase28;
+		/* a non-standard I2C device for revo51 */
+		struct revo51_spec {
+			struct snd_i2c_device *dev;
+			struct snd_pt2258 *pt2258;
+		} revo51;
 		/* Hoontech-specific setting */
 		struct hoontech_spec {
 			unsigned char boxbits[4];
@@ -462,6 +468,14 @@
 	snd_ice1712_gpio_write(ice, mask & bits);
 }
=20
+static inline int snd_ice1712_gpio_read_bits(struct snd_ice1712 *ice,
+					      unsigned int mask)
+{
+	ice->gpio.direction &=3D ~mask;
+	snd_ice1712_gpio_set_dir(ice, ice->gpio.direction);
+	return  (snd_ice1712_gpio_read(ice) & mask);
+}
+
 int snd_ice1712_spdif_build_controls(struct snd_ice1712 *ice);
=20
 int snd_ice1712_akm4xxx_init(struct snd_akm4xxx *ak, const struct snd_akm4=
xxx *template,
diff -ur -x sound -x Modules.symvers -x Makefile.conf alsa-driver-hg2006092=
9.p1/alsa-kernel/pci/ice1712/revo.c alsa-driver-hg20060929.p2/alsa-kernel/p=
ci/ice1712/revo.c
--- alsa-driver-hg20060929.p1/alsa-kernel/pci/ice1712/revo.c	2006-10-03 20:=
37:46.944264000 +0100
+++ alsa-driver-hg20060929.p2/alsa-kernel/pci/ice1712/revo.c	2006-10-03 23:=
03:22.326742186 +0100
@@ -84,6 +84,102 @@
 }
=20
 /*
+ * I2C access to the PT2258 volume controller on GPIO 6/7 (Revolution 5.1)
+ */
+
+static void revo_i2c_start(struct snd_i2c_bus *bus)
+{
+	struct snd_ice1712 *ice =3D bus->private_data;
+	snd_ice1712_save_gpio_status(ice);
+}
+
+static void revo_i2c_stop(struct snd_i2c_bus *bus)
+{
+	struct snd_ice1712 *ice =3D bus->private_data;
+	snd_ice1712_restore_gpio_status(ice);
+}
+
+static void revo_i2c_direction(struct snd_i2c_bus *bus, int clock, int dat=
a)
+{
+	struct snd_ice1712 *ice =3D bus->private_data;
+	unsigned int mask, val;
+
+	val =3D 0;
+	if (clock)
+		val |=3D VT1724_REVO_I2C_CLOCK;	/* write SCL */
+	if (data)
+		val |=3D VT1724_REVO_I2C_DATA;	/* write SDA */
+	mask =3D VT1724_REVO_I2C_CLOCK | VT1724_REVO_I2C_DATA;
+	ice->gpio.direction &=3D ~mask;
+	ice->gpio.direction |=3D val;
+	snd_ice1712_gpio_set_dir(ice, ice->gpio.direction);
+	snd_ice1712_gpio_set_mask(ice, ~mask);
+}
+
+static void revo_i2c_setlines(struct snd_i2c_bus *bus, int clk, int data)
+{
+	struct snd_ice1712 *ice =3D bus->private_data;
+	unsigned int val =3D 0;
+
+	if (clk)
+		val |=3D VT1724_REVO_I2C_CLOCK;
+	if (data)
+		val |=3D VT1724_REVO_I2C_DATA;
+	snd_ice1712_gpio_write_bits(ice,
+				    VT1724_REVO_I2C_DATA |
+				    VT1724_REVO_I2C_CLOCK, val);
+	udelay(5);
+}
+
+static int revo_i2c_getdata(struct snd_i2c_bus *bus, int ack)
+{
+	struct snd_ice1712 *ice =3D bus->private_data;
+	int bit;
+
+	if (ack)
+		udelay(5);
+	bit =3D snd_ice1712_gpio_read_bits(ice, VT1724_REVO_I2C_DATA) ? 1 : 0;
+	return bit;
+}
+
+static struct snd_i2c_bit_ops revo51_bit_ops =3D {
+	.start =3D revo_i2c_start,
+	.stop =3D revo_i2c_stop,
+	.direction =3D revo_i2c_direction,
+	.setlines =3D revo_i2c_setlines,
+	.getdata =3D revo_i2c_getdata,
+};
+
+static int revo51_i2c_init(struct snd_ice1712 *ice,
+			   struct snd_pt2258 *pt)
+{
+	int err;
+
+	/* create the I2C bus */
+	err =3D snd_i2c_bus_create(ice->card, "ICE1724 GPIO6", NULL, &ice->i2c);
+	if (err < 0)
+		return err;
+
+	ice->i2c->private_data =3D ice;
+	ice->i2c->hw_ops.bit =3D &revo51_bit_ops;
+
+	/* create the I2C device */
+	err =3D snd_i2c_device_create(ice->i2c, "PT2258", 0x40,
+				    &ice->spec.revo51.dev);
+	if (err < 0)
+		return err;
+
+	pt->card =3D ice->card;
+	pt->i2c_bus =3D ice->i2c;
+	pt->i2c_dev =3D ice->spec.revo51.dev;
+	ice->spec.revo51.pt2258 =3D pt;
+
+	snd_pt2258_reset(pt);
+
+	return 0;
+}
+
+/*
  * initialize the chips on M-Audio Revolution cards
  */
=20
@@ -180,9 +276,9 @@
 	.cif =3D 0,
 	.data_mask =3D VT1724_REVO_CDOUT,
 	.clk_mask =3D VT1724_REVO_CCLK,
-	.cs_mask =3D VT1724_REVO_CS0 | VT1724_REVO_CS1 | VT1724_REVO_CS2,
-	.cs_addr =3D VT1724_REVO_CS1 | VT1724_REVO_CS2,
-	.cs_none =3D VT1724_REVO_CS0 | VT1724_REVO_CS1 | VT1724_REVO_CS2,
+	.cs_mask =3D VT1724_REVO_CS0 | VT1724_REVO_CS1,
+	.cs_addr =3D VT1724_REVO_CS1,
+	.cs_none =3D VT1724_REVO_CS0 | VT1724_REVO_CS1,
 	.add_flags =3D VT1724_REVO_CCLK, /* high at init */
 	.mask_flags =3D 0,
 };
@@ -198,13 +294,15 @@
 	.cif =3D 0,
 	.data_mask =3D VT1724_REVO_CDOUT,
 	.clk_mask =3D VT1724_REVO_CCLK,
-	.cs_mask =3D VT1724_REVO_CS0 | VT1724_REVO_CS1 | VT1724_REVO_CS2,
-	.cs_addr =3D VT1724_REVO_CS0 | VT1724_REVO_CS2,
-	.cs_none =3D VT1724_REVO_CS0 | VT1724_REVO_CS1 | VT1724_REVO_CS2,
+	.cs_mask =3D VT1724_REVO_CS0 | VT1724_REVO_CS1,
+	.cs_addr =3D VT1724_REVO_CS0,
+	.cs_none =3D VT1724_REVO_CS0 | VT1724_REVO_CS1,
 	.add_flags =3D VT1724_REVO_CCLK, /* high at init */
 	.mask_flags =3D 0,
 };
=20
+static struct snd_pt2258 ptc_revo51_volume;
+
 static int __devinit revo_init(struct snd_ice1712 *ice)
 {
 	struct snd_akm4xxx *ak;
@@ -243,14 +341,20 @@
 		break;
 	case VT1724_SUBDEVICE_REVOLUTION51:
 		ice->akm_codecs =3D 2;
-		if ((err =3D snd_ice1712_akm4xxx_init(ak, &akm_revo51, &akm_revo51_priv,=
 ice)) < 0)
+		err =3D snd_ice1712_akm4xxx_init(ak, &akm_revo51,
+					       &akm_revo51_priv, ice);
+		if (err < 0)
 			return err;
-		err =3D snd_ice1712_akm4xxx_init(ak + 1, &akm_revo51_adc,
+		err =3D snd_ice1712_akm4xxx_init(ak+1, &akm_revo51_adc,
 					       &akm_revo51_adc_priv, ice);
 		if (err < 0)
 			return err;
-		/* unmute all codecs - needed! */
-		snd_ice1712_gpio_write_bits(ice, VT1724_REVO_MUTE, VT1724_REVO_MUTE);
+		err =3D revo51_i2c_init(ice, &ptc_revo51_volume);
+		if (err < 0)
+			return err;
+		/* unmute all codecs */
+		snd_ice1712_gpio_write_bits(ice, VT1724_REVO_MUTE,
+					    VT1724_REVO_MUTE);
 		break;
 	}
=20
@@ -264,10 +368,18 @@
=20
 	switch (ice->eeprom.subvendor) {
 	case VT1724_SUBDEVICE_REVOLUTION71:
+		err =3D snd_ice1712_akm4xxx_build_controls(ice);
+		if (err < 0)
+			return err;
+		break;
 	case VT1724_SUBDEVICE_REVOLUTION51:
 		err =3D snd_ice1712_akm4xxx_build_controls(ice);
 		if (err < 0)
 			return err;
+		err =3D snd_pt2258_build_controls(ice->spec.revo51.pt2258);
+		if (err < 0)
+			return err;
+		break;
 	}
 	return 0;
 }
diff -ur -x sound -x Modules.symvers -x Makefile.conf alsa-driver-hg2006092=
9.p1/alsa-kernel/pci/ice1712/revo.h alsa-driver-hg20060929.p2/alsa-kernel/p=
ci/ice1712/revo.h
--- alsa-driver-hg20060929.p1/alsa-kernel/pci/ice1712/revo.h	2006-08-28 18:=
20:18.000000000 +0100
+++ alsa-driver-hg20060929.p2/alsa-kernel/pci/ice1712/revo.h	2006-10-03 22:=
42:07.391171225 +0100
@@ -42,9 +42,11 @@
 #define VT1724_REVO_CCLK	0x02
 #define VT1724_REVO_CDIN	0x04	/* not used */
 #define VT1724_REVO_CDOUT	0x08
-#define VT1724_REVO_CS0		0x10	/* AK5365 chipselect for Rev. 5.1 */
+#define VT1724_REVO_CS0		0x10	/* AK5365 chipselect for (revo51) */
 #define VT1724_REVO_CS1		0x20	/* front AKM4381 chipselect */
-#define VT1724_REVO_CS2		0x40	/* surround AKM4355 chipselect */
+#define VT1724_REVO_CS2		0x40	/* surround AKM4355 CS (revo71) */
+#define VT1724_REVO_I2C_DATA    0x40    /* I2C: PT 2258 SDA (on revo51) */
+#define VT1724_REVO_I2C_CLOCK   0x80    /* I2C: PT 2258 SCL (on revo51) */
 #define VT1724_REVO_MUTE	(1<<22)	/* 0 =3D all mute, 1 =3D normal operation=
 */
=20
 #endif /* __SOUND_REVO_H */
diff -ur -x sound -x Modules.symvers -x Makefile.conf alsa-driver-hg2006092=
9.p1/i2c/other/pt2258.c alsa-driver-hg20060929.p2/i2c/other/pt2258.c
--- alsa-driver-hg20060929.p1/i2c/other/pt2258.c	2006-10-03 21:40:40.596134=
540 +0100
+++ alsa-driver-hg20060929.p2/i2c/other/pt2258.c	2006-10-03 22:42:07.391171=
225 +0100
@@ -0,0 +1 @@
+#include "../../alsa-kernel/i2c/other/pt2258.c"

--96YOpH+ONegL0A3E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFIvItf+iD8yEbECURAkPyAJ9sqoTIKcGKYBNg5aaUSC42Rz1l6gCgvDSe
Y9oZGdyz4bBaCBLl6ISifWk=
=Oy29
-----END PGP SIGNATURE-----

--96YOpH+ONegL0A3E--


--===============0929531604==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0929531604==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0929531604==--
