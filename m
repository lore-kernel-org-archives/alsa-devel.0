From: karsten wiese <annabellesgarden@yahoo.de>
Subject: [PATCH] reenable MIDI for usx2y
Date: Sun, 27 Mar 2005 14:00:12 +0200 (CEST)
Message-ID: <20050327120012.26503.qmail@web26510.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-129010921-1111924812=:25813"
Content-Transfer-Encoding: 7bit
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Devel Alsa <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

--0-129010921-1111924812=:25813
Content-Type: text/plain; charset=iso-8859-1
Content-Id: 
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Clemens,

usx2y needs to specify exactly what usb-endpoints to use.
this feature got lost lately and is restored by attached
patch. Please apply!

rgds,
Karsten

Canonical Patch:
------------------------------------------------------
Don't detect MIDI usb-endpoint, if quirk specifies it

If for QUIRK_MIDI_FIXED_ENDPOINT a struct
snd_usb_midi_endpoint_info's
members out_ep or in_ep are !=3D 0,
they shall be treated as exactly what usb-endpoints to use.
This rule was lost due to a recent change in usbmidi.c
and is reestablished by attached patch.

signed-of-by: Karsten Wiese <annabellesgarden@yahoo.de>


=09

=09
	=09
___________________________________________________________=20
Gesendet von Yahoo! Mail - Jetzt mit 250MB Speicher kostenlos - Hier anme=
lden: http://mail.yahoo.de
--0-129010921-1111924812=:25813
Content-Type: text/x-diff; name="usbmidi.c.patch"
Content-Description: usbmidi.c.patch
Content-Disposition: inline; filename="usbmidi.c.patch"

Index: usbmidi.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/usb/usbmidi.c,v
retrieving revision 1.45
diff -U3 -r1.45 usbmidi.c
--- usbmidi.c	24 Mar 2005 07:17:17 -0000	1.45
+++ usbmidi.c	25 Mar 2005 13:46:50 -0000
@@ -1492,7 +1492,8 @@
 		case QUIRK_MIDI_FIXED_ENDPOINT:
 			memcpy(&endpoints[0], quirk->data,
 			       sizeof(snd_usb_midi_endpoint_info_t));
-			err = snd_usbmidi_detect_endpoints(umidi, &endpoints[0], 1);
+			err = (endpoints[0].in_ep || endpoints[0].out_ep) ? 0 :
+				snd_usbmidi_detect_endpoints(umidi, &endpoints[0], 1);
 			break;
 		case QUIRK_MIDI_YAMAHA:
 			err = snd_usbmidi_detect_yamaha(umidi, &endpoints[0]);

--0-129010921-1111924812=:25813--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
