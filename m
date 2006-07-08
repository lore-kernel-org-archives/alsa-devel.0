From: Rene Rebe <rene@exactcode.de>
Subject: ALSA Intel HDA MacBook
Date: Sat, 8 Jul 2006 21:20:02 +0200
Message-ID: <200607082120.02137.rene@exactcode.de>
References: <200607081323.17265.rene@exactcode.de>
	<200607081354.33539.rene@exactcode.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <200607081354.33539.rene@exactcode.de>
Content-Disposition: inline
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
Cc: Matt Porter <mporter@embeddedalley.com>, Nicolas Boichat <nicolas@boichat.ch>
List-Id: alsa-devel@alsa-project.org

Hi all,

I try to figure out how to finalize the Intel HDA driver for MacBook
(not Pro, the normal MacBook). Currently I use this patch on top of
e.g. Linux-2.6.17.x (continue to read below for the problem desc.):

--- ./sound/pci/hda/patch_sigmatel.c.orig	2006-07-08 12:09:09.000000000 +02=
00
+++ ./sound/pci/hda/patch_sigmatel.c	2006-07-08 12:09:17.000000000 +0200
@@ -41,6 +41,7 @@
 #define STAC_REF		0
 #define STAC_D945GTP3		1
 #define STAC_D945GTP5		2
+#define STAC_APPLE		3 /* Apple MacBook, MacBook Pro, Mac Mini */
 =

 struct sigmatel_spec {
 	struct snd_kcontrol_new *mixers[4];
@@ -52,6 +53,7 @@
 	unsigned int mic_switch: 1;
 	unsigned int alt_switch: 1;
 	unsigned int hp_detect: 1;
+	unsigned int gpio_mute: 1;
 =

 	/* playback */
 	struct hda_multi_out multiout;
@@ -289,10 +291,17 @@
 	0x02a19320, 0x40000100,
 };
 =

+static unsigned int apple_pin_configs[10] =3D {
+	0x0121E230, 0x90A70120, 0x9017E110, 0x400000FE,
+	0x400000FD, 0x0181E021, 0x1145E040, 0x400000FA,
+	0x400000FC, 0x400000FB,
+};
+
 static unsigned int *stac922x_brd_tbl[] =3D {
 	ref922x_pin_configs,
 	d945gtp3_pin_configs,
 	d945gtp5_pin_configs,
+	apple_pin_configs,
 };
 =

 static struct hda_board_config stac922x_cfg_tbl[] =3D {
@@ -324,6 +333,9 @@
 	{ .pci_subvendor =3D PCI_VENDOR_ID_INTEL,
 	  .pci_subdevice =3D 0x0417,
 	  .config =3D STAC_D945GTP5 },	/* Intel D975XBK - 5 Stack */
+	{ .pci_subvendor =3D 0x8384,
+	  .pci_subdevice =3D 0x7680,
+	  .config =3D STAC_APPLE },       /* Apple Mac Mini (early 2006) / MacBoo=
k Pro =

*/
 	{} /* terminator */
 };
 =

@@ -841,6 +853,19 @@
 		}
 	}
 =

+      if (imux->num_items =3D=3D 1) {
+              /*
+               * Set the current input for the muxes.
+               * The STAC9221 has two input muxes with identical source
+               * NID lists.  Hopefully this won't get confused.
+               */
+              for (i =3D 0; i < spec->num_muxes; i++) {
+                      snd_hda_codec_write(codec, spec->mux_nids[i], 0,
+                                          AC_VERB_SET_CONNECT_SEL,
+                                          imux->items[0].index);
+              }
+      }
+
 	return 0;
 }
 =

@@ -946,6 +971,45 @@
 	return 1;
 }
 =

+/*
+ * Early 2006 Intel Macintoshes with STAC9220X5 codecs seem to have a
+ * funky external mute control using GPIO pins.
+ */
+
+static void stac922x_gpio_mute(struct hda_codec *codec, int pin, int muted)
+{
+      unsigned int gpiostate, gpiomask, gpiodir;
+
+      gpiostate =3D snd_hda_codec_read(codec, codec->afg, 0,
+                                     AC_VERB_GET_GPIO_DATA, 0);
+
+      if (!muted)
+              gpiostate |=3D (1 << pin);
+      else
+              gpiostate &=3D ~(1 << pin);
+
+      gpiomask =3D snd_hda_codec_read(codec, codec->afg, 0,
+                                    AC_VERB_GET_GPIO_MASK, 0);
+      gpiomask |=3D (1 << pin);
+
+      gpiodir =3D snd_hda_codec_read(codec, codec->afg, 0,
+                                   AC_VERB_GET_GPIO_DIRECTION, 0);
+      gpiodir |=3D (1 << pin);
+
+      /* AppleHDA seems to do this -- WTF is this verb?? */
+      snd_hda_codec_write(codec, codec->afg, 0, 0x7e7, 0);
+
+      snd_hda_codec_write(codec, codec->afg, 0,
+                          AC_VERB_SET_GPIO_MASK, gpiomask);
+      snd_hda_codec_write(codec, codec->afg, 0,
+                          AC_VERB_SET_GPIO_DIRECTION, gpiodir);
+
+      msleep(1);
+
+      snd_hda_codec_write(codec, codec->afg, 0,
+                          AC_VERB_SET_GPIO_DATA, gpiostate);
+}
+
 static int stac92xx_init(struct hda_codec *codec)
 {
 	struct sigmatel_spec *spec =3D codec->spec;
@@ -982,6 +1046,11 @@
 		stac92xx_auto_set_pinctl(codec, cfg->dig_in_pin,
 					 AC_PINCTL_IN_EN);
 =

+      if (spec->gpio_mute) {
+              stac922x_gpio_mute(codec, 0, 0);
+              stac922x_gpio_mute(codec, 1, 0);
+      }
+
 	return 0;
 }
 =

@@ -1154,6 +1223,9 @@
 		return err;
 	}
 =

+	if (spec->board_config =3D=3D STAC_APPLE)
+	    spec->gpio_mute =3D 1;
+
 	codec->patch_ops =3D stac92xx_patch_ops;
 =

 	return 0;

The patch might work on the MacBook Pro, I have none - how-
ever the MacBook has three speakers, a left and right one and
one under the keyboard for the bass and mids. However this
third speaker is only driver when the headphone right channel
is unmuted and consequently continous to play the sound
when the headphone is plugged in and the speakers are suppost
to be muted. Only the left and right channel is muted in that
case - this "below the keyboard" bass speaker still emmits
the audio and it's volume is controlled by the right headphone
channel (???).

Since I have no spec for the Intel HDA or Sigmatel chip
(the SigmaTel STAC9221 A1) I feel a bit lost.

Maybe someone has an idea how to route this properly?

Thanks in advance,

-- =

Ren=E9 Rebe - Rubensstr. 64 - 12157 Berlin (Europe / Germany)
            http://exactcode.de | http://t2-project.org | http://rebe.name
            +49 (0)30 / 255 897 45


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easi=
er
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D1=
21642
