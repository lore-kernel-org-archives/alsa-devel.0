From: Jochen Voss <voss@seehuhn.de>
Subject: [RFC] [PATCH] enable analog loopback for Revolution 5.1
Date: Sun, 1 Oct 2006 04:12:20 +0100
Message-ID: <20061001031219.GA22858@tarte.seehuhn.de>
References: <20060929223217.GA5624@tarte.seehuhn.de>
	<20060930200557.GB4876@seehuhn.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0556194742=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20060930200557.GB4876@seehuhn.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--===============0556194742==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3MwIy2ne0vdjdPXF"
Content-Disposition: inline


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Sat, Sep 30, 2006 at 09:05:57PM +0100, Jochen Voss wrote:
> I will need a bit of help with this.

Seems that this was not true.  Appended is a preliminary patch for
review.  It is only marginally tested, but seems to work.  I am aware
that storage of the 'struct revo51_pt2258' needs to be fixed.

Question:

1) are the control element names ok?

2) why does the TLV stuff not work?

3) At the moment I stuffed everything into "revo.c".  Can it stay
there?  Or where shall it go?

4) Is the locking ok?

5) The specs state that we should wait at least 200ms after power on
before talking to the PT2258.  Is this 200ms after the VT1722 is
initialised, or is this 200ms after the machine boots?  What do we
need to do about this?

6) Are the udelays ok?

All the best,
Jochen

diff -ur alsa-driver-hg20060929-capture/alsa-kernel/pci/ice1712/ice1712.h a=
lsa-driver-hg20060929/alsa-kernel/pci/ice1712/ice1712.h
--- alsa-driver-hg20060929-capture/alsa-kernel/pci/ice1712/ice1712.h	2006-0=
8-28 18:20:18.000000000 +0100
+++ alsa-driver-hg20060929/alsa-kernel/pci/ice1712/ice1712.h	2006-10-01 00:=
30:50.497493601 +0100
@@ -462,6 +462,14 @@
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
Only in alsa-driver-hg20060929/alsa-kernel/pci/ice1712: pt2258.c
diff -ur alsa-driver-hg20060929-capture/alsa-kernel/pci/ice1712/revo.c alsa=
-driver-hg20060929/alsa-kernel/pci/ice1712/revo.c
--- alsa-driver-hg20060929-capture/alsa-kernel/pci/ice1712/revo.c	2006-09-3=
0 20:16:17.206092000 +0100
+++ alsa-driver-hg20060929/alsa-kernel/pci/ice1712/revo.c	2006-10-01 04:02:=
16.067093990 +0100
@@ -28,6 +28,8 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <sound/core.h>
+#include <sound/control.h>
+#include <sound/tlv.h>
=20
 #include "ice1712.h"
 #include "envy24ht.h"
@@ -84,6 +86,307 @@
 }
=20
 /*
+ * mixer controls for the PT2258 volume controller on the Revolution 5.1 c=
ard
+ */
+
+struct revo51_pt2258 {
+	struct snd_card *card;
+	struct snd_i2c_bus *i2c_bus;
+	struct snd_i2c_device *i2c_dev;
+
+	unsigned char volume[6];
+	int mute;
+};
+
+static int revo51_pt2258_reset(struct revo51_pt2258 *pt)
+{
+	unsigned char bytes[2];
+	int i;
+
+	/* reset chip */
+	bytes[0] =3D 0xc0;
+	snd_i2c_lock(pt->i2c_bus);
+	if (snd_i2c_sendbytes(pt->i2c_dev, bytes, 1) !=3D 1)
+		goto __error;
+	snd_i2c_unlock(pt->i2c_bus);
+
+	/* mute all channels */
+	pt->mute =3D 1;
+	bytes[0] =3D 0xf9;
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
+	snd_printk(KERN_ERR "PT2258 access failed\n");
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
+	struct revo51_pt2258 *pt =3D kcontrol->private_data;
+	int base =3D kcontrol->private_value;
+
+	ucontrol->value.integer.value[0] =3D 79 - pt->volume[base];
+	ucontrol->value.integer.value[1] =3D 79 - pt->volume[base + 1];
+	return 0;
+}
+
+static const unsigned char pt2258_channel_id[12] =3D {
+	0x80, 0x90,		/* channel 1: -10dB, -1dB */
+	0x40, 0x50,		/* channel 2: -10dB, -1dB */
+	0x00, 0x10,		/* channel 3: -10dB, -1dB */
+	0x20, 0x30,		/* channel 4: -10dB, -1dB */
+	0x60, 0x70,		/* channel 5: -10dB, -1dB */
+	0xa0, 0xb0		/* channel 6: -10dB, -1dB */
+};
+
+static int pt2258_stereo_volume_put(struct snd_kcontrol *kcontrol,
+				    struct snd_ctl_elem_value *ucontrol)
+{
+	struct revo51_pt2258 *pt =3D kcontrol->private_data;
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
+	bytes[0] =3D pt2258_channel_id[2 * base] | (val0 / 10);
+	bytes[1] =3D pt2258_channel_id[2 * base + 1] | (val0 % 10);
+	snd_i2c_lock(pt->i2c_bus);
+	if (snd_i2c_sendbytes(pt->i2c_dev, bytes, 2) !=3D 2)
+		goto __error;
+	snd_i2c_unlock(pt->i2c_bus);
+
+	pt->volume[base + 1] =3D val1;
+	bytes[0] =3D pt2258_channel_id[2 * base + 2] | (val1 / 10);
+	bytes[1] =3D pt2258_channel_id[2 * base + 3] | (val1 % 10);
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
+	struct revo51_pt2258 *pt =3D kcontrol->private_data;
+
+	ucontrol->value.integer.value[0] =3D !pt->mute;
+	return 0;
+}
+
+static int pt2258_switch_put(struct snd_kcontrol *kcontrol,
+			     struct snd_ctl_elem_value *ucontrol)
+{
+	struct revo51_pt2258 *pt =3D kcontrol->private_data;
+	unsigned char bytes[2];
+	int val;
+
+	val =3D !ucontrol->value.integer.value[0];
+	if (pt->mute =3D=3D val)
+		return 0;
+
+	pt->mute =3D val;
+	bytes[0] =3D val ? 0xf9 : 0xf8;
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
+static int revo51_pt2258_build_controls(struct revo51_pt2258 *pt)
+{
+	struct snd_kcontrol_new knew;
+	char *names[3] =3D {
+		"Loopback Mic", "Loopback Line", "Loopback CD"
+	};
+	int i, err;
+
+	for (i =3D 0; i < 3; ++i) {
+		memset(&knew, 0, sizeof(knew));
+		knew.name =3D names[i];
+		knew.iface =3D SNDRV_CTL_ELEM_IFACE_MIXER;
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
+/*
+ * I2C access to the PT2258 volume controller on the Revolution 5.1 card
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
+static struct revo51_pt2258 _pt, *pt =3D &_pt;
+
+static int revo51_i2c_init(struct snd_ice1712 *ice)
+{
+	int err;
+
+	/* create I2C bus */
+	err =3D snd_i2c_bus_create(ice->card, "ICE1724 GPIO6", NULL, &ice->i2c);
+	if (err < 0) {
+		snd_printk(KERN_ERR "unable to create ICE1724 GPIO6 I2C bus\n");
+		return err;
+	}
+	ice->i2c->private_data =3D ice;
+	ice->i2c->hw_ops.bit =3D &revo51_bit_ops;
+
+	/* create I2C devices */
+	err =3D snd_i2c_device_create(ice->i2c, "PT2258", 0x40,
+				    &ice->spec.i2cdevs[0]);
+	if (err < 0)
+		return err;
+
+	pt->card =3D ice->card;
+	pt->i2c_bus =3D ice->i2c;
+	pt->i2c_dev =3D ice->spec.i2cdevs[0];
+
+	revo51_pt2258_reset(pt);
+
+	return 0;
+}
+
+/*
  * initialize the chips on M-Audio Revolution cards
  */
=20
@@ -180,9 +483,9 @@
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
@@ -198,9 +501,9 @@
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
@@ -243,14 +546,20 @@
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
+		err =3D revo51_i2c_init(ice);
+		if (err < 0)
+			return err;
+		/* unmute all codecs */
+		snd_ice1712_gpio_write_bits(ice, VT1724_REVO_MUTE,
+					    VT1724_REVO_MUTE);
 		break;
 	}
=20
@@ -264,10 +573,18 @@
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
+		err =3D revo51_pt2258_build_controls(pt);
+		if (err < 0)
+			return err;
+		break;
 	}
 	return 0;
 }
diff -ur alsa-driver-hg20060929-capture/alsa-kernel/pci/ice1712/revo.h alsa=
-driver-hg20060929/alsa-kernel/pci/ice1712/revo.h
--- alsa-driver-hg20060929-capture/alsa-kernel/pci/ice1712/revo.h	2006-08-2=
8 18:20:18.000000000 +0100
+++ alsa-driver-hg20060929/alsa-kernel/pci/ice1712/revo.h	2006-09-30 23:37:=
36.606540856 +0100
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
diff -ur alsa-driver-hg20060929-capture/config.log alsa-driver-hg20060929/c=
onfig.log
--- alsa-driver-hg20060929-capture/config.log	2006-09-30 17:39:21.327436000=
 +0100
+++ alsa-driver-hg20060929/config.log	2006-10-01 00:51:24.050177654 +0100
@@ -4,7 +4,7 @@
 It was created by configure, which was
 generated by GNU Autoconf 2.60.  Invocation command line was
=20
-  $ ./configure --with-isapnp=3Dno --with-kernel=3D/usr/src/linux/ --with-=
cards=3Dice1724,via82xx,usb-audio
+  $ ./configure --with-isapnp=3Dno --with-kernel=3D/usr/src/linux/ --with-=
cards=3Dice1724,via82xx,usb-audio,ice1712
=20
 ## --------- ##
 ## Platform. ##
@@ -1454,7 +1454,7 @@
 configure:12075: $? =3D 0
 configure:12077: result: yes
 configure:12100: checking for which soundcards to compile driver for
-configure:14007: result: ice1724 via82xx usb-audio
+configure:14007: result: ice1724 via82xx usb-audio ice1712
 configure:15336: creating ./config.status
=20
 ## ---------------------- ##
@@ -1483,9 +1483,13 @@
 config.status:843: creating utils/alsasound.posix
 config.status:843: creating include/pci_ids_compat.h
 config.status:843: creating include/config.h
+config.status:1119: include/config.h is unchanged
 config.status:843: creating include/config1.h
+config.status:1119: include/config1.h is unchanged
 config.status:843: creating include/version.h
+config.status:1119: include/version.h is unchanged
 config.status:843: creating include/autoconf-extra.h
+config.status:1119: include/autoconf-extra.h is unchanged
=20
 ## ---------------- ##
 ## Cache variables. ##
@@ -1645,7 +1649,7 @@
 CONFIG_SND_HDSPM=3D''
 CONFIG_SND_HPET=3D''
 CONFIG_SND_HWDEP=3D'm'
-CONFIG_SND_ICE1712=3D''
+CONFIG_SND_ICE1712=3D'm'
 CONFIG_SND_ICE1724=3D'm'
 CONFIG_SND_INDIGO=3D''
 CONFIG_SND_INDIGODJ=3D''
@@ -1885,6 +1889,7 @@
 #define CONFIG_SND_AC97_CODEC_MODULE 1
 #define CONFIG_SND_AC97_BUS_MODULE 1
 #define CONFIG_PARPORT_MODULE 1
+#define CONFIG_SND_ICE1712_MODULE 1
 #define CONFIG_SND_ICE1724_MODULE 1
 #define CONFIG_SND_VIA82XX_MODULE 1
 #define CONFIG_SND_AC97_POWER_SAVE 1
diff -ur alsa-driver-hg20060929-capture/config.status alsa-driver-hg2006092=
9/config.status
--- alsa-driver-hg20060929-capture/sound/pci/ice1712/ice1712.h	2006-08-28 1=
8:20:18.000000000 +0100
+++ alsa-driver-hg20060929/sound/pci/ice1712/ice1712.h	2006-10-01 00:30:50.=
497493601 +0100
@@ -462,7 +462,15 @@
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
--- alsa-driver-hg20060929-capture/utils/insert	2006-08-28 18:19:31.0000000=
00 +0100
+++ alsa-driver-hg20060929/utils/insert	2006-10-01 00:51:09.985309288 +0100
@@ -392,7 +392,7 @@
     basic
     ac97
     insert snd-mpu401-uart$SUFF=20
-    #insert snd-i2c$SUFF
+    insert snd-i2c$SUFF
     #insert snd-cs8427$SUFF
     insert snd-ak4114$SUFF
     insert snd-ak4xxx-adda$SUFF

--=20
http://seehuhn.de/

--3MwIy2ne0vdjdPXF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFHzISf+iD8yEbECURAj/cAKCeTtm+32TR3CSiiucw1Z71n2r9kgCfTVJ2
geqP67qMdgd3XtNbk3QoumA=
=tAKp
-----END PGP SIGNATURE-----

--3MwIy2ne0vdjdPXF--


--===============0556194742==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0556194742==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0556194742==--
