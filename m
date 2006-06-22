From: "Sam Revitch" <sam.revitch@gmail.com>
Subject: usb-audio support for Turtle Beach Roadie
Date: Thu, 22 Jun 2006 03:04:26 -0700
Message-ID: <8d4807d50606220304x4ba05e6apba37950d3e40b85a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_3905_20681677.1150970666704"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

------=_Part_3905_20681677.1150970666704
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

Recently a Turtle Beach Audio Advantage Roadie device ended up in my
possession.  It seems to work with the snd-usb-audio driver, but only
using the headphone jack in 2-channel mode.  The device has a DIN
connector carrying six more channels that are otherwise silent.
C-Media has freely available documentation for the CM106 chip around
which this device is based, and enabling 8-channel output, or
6-channel output with the headphone jack following the front pair is a
matter of setting one of its registers.

Attached is a patch to try to enable 5.1 output mode at probe time.
It seems to work correctly with my device.  There is quite list of
other configurables for this device that might deserve controls.

Thanks,
-Sam Revitch

------=_Part_3905_20681677.1150970666704
Content-Type: text/x-patch; name=cmedia.patch; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-Attachment-Id: f_eoqxosvz
Content-Disposition: attachment; filename="cmedia.patch"

diff -r 08577d0b45ef usb/usbaudio.c
--- a/usb/usbaudio.c=09Tue Jun 13 12:01:14 2006 +0200
+++ b/usb/usbaudio.c=09Thu Jun 22 02:50:36 2006 -0700
@@ -3096,6 +3096,32 @@ static int snd_usb_audigy2nx_boot_quirk(
 }
=20
 /*
+ * C-Media CM106/CM106+ have four 16-bit internal registers that are nicel=
y
+ * documented in the device's data sheet.
+ */
+static int snd_usb_cm106_write_int_reg(struct usb_device *dev, int reg, u1=
6 value)
+{
+=09u8 buf[4];
+=09buf[0] =3D 0x20;
+=09buf[1] =3D value & 0xff;
+=09buf[2] =3D (value >> 8) & 0xff;
+=09buf[3] =3D reg;
+=09return snd_usb_ctl_msg(dev, usb_sndctrlpipe(dev, 0), USB_REQ_SET_CONFIG=
URATION,
+=09=09=09       USB_DIR_OUT | USB_TYPE_CLASS | USB_RECIP_ENDPOINT,
+=09=09=09       0, 0, &buf, 4, 1000);
+}
+
+static int snd_usb_cm106_boot_quirk(struct usb_device *dev)
+{
+=09/*
+=09 * Enable line-out driver mode, set headphone source to front
+=09 * channels, enable stereo mic.
+=09 */
+=09return snd_usb_cm106_write_int_reg(dev, 2, 0x8004);
+}
+
+
+/*
  * Setup quirks
  */
 #define AUDIOPHILE_SET=09=09=090x01 /* if set, parse device_setup */
@@ -3365,6 +3391,12 @@ static void *snd_usb_audio_probe(struct=20
 =09=09=09goto __err_val;
 =09}
=20
+=09/* C-Media CM106 / Turtle Beach Audio Advantage Roadie */
+=09if (id =3D=3D USB_ID(0x10f5, 0x0200)) {
+=09=09if (snd_usb_cm106_boot_quirk(dev) < 0)
+=09=09=09goto __err_val;
+=09}
+
 =09/*
 =09 * found a config.  now register to ALSA
 =09 */







------=_Part_3905_20681677.1150970666704
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
------=_Part_3905_20681677.1150970666704
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

------=_Part_3905_20681677.1150970666704--
