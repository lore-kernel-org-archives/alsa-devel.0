From: Ryan Underwood <nemesis-lists@icequake.net>
Subject: Re: alsa hw params on SB Pro
Date: Sun, 20 Feb 2005 01:19:46 -0600
Message-ID: <20050220071945.GD22658@dbz.icequake.net>
References: <20050208053606.GB8616@dbz.icequake.net> <Pine.HPX.4.33n.0502141038070.20014-200000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline
In-Reply-To: <Pine.HPX.4.33n.0502141038070.20014-200000@studcom.urz.uni-halle.de>
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


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


On Mon, Feb 14, 2005 at 10:43:47AM +0100, Clemens Ladisch wrote:
>=20
> Probably you've been using some device using the plug plugin.

Yes, this is true.  Perhaps I misunderstood the purpose of the plughw
device.  I thought it is so ALSA lib can internally convert
application's data into a suitable hardware format.  In the case of SB
Pro, it would seem reasonable that if the app is giving a 44.1KHz 2ch
stream, plughw layer would convert either to 22KHz or to 1ch for the
underlying hardware, since otherwise the playback will completely fail.

So far, I haven't found the way to make this work correctly.  I think it
can be done with asound.conf if it is really not the job of alsa-lib,
but I don't know how to only convert >22KHz streams to 1ch while leaving
other streams as 2ch.

Problem with using hw:0 directly is that this is not really a flexible
hardware in supported stream formats (U8 samples only, for example, as
well as max 2ch rate at 22KHz).  So plughw is much preferable in this
respect for app compatibility.

If there is a question why an old SBPro is still being used, well, it's
the built-in sound chip on a laptop... in fact, it is part of a CS4232
chip, but the WSS component of that chip does not work correctly with
either snd-cs4232 or snd-ad1848 - eventually after playing some sound
(sometimes for a long while), the chip locks up and must be power cycled
to restore the WSS component.  I suspect it is a problem in the
hardware, but it is very strange that e.g. SBPro and OPL components do
continue to work afterwards.  The message that I get when I attempt to
reload snd-cs4232 is:
Feb 19 19:00:37 localhost kernel: ALSA
=2E./../alsa-kernel/isa/cs423x/cs4231_lib.c:386: cs4231_mce_down - auto
calibration time out (1)

which provides no real help, just that the CS4248 hardware seems to have
stopped responding.

--=20
Ryan Underwood, <nemesis@icequake.net>

--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFCGDoRIonHnh+67jkRAvkcAKCkvH8Mo7NJntYIJk5n1dVHxAFA8ACeM5sO
kHvIfQYFRvz0zNDoJEbhSkY=
=7jjt
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
