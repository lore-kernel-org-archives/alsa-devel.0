From: Shaw Terwilliger <sterwill@sourcegear.com>
Subject: Re: Intel HDA on Mac Pro
Date: Mon, 04 Dec 2006 18:19:35 -0600
Message-ID: <4574BB17.1020807@sourcegear.com>
References: <4574866D.5070506@sourcegear.com>	
	<1165265511.32312.86.camel@razman>
	<45748CF5.8040800@sourcegear.com>
	<1165275957.32312.103.camel@razman>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1326082086=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1165275957.32312.103.camel@razman>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Tobin Davis <tdavis@dsl-only.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============1326082086==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig480A996786715592C8CBAE8D"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig480A996786715592C8CBAE8D
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Tobin Davis wrote:
> Couple of other things I'd need to look at.  Could you stop the driver
> (modprobe -r snd-hda-intel), clear the dmesg log (dmesg -c), then reloa=
d
> the driver and send the dmesg output?  I'd like to verify the pins bein=
g
> detected with what is configured in the driver.  Also, the lspci comman=
d
> output didn't include the subsystem ID which is odd.  It should have ha=
d
> a line similar to "Subsystem: Unknown device 1631:c017".

I've verified that lspci doesn't show any subsystems for the HDA device.
 It does show (known) subsystems for other devices (USB, SATA, IDE, etc.)=
=2E

Kernel messages are from 1.0.13 with --with-debug=3Dfull:

"modprobe snd-hda=3Dintel"
[23787.349708] ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 23 (level,
low) -> IRQ 225
[23787.350397] PCI: Setting latency timer of device 0000:00:1b.0 to 64

Messages from insertion with model=3Darima|6stack-dig|3stack-dig are
identical except for the extra KERN_INFO like:

[23873.974754] ALSA
/data/downloads/alsa-driver-1.0.13/pci/hda/hda_codec.c:1741: hda_codec:
model 'arima' is selected

One possible complication is that this system wasn't booted directly
from EFI.  I have a new enough firmware that I've installed Linux with a
legacy MBR-style partition scheme, and use LILO at the MBR to boot.  The
Apple firmware seems happy enough with this, and perhaps the BIOS it
emulates is causing problems (or maybe not).  Linux is the only OS on
this machine.

> For grins, try "model=3Darima".  This should toggle the eapd control bi=
t.

I've tried that model, and I see differences in the mixer but I don't
get different sound.  What else should I notice?

Earlier today with no model arg present, I unmuted and maxed out all the
mixer channels, and found that with PCM and Surround channels all the
way up, and external amplifier up, I could hear the music I had playing,
though it was still very quiet.  So at least one channel is finding the
line-out jack, quietly.

--=20
Shaw Terwilliger <sterwill@sourcegear.com>
SourceGear LLC


--------------enig480A996786715592C8CBAE8D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFdLsePEbgvbl6u4ERAqIqAJ9bRUPUrhuoEhWj9cXznIFixTCuZgCfanQp
BgVUWCndME7J+t5Ne+XV+3o=
=9ax2
-----END PGP SIGNATURE-----

--------------enig480A996786715592C8CBAE8D--


--===============1326082086==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1326082086==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1326082086==--
