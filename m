From: Mark Brown <broonie@kernel.org>
Subject: Re: Disable DAPM for click avoidance ?
Date: Fri, 24 Nov 2017 11:41:07 +0000
Message-ID: <20171124114107.bdadlf3qbekhfccp@sirena.org.uk>
References: <alpine.DEB.2.11.1711221315370.27895@lnxricardw1.se.axis.com>
 <20171122161315.vpahz77si5xgkmct@sirena.org.uk>
 <alpine.DEB.2.11.1711231024510.27895@lnxricardw1.se.axis.com>
 <20171123110403.cut6okmjxiithxsj@sirena.org.uk>
 <alpine.DEB.2.11.1711231512490.27895@lnxricardw1.se.axis.com>
 <20171123173427.p3vtifkpqjziifjr@sirena.org.uk>
 <alpine.DEB.2.11.1711241028370.27895@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4722242269539250482=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 20C2E266E3A
 for <alsa-devel@alsa-project.org>; Fri, 24 Nov 2017 12:41:09 +0100 (CET)
In-Reply-To: <alpine.DEB.2.11.1711241028370.27895@lnxricardw1.se.axis.com>
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


--===============4722242269539250482==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ivnmd53dshm55mzy"
Content-Disposition: inline


--ivnmd53dshm55mzy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 24, 2017 at 10:43:48AM +0100, Ricard Wanderlof wrote:

> I know there are codecs that do not need their inputs/outputs (internally=
)=20
> biased to a VMID, but have a 0V bias level using an internal charge-pump=
=20
> design to generate the required internal negative voltages, if that is=20
> what you're thinking of. One disadvantage from a cost perspective is the=
=20
> external capacitors needed for the charge pump to operate, and the design=
=20
> in which this one is used is extermely cost optimized.

Right, but it's not like none of that wasn't already covered by the many
existing CODECs in that space that already paid back their development
costs years ago, it's surprising that anyone would try to make something
new there.

> > > During which time period is the digital mute enabled? From the first=
=20
> > > stream startup until everything is up and running?

> > It should be enabled at all times that we're not actively playing
> > anything. =20

> Ok. So it really would be the last callback made (with mute =3D off) to t=
he=20
> codec driver once everything else has been set up then?

That's the idea.

--ivnmd53dshm55mzy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAloYBVMACgkQJNaLcl1U
h9BMxgf8D3ihyiBl2XkBuusNlQFY0qvyc6X9Htwge8hYZEupZd8XPVgvYXCWLD3s
RaaAq5XGyu7wfaFVJnPXDTKYpuDY7qq+BT2+B5dC17gerIhEB1ocD42FbpD2+CDX
mQwyKz30Q23VgniiidrN/Ifawg/IPRekeDJGOC1pULYZThQU05DkUPgDgVd/C8TA
sd+GZVg+w/SfvDdRC3LE1LjmqhvfnO38SOAsWsM1LT64zUxneWZz3GLf6cWm5CBx
61L+E/GMuyGNMWTHEjHC4aM6HvuHYU30NtZFjee+2P63lTZ5vtTdFrlsCqbWJi10
fUVkozkzFb+YnaZxjpe2HIC34WoT3Q==
=/Z9e
-----END PGP SIGNATURE-----

--ivnmd53dshm55mzy--

--===============4722242269539250482==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4722242269539250482==--
