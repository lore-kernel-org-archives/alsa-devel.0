From: Mark Brown <broonie@kernel.org>
Subject: Re: Disable DAPM for click avoidance ?
Date: Wed, 22 Nov 2017 16:13:15 +0000
Message-ID: <20171122161315.vpahz77si5xgkmct@sirena.org.uk>
References: <alpine.DEB.2.11.1711221315370.27895@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7489143338469074653=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id C34BA266F03
 for <alsa-devel@alsa-project.org>; Wed, 22 Nov 2017 17:13:17 +0100 (CET)
In-Reply-To: <alpine.DEB.2.11.1711221315370.27895@lnxricardw1.se.axis.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ricard Wanderlof <ricard.wanderlof@axis.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--===============7489143338469074653==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="a62aops7xtx52cbc"
Content-Disposition: inline


--a62aops7xtx52cbc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2017 at 01:33:37PM +0100, Ricard Wanderlof wrote:

Always CC maintainers on postings if you want them to be reliably
seen...

> I'm having an issue with a codec where the normal DAPM procedure of=20
> disabling most of the codec when there is no stream ongoing results in=20
> large clicks when a playback stream starts and stops, because the output=
=20
> jumps from 0V when the output is disabled to over a volt when the output=
=20
> is enabled.=20

> There appears to be a 'slow stop/start' feature in the codec, however, it=
=20
> takes about one second to ramp up and down the output voltage, and that i=
s=20
> too long a delay when starting a stream.

The CODEC driver is broken, it shouldn't be powering off on idle if it
takes a second to ramp, it should be leaving VMID up while the system is
running - this is what the _STANDBY bias level is all about.  Look at
what older CODEC drivers like the wm8731 do.

> Another use for this feature is that we have had a lot of problems over=
=20
> the years with buggy I2S interfaces misbehaving when streams are started=
=20
> and stopped, and there would be an advantage to letting the AIF run the=
=20
> whole time after startup.

This is why we've got the digital_mute() callback - the idea is that the
output is just going to be discarded until the interface has had a
chance to settle down.

--a62aops7xtx52cbc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAloVohoACgkQJNaLcl1U
h9A9JAf+K/6np0y3zKf7VMzHMiwDjJbtO9pV5JQoN1A7Mo54RaPiBe5FHKHyyEn2
95Hvr6dBgeWotuMHllC9w6zJa3MHZbtzqk+VxBkuQtQOEHlY5VYlhAMp0JmMf7Go
8/issXtKTbJRDk2asrvmL1bd+cFQRM9QFsxfrYcc3rYlVE+EllSil2IFCiz0+Zgj
4il+19tBjOzxHu0TcbIaKGc/oKqlx0AsP6Gs++vWKhPczmIw24t04cotCnWpzOqy
fQMeyzQonbp3eBLpgvpDykrl/oIbeeFq6G5jzeMuLvyWvuvVCfUK+cL0yZfiROaC
usRhoz+LPhxuaF/RSsQhpyVFc22Aig==
=olRp
-----END PGP SIGNATURE-----

--a62aops7xtx52cbc--

--===============7489143338469074653==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7489143338469074653==--
