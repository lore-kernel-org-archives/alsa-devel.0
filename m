From: Maximilian Rehkopf <otakon@gmx.net>
Subject: [PATCH] ice1724: Add input switch for Aux-in on Aureon Universe
Date: Thu, 30 Mar 2006 02:58:22 +0200
Message-ID: <442B2D2E.3030009@gmx.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040105030704060804080803"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------040105030704060804080803
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

Terratec Aureon 7.1 Universe cards (and maybe others?) allow the user to
switch the Aux input of the STAC9744 between three different sources
(on-board Aux jack, Wavetable from the front panel, Rear Line-In).
The diff adds a mixer control to switch between the three inputs.

For switching, a PCA9554 (8-line GPIO with I=B2C interface) and a 74HC405=
2
(dual 4-way mux/demux) are used.  Output 0 and 1 of the PCA9554 are
connected to the select pins of the 74HC4052. The I=B2C interface of the
PCA9554 is connected to the card's internal SPI bus which is also used
to control the WM8770 and CS8415.

For additional notes see the diff.
Diff created against CVS source from two days ago.

Note: there are also lines connected to output 2 and 3 of the PCA9554,
which I believe control the on/off state of the "Line In" LED on the
front panel and the selection between Coaxial and Optical S/PDIF on the
front panel.

It's my first attempt at a half decent driver hack, I hope it doesn't
break too much...

Cheers,

--=20
Maximilian Rehkopf

--------------040105030704060804080803
Content-Type: text/plain;
 name="aureon-inmux.diff"
Content-Disposition: inline;
 filename="aureon-inmux.diff"
Content-Transfer-Encoding: quoted-printable

Summary: Add Aux input switch control for Aureon Universe

This patch adds a mixer control which allows the user to switch the Aux
playback between the internal Aux jack, Wavetable, and Rear Line-In on
Aureon Universe cards.

For switching, a PCA9554 (8-line GPIO with I=C2=B2C interface) and a 74HC=
4052
(dual 4-way mux/demux) are used.  Output 0 and 1 of the PCA9554 are
connected to the select pins of the 74HC4052. The I=C2=B2C interface of t=
he
PCA9554 is connected to the card's internal SPI bus which is also used=20
to control the WM8770 and CS8415. SPI and I=C2=B2C on the same lines...

To communicate with the PCA9554 the WM8770 and CS8415 are disabled and
an I=C2=B2C Stop Condition is generated before the Start Condition (neede=
d
for synchronisation because other SPI traffic appear to confuse the
PCA9554). Then a normal I=C2=B2C data transfer takes place.  Programming =
must
be done ridiculously slow; in theory, 4.7=C2=B5s is the minimum delay tim=
e=20
for normal-speed I=C2=B2C according to the datasheet, but even with 10=C2=
=B5s=20
switching was unreliable.  The Windows driver from Terratec does the=20
programming very slowly, too (checked with an oscilloscope).

PCA9554 datasheet:
http://www.semiconductors.philips.com/acrobat/datasheets/PCA9554_9554A_6.=
pdf

74HC4052 datasheet:
http://www.semiconductors.philips.com/acrobat/datasheets/74HC_HCT4052_4.p=
df

Signed-off-by: Maximilian Rehkopf <otakon@gmx.net>

--- alsa-kernel.vanilla/pci/ice1712/aureon.c	2006-03-20 19:31:57.00000000=
0 +0100
+++ alsa-kernel.pca9554/pci/ice1712/aureon.c	2006-03-30 02:44:24.00000000=
0 +0200
@@ -87,6 +87,150 @@
 #define CS8415_C_BUFFER	0x20
 #define CS8415_ID		0x7F
=20
+/* PCA9554 registers */
+#define PCA9554_DEV     0x40            /* I2C device address */
+#define PCA9554_IN      0x00            /* input port */
+#define PCA9554_OUT     0x01            /* output port */
+#define PCA9554_INVERT  0x02            /* input invert */
+#define PCA9554_DIR     0x03            /* port directions */
+
+/*
+ * Aureon Universe additional controls using PCA9554
+ */
+
+/*
+ * Send data to pca9554
+ */
+static void aureon_pca9554_write(struct snd_ice1712 *ice, unsigned char =
reg, unsigned char data)
+{
+        unsigned int tmp;
+        int i, j;
+        unsigned char dev=3DPCA9554_DEV;  /* ID 0100000, write */
+        unsigned char val=3D0;
+
+        tmp =3D snd_ice1712_gpio_read(ice);
+
+        snd_ice1712_gpio_set_mask(ice, ~(AUREON_SPI_MOSI|AUREON_SPI_CLK|
+                                         AUREON_WM_RW|AUREON_WM_CS|
+                                         AUREON_CS8415_CS));
+        tmp |=3D AUREON_WM_RW;
+        tmp |=3D AUREON_CS8415_CS | AUREON_WM_CS; /* disable SPI devices=
 */
+
+        tmp &=3D ~AUREON_SPI_MOSI;
+        tmp &=3D ~AUREON_SPI_CLK;
+        snd_ice1712_gpio_write(ice, tmp);
+        udelay(50);
+
+/*=20
+ * send i2c stop condition and start condition
+ * to obtain sane state
+ */
+        tmp |=3D AUREON_SPI_CLK;
+        snd_ice1712_gpio_write(ice, tmp);
+        udelay(50);
+        tmp |=3D AUREON_SPI_MOSI;
+        snd_ice1712_gpio_write(ice, tmp);
+        udelay(100);
+        tmp &=3D ~AUREON_SPI_MOSI;
+        snd_ice1712_gpio_write(ice, tmp);
+        udelay(50);
+        tmp &=3D ~AUREON_SPI_CLK;
+        snd_ice1712_gpio_write(ice, tmp);
+        udelay(100);
+/*
+ * send device address, command and value,
+ * skipping ack cycles inbetween
+ */
+        for(j =3D 0; j < 3; j++) {
+                switch(j) {
+                        case 0: val=3Ddev; break;
+                        case 1: val=3Dreg; break;
+                        case 2: val=3Ddata; break;
+                }
+                for (i =3D 7; i >=3D 0; i--) {
+                        tmp &=3D ~AUREON_SPI_CLK;
+                        snd_ice1712_gpio_write(ice, tmp);
+                        udelay(40);
+                        if (val & (1 << i))
+                                tmp |=3D AUREON_SPI_MOSI;
+                        else
+                                tmp &=3D ~AUREON_SPI_MOSI;
+                        snd_ice1712_gpio_write(ice, tmp);
+                        udelay(40);
+                        tmp |=3D AUREON_SPI_CLK;
+                        snd_ice1712_gpio_write(ice, tmp);
+                        udelay(40);
+                }
+
+                tmp &=3D ~AUREON_SPI_CLK;
+                snd_ice1712_gpio_write(ice, tmp);
+                udelay(40);
+                tmp |=3D AUREON_SPI_CLK;
+                snd_ice1712_gpio_write(ice, tmp);
+                udelay(40);
+                tmp &=3D ~AUREON_SPI_CLK;
+                snd_ice1712_gpio_write(ice, tmp);
+                udelay(40);
+        }
+        tmp &=3D ~AUREON_SPI_CLK;
+        snd_ice1712_gpio_write(ice, tmp);
+        udelay(40);
+        tmp &=3D ~AUREON_SPI_MOSI;
+        snd_ice1712_gpio_write(ice, tmp);
+        udelay(40);
+        tmp |=3D AUREON_SPI_CLK;
+        snd_ice1712_gpio_write(ice, tmp);
+        udelay(50);
+        tmp |=3D AUREON_SPI_MOSI;
+        snd_ice1712_gpio_write(ice, tmp);
+        udelay(100);
+}
+
+static int aureon_universe_inmux_info(snd_kcontrol_t *kcontrol, snd_ctl_=
elem_info_t *uinfo)
+{
+
+        char* texts[3]=3D{"Internal Aux", "Wavetable", "Rear Line-In"};
+
+        uinfo->type =3D SNDRV_CTL_ELEM_TYPE_ENUMERATED;
+        uinfo->count =3D 1;
+        uinfo->value.enumerated.items =3D 3;
+        if(uinfo->value.enumerated.item >=3D uinfo->value.enumerated.ite=
ms) {
+                uinfo->value.enumerated.item =3D uinfo->value.enumerated=
.items - 1;
+        }
+        strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerat=
ed.item]);
+        return 0;
+}
+
+static int aureon_universe_inmux_get(snd_kcontrol_t *kcontrol, snd_ctl_e=
lem_value_t *ucontrol) {
+        struct snd_ice1712 *ice =3D snd_kcontrol_chip(kcontrol);
+        unsigned char val;
+
+        val=3Dice->spec.aureon.pca9554_out;
+
+        ucontrol->value.integer.value[0]=3Dval;
+        return 0;
+}
+
+static int aureon_universe_inmux_put(snd_kcontrol_t *kcontrol, snd_ctl_e=
lem_value_t *ucontrol) {
+        struct snd_ice1712 *ice =3D snd_kcontrol_chip(kcontrol);
+        unsigned char oval, nval;
+        int change;
+
+        snd_ice1712_save_gpio_status(ice);
+=09
+        oval=3Dice->spec.aureon.pca9554_out;
+        nval=3Ducontrol->value.integer.value[0];
+        if((change =3D (oval!=3Dnval))) {
+                aureon_pca9554_write(ice, PCA9554_OUT, nval);
+        }
+        ice->spec.aureon.pca9554_out=3Dnval;
+
+        snd_ice1712_restore_gpio_status(ice);
+=09
+        return change;
+}
+
+
 static void aureon_ac97_write(struct snd_ice1712 *ice, unsigned short re=
g, unsigned short val) {
 	unsigned int tmp;
=20
@@ -1598,7 +1742,15 @@
  		.get =3D aureon_ac97_vol_get,
  		.put =3D aureon_ac97_vol_put,
  		.private_value =3D AC97_VIDEO|AUREON_AC97_STEREO
- 	}
+ 	},
+        {
+                .iface =3D SNDRV_CTL_ELEM_IFACE_MIXER,
+                .name =3D "Aux Source",
+                .info =3D aureon_universe_inmux_info,
+                .get =3D aureon_universe_inmux_get,
+                .put =3D aureon_universe_inmux_put
+        }
+
 };
=20
 =09
@@ -1856,6 +2008,10 @@
 	}
=20
 	snd_ice1712_restore_gpio_status(ice);
+
+        /* initialize PCA9554 pin directions & set default input*/
+        aureon_pca9554_write(ice, PCA9554_DIR, 0x00);
+        aureon_pca9554_write(ice, PCA9554_OUT, 0x00);   // internal AUX
 =09
 	ice->spec.aureon.master[0] =3D WM_VOL_MUTE;
 	ice->spec.aureon.master[1] =3D WM_VOL_MUTE;
--- alsa-kernel.vanilla/pci/ice1712/ice1712.h	2006-02-08 08:40:33.0000000=
00 +0100
+++ alsa-kernel.pca9554/pci/ice1712/ice1712.h	2006-03-28 11:15:53.0000000=
00 +0200
@@ -373,6 +373,7 @@
 			unsigned int cs8415_mux;
 			unsigned short master[2];
 			unsigned short vol[8];
+			unsigned char pca9554_out;
 		} aureon;
 		/* AC97 register cache for Phase28 */
 		struct phase28_spec {

--------------040105030704060804080803--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
