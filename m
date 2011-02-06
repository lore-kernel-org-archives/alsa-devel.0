From: Joseph Teichman <josteich@gmail.com>
Subject: [PATCH] Enable E-mu 0204
Date: Sat, 5 Feb 2011 23:13:06 -0500
Message-ID: <AANLkTinJJBA5REceETdLt-bJHPkUgXQQ3fdZa98rS4zZ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, patch@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a trivial patch to enable the E-mu 0204, which is the newest
device in the series 0202USB, 0404USB and Tracker Pre.

Signed-off-by: Joseph Teichman <josteich at gmail.com>

--- alsa-kmirror/usb/mixer.c 2011-01-27 07:09:20.000000000 -0500
+++ alsa-kmirror-jt/usb/mixer.c 2011-02-05 20:42:00.000000000 -0500
@@ -1566,7 +1566,7 @@
cval->initialized =3D 1;
} else {
if (type =3D=3D USB_XU_CLOCK_RATE) {
- /* E-Mu USB 0404/0202/TrackerPre
+ /* E-Mu USB 0404/0202/TrackerPre/0204
* samplerate control quirk
*/
cval->min =3D 0;
diff -u ./quirks.c /home/joe/alsa-driver-1.0.24-jt/sound/usb/quirks.c
--- ./quirks.c 2011-01-27 07:09:20.000000000 -0500
+++ /home/joe/alsa-driver-1.0.24-jt/sound/usb/quirks.c 2011-02-05
20:40:28.000000000 -0500
@@ -532,7 +532,7 @@
}

/*
- * For E-Mu 0404USB/0202USB/TrackerPre sample rate should be set for devic=
e,
+ * For E-Mu 0404USB/0202USB/TrackerPre/0204USB sample rate should be
set for device,
=A0* not for interface.
=A0*/

@@ -589,6 +589,7 @@
case USB_ID(0x041e, 0x3f02): /* E-Mu 0202 USB */
case USB_ID(0x041e, 0x3f04): /* E-Mu 0404 USB */
case USB_ID(0x041e, 0x3f0a): /* E-Mu Tracker Pre */
+ case USB_ID(0x041e, 0x3f19): /* E-Mu 0204 USB */
set_format_emu_quirk(subs, fmt);
break;
}
diff -u ./quirks-table.h
/home/joe/alsa-driver-1.0.24-jt/sound/usb/quirks-table.h
--- ./quirks-table.h 2011-01-27 07:09:20.000000000 -0500
+++ /home/joe/alsa-driver-1.0.24-jt/sound/usb/quirks-table.h
2011-02-05 20:41:02.000000000 -0500
@@ -79,6 +79,13 @@
.idProduct =3D 0x3f0a,
.bInterfaceClass =3D USB_CLASS_AUDIO,
},
+{
+ /* E-Mu 0204 USB */
+ .match_flags =3D USB_DEVICE_ID_MATCH_DEVICE,
+ .idVendor =3D 0x041e,
+ .idProduct =3D 0x3f19,
+ .bInterfaceClass =3D USB_CLASS_AUDIO,
+},

/*
=A0* Logitech QuickCam: bDeviceClass is vendor-specific, so generic interfa=
ce
