From: Ross Kendall Axe <ross.axe@blueyonder.co.uk>
Subject: Re: [ALSA - driver 0000628]: Can't record audio
Date: Fri, 21 Jan 2005 15:05:32 +0000
Message-ID: <41F11A3C.1060500@blueyonder.co.uk>
References: <4ca0e9985d5a7a7378d1370dcaa3754e@bugtrack.alsa-project.org>	<41F01BE2.5020808@blueyonder.co.uk> <s5hmzv3w0b1.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigE69B099D497BF887AC77E565"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtp-out5.blueyonder.co.uk (smtp-out5.blueyonder.co.uk [195.188.213.8])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 28C63206
	for <alsa-devel@alsa-project.org>; Fri, 21 Jan 2005 16:05:39 +0100 (MET)
In-Reply-To: <s5hmzv3w0b1.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE69B099D497BF887AC77E565
Content-Type: multipart/mixed;
 boundary="------------000009080008090303000900"

This is a multi-part message in MIME format.
--------------000009080008090303000900
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Takashi Iwai wrote:
> At Thu, 20 Jan 2005 21:00:18 +0000,
> Ross Kendall Axe wrote:
>
>>| ======================================================================
>>| Summary:                    Can't record audio
>>| Description:
>>| I'm not able to record any audio. Reading from /dev/dsp results in an
>>| "Input/Output Error".
>>| The hardware I'm using is Soltek 75DRV5 with built-in soundcard.
>>| ======================================================================
>>|
>>| ----------------------------------------------------------------------
>>|  rossaxe - 01-16-05 17:09
>>| ----------------------------------------------------------------------
>>| What is this particular knob supposed to do? So far as I can tell, it just
>>| offers a choice betweens 'works' and 'breaks'
>>|
>>| ----------------------------------------------------------------------
>>|  tiwai - 01-17-05 15:07
>>| ----------------------------------------------------------------------
>>| This defines the connection of which input pin is selected for the certain
>>| input path.  So, whether it works or not strongly depends on the hardware.
>>
>>Wouldn't it make sense to disable it on hardware for which it does not work?
>
>
> Yep.  Patches are welcome :)
>

Hmm. Probably best save that until I'm at least a *half* decent kernel
coder :-)
Meanwhile, a note in the docs probably wouldn't go amiss. Patch attached.

Ross



--------------000009080008090303000900
Content-Type: text/x-patch;
 name="via-mixer-doc.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="via-mixer-doc.patch"

diff -urN alsa-driver-1.0.8.orig/alsa-kernel/Documentation/VIA82xx-mixer.txt alsa-driver-1.0.8/alsa-kernel/Documentation/VIA82xx-mixer.txt
--- alsa-driver-1.0.8.orig/alsa-kernel/Documentation/VIA82xx-mixer.txt	1970-01-01 01:00:00.000000000 +0100
+++ alsa-driver-1.0.8/alsa-kernel/Documentation/VIA82xx-mixer.txt	2005-01-21 14:58:41.000000000 +0000
@@ -0,0 +1,8 @@
+
+				VIA82xx mixer
+				=============
+
+On many VIA82xx boards, the 'Input Source Select' mixer control does not work.
+Setting it to 'Input2' on such boards will cause recording to hang, or fail
+with EIO (input/output error) via OSS emulation.  This control should be left
+at 'Input1' for such cards.
diff -urN alsa-driver-1.0.8.orig/sound/Documentation/VIA82xx-mixer.txt alsa-driver-1.0.8/sound/Documentation/VIA82xx-mixer.txt
--- alsa-driver-1.0.8.orig/sound/Documentation/VIA82xx-mixer.txt	1970-01-01 01:00:00.000000000 +0100
+++ alsa-driver-1.0.8/sound/Documentation/VIA82xx-mixer.txt	2005-01-21 14:58:41.000000000 +0000
@@ -0,0 +1,8 @@
+
+				VIA82xx mixer
+				=============
+
+On many VIA82xx boards, the 'Input Source Select' mixer control does not work.
+Setting it to 'Input2' on such boards will cause recording to hang, or fail
+with EIO (input/output error) via OSS emulation.  This control should be left
+at 'Input1' for such cards.

--------------000009080008090303000900--

--------------enigE69B099D497BF887AC77E565
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB8Ro/9bR4xmappRARAnPLAKCE2Xp7vUVXVB9AGIikrUGRiR3OtgCdH3qH
4eVks/BUF2geQ05ehwXa3Tw=
=MeWA
-----END PGP SIGNATURE-----

--------------enigE69B099D497BF887AC77E565--


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
