From: Mark Brown <broonie@kernel.org>
Subject: Re: Multiple codecs on the same DAI
Date: Fri, 24 Nov 2017 18:04:56 +0000
Message-ID: <20171124180456.6c63tkph4e7ahuid@sirena.org.uk>
References: <alpine.DEB.2.11.1711231533480.27895@lnxricardw1.se.axis.com>
 <20171124123921.ajhxztwypujty6ps@sirena.org.uk>
 <alpine.DEB.2.11.1711241456420.27895@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5594834002776702622=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id E70DD267467
 for <alsa-devel@alsa-project.org>; Fri, 24 Nov 2017 19:04:58 +0100 (CET)
In-Reply-To: <alpine.DEB.2.11.1711241456420.27895@lnxricardw1.se.axis.com>
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
Cc: alsa-devel <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============5594834002776702622==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vrhbachrdy3h73qi"
Content-Disposition: inline


--vrhbachrdy3h73qi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 24, 2017 at 03:21:24PM +0100, Ricard Wanderlof wrote:

> In a sense, what I'd want would be to bring in the S/PDIF receiver as a=
=20
> codec driver, but separate from the ordinary chain of sound drivers=20
> (codec, platform, etc). I suppose one way would be to somehow (via=20
> platform data or DT) pass a reference to the S/PDIF receiver to the=20
> machine driver, which would then somehow convert this to a snd_soc_codec=
=20
> *, and then have it explicitly call the the snd_soc_codec_driver.probe=20
> function set up by the S/PDIF receiver driver to initialize it much the=
=20
> way ALSA would have done if it had been part of a dai_link for card.=20

You can just register any CODEC device as an aux_dev, that seems to be
exactly what you're looking for.

--vrhbachrdy3h73qi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAloYX0YACgkQJNaLcl1U
h9AIJwf+MrtfAD0yr/69j0GeEdOCOyyqTO4+0GZF/KQUyAx5vVu4cJQF7kRK/iz7
Hdl0h8r8loImilyn+Y/hvep5EGM36+cLRNHbxyNqpydTzKhh1TwJYDuZhPEvRktb
MkDrGqkTjflC0D+r3tre1LMpLq+OSg9oqNnkZkHCm5hxxjdekufgeakUAn30mEMq
9btQtiKjBfN1y2b8FMX6NGLXoAzSdytnUmc0N18FvWcYA25Ufz0ygBb7EkJ1fykV
CiRIk6aXeQSMouThS+dZbzrDOUUBjynTo6JL+qG1atM6UwzbB0A9MGXp5MFbXbAY
Z8PVkvVVRCPR45CajA9BoZxM609vsw==
=jlCH
-----END PGP SIGNATURE-----

--vrhbachrdy3h73qi--

--===============5594834002776702622==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5594834002776702622==--
