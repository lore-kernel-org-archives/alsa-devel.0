From: Ryan Underwood <nemesis-lists@icequake.net>
Subject: CS4232 powerdown behavior
Date: Fri, 2 Jul 2004 23:30:21 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040703043021.GI24144@dbz.icequake.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TakKZr9L6Hm6aLOc"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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


--TakKZr9L6Hm6aLOc
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi,

I'm curious about a behavior of the CS4232.  It is possible to software
powerdown the chip.  However, I can't get the chip to power back up.
reading p62 of the databook, it mentions RESDRV external pin.  Is this
pin the only way to bring the CS4232 back up, or is there a way to do it
through software?   It is mentioned on p.46 that the SB/PNP/MPU401
automatically resume if they are accessed, but this seems to be not so
for the WSS component.  (It reads as 0x80 forever.)  Additionally, if I
load snd-sb8 driver to use the SB component after it has been powered
down, the system is hung when a play is attempted.  (Usually snd-sb8
works fine when snd-cs4232 is not loaded, and vice versa)

I power down by setting |=3D 0xc0 to CTRLbase.  I have also tried setting
PDP.  Does anyone know what the difference between the registers is?
The functionality seems similar, as described by the databook.

anyone who knows something about CS4231(a)/CS4232 could help me.  this
is on a toshiba 500cdt laptop btw.  I have a feeling that some special
register is used to drive RESDRV (similar to how my thinkpad 755c's
cs4248 was enabled).  The reason why I have this feeling is that a
ctrl-alt-del reboot enables the sound chip again.  This makes me think
the BIOS is doing something to enable it.  If I can hack the BIOS to
find that register then we will be able to have power management for
sound on this laptop.  I am guessing the reason there is no real PM for
this chip otherwise, is because there is no general way to turn it back
on in software once it has been turned off.

One other thing, does anyone know how CS4232's SBPro 2xOPL2 emulation is
accomplished, when a OPL3 is the actual chip that is connected to the
cs4232 synth port?  This seems to be nonsense, but the databook does
claim that 0x220 is left FM and 0x221 is right FM.  I suppose I will
have to test it.  It might just behave like a SB16 with respect to the
OPL3.

thanks!

--=20
Ryan Underwood, <nemesis@icequake.net>

--TakKZr9L6Hm6aLOc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA5jZdIonHnh+67jkRAkjQAJ9pYDKBiTuoHfVgkok/M2RVhJ58qwCghOF7
U51FjgHt98XWZXABkxs7ns0=
=U0Wv
-----END PGP SIGNATURE-----

--TakKZr9L6Hm6aLOc--


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
