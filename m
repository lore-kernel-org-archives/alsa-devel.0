From: Sergey Vlasov <vsu@altlinux.ru>
Subject: [PATCH] snd-via82xx: Support all sample rate conversion capabilities of DXS channels
Date: Sun, 10 Apr 2005 19:53:20 +0400
Message-ID: <20050410155320.GA2101@procyon.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5vNYLRcllDrimb99"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello!

The current snd-via82xx driver does not use all capabilities of the
DXS channels present in VIA VT8233/5/7 chips.  In particular:

- The driver only accepts sample rates which are supported by the
  AC'97 codec; however, the controller is able to perform sample rate
  conversion itself, therefore the codec limits do not apply (and even
  non-standard rates can be used).

- The driver forces sample rates for all 4 DXS subdevices to be the
  same; however, the controller has separate sample rate converters
  for each channel.

This patch adds support for these capabilities of the VT823x
controller to the snd-via82xx driver.  I have tested it with the ASUS
A8V Deluxe board (VT8237 southbridge, Realtek ALC850 codec), with
simultaneous output with different sample rates (48000, 44100, 8000,
and some non-standard values like 44444, 12345, etc...).  The SPDIF
output also seems to work (tested with the Sony MZ-N1 portable
minidisc recorder).

To avoid breaking support of some other hardware which may not like
this mode, the full DXS support is enabled only for known devices (the
patch adds an entry for ASUS A8V Deluxe), or when the dxs_support=3D5
option is used.

When using dxs_support=3D5, the AC'97 sample rate is locked at 48000 Hz,
and the controller performs sample rate conversion for each DXS
channel.  Therefore output with any sample rate between 8000 and 48000
Hz is possible even if the codec supports only 48000 Hz (like ALC850,
which does not support VRA).  SPDIF rate is also locked to 48000 Hz.

The patch was made for ALSA CVS version from yesterday.

Best regards,
	Sergey Vlasov


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Add support for full sample rate conversion capabilities of DXS
channels present in VIA VT8233/5/7 controllers:

- any sample rate in the 8000 ... 48000 Hz range is supported even if
  the AC'97 codec supports only 48000 Hz output;

- different DXS channels can use different sample rates at the same
  time (the controller performs required sample rate conversion and
  mixing in hardware).

Signed-off-by: Sergey Vlasov <vsu@altlinux.ru>

--- alsa-driver-1.0.9rc2-cvs/alsa-kernel/pci/via82xx.c.dxs-src	2005-04-10 1=
7:10:56 +0400
+++ alsa-driver-1.0.9rc2-cvs/alsa-kernel/pci/via82xx.c	2005-04-10 17:35:28 =
+0400
@@ -101,7 +101,7 @@ MODULE_PARM_DESC(ac97_clock, "AC'97 code
 module_param_array(ac97_quirk, charp, NULL, 0444);
 MODULE_PARM_DESC(ac97_quirk, "AC'97 workaround for strange hardware.");
 module_param_array(dxs_support, int, NULL, 0444);
-MODULE_PARM_DESC(dxs_support, "Support for DXS channels (0 =3D auto, 1 =3D=
 enable, 2 =3D disable, 3 =3D 48k only, 4 =3D no VRA)");
+MODULE_PARM_DESC(dxs_support, "Support for DXS channels (0 =3D auto, 1 =3D=
 enable, 2 =3D disable, 3 =3D 48k only, 4 =3D no VRA, 5 =3D enable any samp=
le rate)");
=20
=20
 /* pci ids */
@@ -302,6 +302,7 @@ DEFINE_VIA_REGSET(CAPTURE_8233, 0x60);
 #define VIA_DXS_DISABLE	2
 #define VIA_DXS_48K	3
 #define VIA_DXS_NO_VRA	4
+#define VIA_DXS_SRC	5
=20
=20
 /*
@@ -380,6 +381,7 @@ struct _snd_via82xx {
 	struct via_rate_lock rates[2]; /* playback and capture */
 	unsigned int dxs_fixed: 1;	/* DXS channel accepts only 48kHz */
 	unsigned int no_vra: 1;		/* no need to set VRA on DXS channels */
+	unsigned int dxs_src: 1;	/* use full SRC capabilities of DXS */
 	unsigned int spdif_on: 1;	/* only spdif rates work to external DACs */
=20
 	snd_pcm_t *pcms[2];
@@ -924,15 +926,16 @@ static int snd_via8233_playback_prepare(
 	via82xx_t *chip =3D snd_pcm_substream_chip(substream);
 	viadev_t *viadev =3D (viadev_t *)substream->runtime->private_data;
 	snd_pcm_runtime_t *runtime =3D substream->runtime;
+	int ac97_rate =3D chip->dxs_src ? 48000 : runtime->rate;
 	int rate_changed;
 	u32 rbits;
=20
-	if ((rate_changed =3D via_lock_rate(&chip->rates[0], runtime->rate)) < 0)
+	if ((rate_changed =3D via_lock_rate(&chip->rates[0], ac97_rate)) < 0)
 		return rate_changed;
 	if (rate_changed) {
 		snd_ac97_set_rate(chip->ac97, AC97_PCM_FRONT_DAC_RATE,
 				  chip->no_vra ? 48000 : runtime->rate);
-		snd_ac97_set_rate(chip->ac97, AC97_SPDIF, runtime->rate);
+		snd_ac97_set_rate(chip->ac97, AC97_SPDIF, ac97_rate);
 	}
 	if (runtime->rate =3D=3D 48000)
 		rbits =3D 0xfffff;
@@ -1074,6 +1077,12 @@ static int snd_via82xx_pcm_open(via82xx_
 		/* fixed DXS playback rate */
 		runtime->hw.rates =3D SNDRV_PCM_RATE_48000;
 		runtime->hw.rate_min =3D runtime->hw.rate_max =3D 48000;
+	} else if (chip->dxs_src && viadev->reg_offset < 0x40) {
+		/* use full SRC capabilities of DXS */
+		runtime->hw.rates =3D (SNDRV_PCM_RATE_CONTINUOUS |
+				     SNDRV_PCM_RATE_8000_48000);
+		runtime->hw.rate_min =3D 8000;
+		runtime->hw.rate_max =3D 48000;
 	} else if (! ratep->rate) {
 		int idx =3D viadev->direction ? AC97_RATES_ADC : AC97_RATES_FRONT_DAC;
 		runtime->hw.rates =3D chip->ac97->rates[idx];
@@ -2149,6 +2158,7 @@ static int __devinit check_dxs_list(stru
 		{ .vendor =3D 0x1043, .device =3D 0x8095, .action =3D VIA_DXS_NO_VRA }, =
/* ASUS A7V8X (FIXME: possibly VIA_DXS_ENABLE?)*/
 		{ .vendor =3D 0x1043, .device =3D 0x80a1, .action =3D VIA_DXS_NO_VRA }, =
/* ASUS A7V8-X */
 		{ .vendor =3D 0x1043, .device =3D 0x80b0, .action =3D VIA_DXS_NO_VRA }, =
/* ASUS A7V600 & K8V*/=20
+		{ .vendor =3D 0x1043, .device =3D 0x812a, .action =3D VIA_DXS_SRC    }, =
/* ASUS A8V Deluxe */=20
 		{ .vendor =3D 0x1071, .device =3D 0x8375, .action =3D VIA_DXS_NO_VRA }, =
/* Vobis/Yakumo/Mitac notebook */
 		{ .vendor =3D 0x10cf, .device =3D 0x118e, .action =3D VIA_DXS_ENABLE }, =
/* FSC laptop */
 		{ .vendor =3D 0x1106, .device =3D 0x4161, .action =3D VIA_DXS_NO_VRA }, =
/* ASRock K7VT2 */
@@ -2288,6 +2298,10 @@ static int __devinit snd_via82xx_probe(s
 				chip->dxs_fixed =3D 1;
 			else if (dxs_support[dev] =3D=3D VIA_DXS_NO_VRA)
 				chip->no_vra =3D 1;
+			else if (dxs_support[dev] =3D=3D VIA_DXS_SRC) {
+				chip->no_vra =3D 1;
+				chip->dxs_src =3D 1;
+			}
 		}
 		if ((err =3D snd_via8233_init_misc(chip, dev)) < 0)
 			goto __error;
--- alsa-driver-1.0.9rc2-cvs/alsa-kernel/Documentation/ALSA-Configuration.t=
xt.dxs-src	2005-04-09 16:56:58 +0400
+++ alsa-driver-1.0.9rc2-cvs/alsa-kernel/Documentation/ALSA-Configuration.t=
xt	2005-04-10 17:29:12 +0400
@@ -1211,16 +1211,18 @@ Prior to version 0.9.0rc4 options had a=20
   ------------------
=20
     Module for AC'97 motherboards based on VIA 82C686A/686B, 8233,
-    8233A, 8233C, 8235 (south) bridge.
+    8233A, 8233C, 8235, 8237 (south) bridge.
=20
     mpu_port	- 0x300,0x310,0x320,0x330, otherwise obtain BIOS setup
 		  [VIA686A/686B only]
     joystick	- Enable joystick (default off) [VIA686A/686B only]
     ac97_clock	- AC'97 codec clock base (default 48000Hz)
     dxs_support	- support DXS channels,
-		  0 =3D auto (defalut), 1 =3D enable, 2 =3D disable,
-		  3 =3D 48k only, 4 =3D no VRA
-		  [VIA8233/C,8235 only]
+		  0 =3D auto (default), 1 =3D enable, 2 =3D disable,
+		  3 =3D 48k only, 4 =3D no VRA, 5 =3D enable any sample
+		  rate and different sample rates on different
+		  channels
+		  [VIA8233/C, 8235, 8237 only]
     ac97_quirk  - AC'97 workaround for strange hardware
                   See the description of intel8x0 module for details.
=20
@@ -1232,18 +1234,21 @@ Prior to version 0.9.0rc4 options had a=20
           default value 1.4.  Then the interrupt number will be
           assigned under 15. You might also upgrade your BIOS.
    =20
-    Note: VIA8233/5 (not VIA8233A) can support DXS (direct sound)
+    Note: VIA8233/5/7 (not VIA8233A) can support DXS (direct sound)
 	  channels as the first PCM.  On these channels, up to 4
-	  streams can be played at the same time.
+	  streams can be played at the same time, and the controller
+	  can perform sample rate conversion with separate rates for
+	  each channel.
 	  As default (dxs_support =3D 0), 48k fixed rate is chosen
 	  except for the known devices since the output is often
 	  noisy except for 48k on some mother boards due to the
 	  bug of BIOS.
-	  Please try once dxs_support=3D1 and if it works on other
+	  Please try once dxs_support=3D5 and if it works on other
 	  sample rates (e.g. 44.1kHz of mp3 playback), please let us
 	  know the PCI subsystem vendor/device id's (output of
 	  "lspci -nv").
-	  If it doesn't work, try dxs_support=3D4.  If it still doesn't
+	  If dxs_support=3D5 does not work, try dxs_support=3D1; if it
+	  doesn't work too, try dxs_support=3D4.  If it still doesn't
 	  work and the default setting is ok, dxs_support=3D3 is the
 	  right choice.  If the default setting doesn't work at all,
 	  try dxs_support=3D2 to disable the DXS channels.

--5vNYLRcllDrimb99
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCWUvwW82GfkQfsqIRAjXaAJ97MF4SUM+hZt/eXqYdXJuJpGI4HACcCagP
IV4fzUliNXQEzkAGtrJtfGk=
=+oi3
-----END PGP SIGNATURE-----

--5vNYLRcllDrimb99--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
