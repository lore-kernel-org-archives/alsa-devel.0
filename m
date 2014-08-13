From: Mark Brown <broonie@kernel.org>
Subject: Re: [v4 11/12] ASoC: Intel: mfld-pcm: add the fe & be
	dai ops
Date: Wed, 13 Aug 2014 21:16:57 +0100
Message-ID: <20140813201657.GT17528@sirena.org.uk>
References: <1407145563-1303-1-git-send-email-subhransu.s.prusty@intel.com>
 <1407145563-1303-12-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1677978477503716476=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8D7A12655DA
 for <alsa-devel@alsa-project.org>; Wed, 13 Aug 2014 22:17:06 +0200 (CEST)
In-Reply-To: <1407145563-1303-12-git-send-email-subhransu.s.prusty@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Cc: vinod.koul@intel.com, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============1677978477503716476==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DMqmoouzUEigPseX"
Content-Disposition: inline


--DMqmoouzUEigPseX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 04, 2014 at 03:16:02PM +0530, Subhransu S. Prusty wrote:
> From: Vinod Koul <vinod.koul@intel.com>
>=20
> Now that the DSP topology is added, add the FE and BE dai ops for control=
s DSP as
> well mute/unmute of FE through ASoC

It really seems like patch 1 should be part of this change, it'd be much
more obvious what's going on then (though the concerns about breaking
machine drivers still stand).

Please also try to keep your changelogs comfortably below 80 columns
(this is over 80 columns).

--DMqmoouzUEigPseX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT68e2AAoJELSic+t+oim9C3cQAIhL0W51XYJG2pIEkCHmJaRa
5WhjOQSoLO/RnrrsxilmvjpBe/Y8OEQ335Sc6W0WnIR7yGuvIM42IUPkhHtk4QB/
gGoaXHHGSBkh94bz4PHsyKnCOlpLqHK20vyFs7gQR1kVjdm6ZynkpqLI+q0rpbXg
6ln+4N5cm+LAbRxd06ZCQJgCmqSr7YI9xhkRs4AAhONKZonn7/jSL7c2N0ceQ8cn
kAhmq/mHibtZcgS0UnpueByn62zC/FV13WvCRLO+bwbX7nwIiUjGx9WVUZrUCJIh
xEwfywSPtqF34Jz+KLkWdZX4pe/tCkkM0wi5o85XKh2zagzuQxP+ibe8IAsHVbDk
d6xpq1J8XcxsZgrItVOuYXvlblgTzvRMwmz7H9wa0criGpTwhEMTDV4bpff4UYfV
KrGb9MqQcN4tgeBI89mfPY2fARsNlvjlM3Y5rfSc25yQXxlbUR+smiHyKtK5NLJ1
FmfpkHwMj0wAO++f/rcgeGyx7fjTWwMS7sdNTQHCVC6L9i60zod+5JmPFTRbV21H
D3FrX0CiO+Em96t6MCTR02p1QmDzC1KQ5KXfkNsxW0PUqHmLpGenQZ1C/+WN2zdH
ImeZlJqZ/2aDPiCENyxCSpYnphSpatqjzHd0CNCY8wHsDQiXbJGpxRSLZIEwSH2K
nrhq4NnhvulP4UZflfbq
=Et6E
-----END PGP SIGNATURE-----

--DMqmoouzUEigPseX--

--===============1677978477503716476==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1677978477503716476==--
