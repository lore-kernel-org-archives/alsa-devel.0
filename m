From: "Thibault LE MEUR" <Thibault.LeMeur@supelec.fr>
Subject: RE : Any missing patches?
Date: Tue, 21 Mar 2006 10:15:33 +0100
Message-ID: <012201c64cc8$05449a30$a578e4a0@supelec.fr>
References: <s5hmzfl9cql.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0123_01C64CD0.67090230"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hmzfl9cql.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: 'Takashi Iwai' <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.

------=_NextPart_000_0123_01C64CD0.67090230
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,

> if someone has patches intended for merging to ALSA tree, 
> please submit them ASAP.

Here is a small and really not urgent patch (but since it is "time to push
Linux kernel tree" :).

Summary: Fixes typos in alsa-kernel/Documentation/Audiophile-USB.txt

Signed-off-by: Thibault LE MEUR <Thibault.LeMeur@supelec.fr>

 

------=_NextPart_000_0123_01C64CD0.67090230
Content-Type: text/plain;
	name="Audiophile-Usb.txt.diff.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="Audiophile-Usb.txt.diff.txt"

--- alsa-kernel/Documentation/Audiophile-Usb.txt	2006-03-21 =
09:49:13.000000000 +0100=0A=
+++ alsa-kernel/Documentation/Audiophile-Usb.txt.new	2006-03-21 =
09:47:55.000000000 +0100=0A=
@@ -1,4 +1,4 @@=0A=
-	Guide to using M-Audio Audiophile USB with ALSA and Jack	v1.1=0A=
+	Guide to using M-Audio Audiophile USB with ALSA and Jack	v1.2=0A=
 	=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=0A=
 =0A=
 	    Thibault Le Meur <Thibault.LeMeur@supelec.fr>=0A=
@@ -13,6 +13,9 @@=0A=
 =0A=
 The device has 4 audio interfaces, and 2 MIDI ports:=0A=
  * Analog Stereo Input (Ai)=0A=
+   - This port supports 2 pairs of line-level audio inputs (1/4" TS and =
RCA) =0A=
+   - When the 1/4" TS (jack) connectors are connected, the RCA =
connectors=0A=
+     are disabled=0A=
  * Analog Stereo Output (Ao)=0A=
  * Digital Stereo Input (Di)=0A=
  * Digital Stereo Output (Do)=0A=
@@ -42,7 +45,7 @@=0A=
 though I haven't tested it under linux=0A=
    - Note that in this setup only the Do interface can be enabled=0A=
  * Apart from recording an audio digital stream, enabling the Di port =
is a way =0A=
-to syncrhonize the device to an external sample clock=0A=
+to synchronize the device to an external sample clock=0A=
    - As a consequence, the Di port must be enable only if an active =
Digital =0A=
 source is connected=0A=
    - Enabling Di when no digital source is connected can result in a =0A=
@@ -180,7 +183,7 @@=0A=
      or changing modprobe.conf)=0A=
    - turn on the device=0A=
 =0A=
-2.2.2.3 - Setting and switching configurations with the device_setup =
parameter=0A=
+2.2.2.3 - Audiophile USB's device_setup structure=0A=
 =0A=
 If you want to understand the device_setup magic numbers for the =
Audiophile =0A=
 USB, you need some very basic understanding of binary computation. =
However, =0A=
@@ -226,7 +229,7 @@=0A=
    - choosing b2 will prepare all interfaces for 24bits/96kHz but you'll=0A=
      only be able to use one at the same time=0A=
 =0A=
-2.2.3 -  Technical Details for Audiophile Usb =0A=
+2.2.3 -  USB implementation details for this device=0A=
 =0A=
 You may safely skip this section if you're not interrested in driver =0A=
 development.=0A=
@@ -234,20 +237,20 @@=0A=
 This section describes some internals aspect of the device and =
summarize the =0A=
 data I got by usb-snooping the windows and linux drivers.=0A=
 =0A=
-The M-Audio Audiophile USB has 7 Usb Interfaces:=0A=
+The M-Audio Audiophile USB has 7 USB Interfaces:=0A=
 a "USB interface":=0A=
- * Usb Interface nb.0=0A=
- * Usb Interface nb.1=0A=
+ * USB Interface nb.0=0A=
+ * USB Interface nb.1=0A=
    - Audio Control function=0A=
- * Usb Interface nb.2=0A=
+ * USB Interface nb.2=0A=
    - Analog Output=0A=
- * Usb Interface nb.3=0A=
+ * USB Interface nb.3=0A=
    - Digital Output=0A=
- * Usb Interface nb.4=0A=
+ * USB Interface nb.4=0A=
    - Analog Input=0A=
- * Usb Interface nb.5=0A=
+ * USB Interface nb.5=0A=
    - Digital Input=0A=
- * Usb Interface nb.6=0A=
+ * USB Interface nb.6=0A=
    - MIDI interface compliant with the MIDIMAN quirk =0A=
 =0A=
 Each interface has 5 altsettings (AltSet 1,2,3,4,5) except:=0A=
@@ -326,5 +329,5 @@=0A=
 =0A=
 After having applied the patch you can run jackd with the following =
command =0A=
 line:=0A=
-# /usr/local/bin/jackd -R -dalsa -Phw:1,0 -r48000 -p128 -n2 -D -Chw:1,1=0A=
+  % jackd -R -dalsa -Phw:1,0 -r48000 -p128 -n2 -D -Chw:1,1=0A=
 =0A=

------=_NextPart_000_0123_01C64CD0.67090230--




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
