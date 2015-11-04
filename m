From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: nau8825: fix stream_name conflicting
Date: Wed, 4 Nov 2015 11:26:23 +0000
Message-ID: <20151104112623.GY20228@sirena.org.uk>
References: <1446596019-83464-1-git-send-email-yang.a.fang@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0150741310481736213=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id BE43826546B
 for <alsa-devel@alsa-project.org>; Wed,  4 Nov 2015 12:26:30 +0100 (CET)
In-Reply-To: <1446596019-83464-1-git-send-email-yang.a.fang@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: yang.a.fang@intel.com
Cc: alsa-devel@alsa-project.org, srinivas.sripathi@intel.com, vinod.koul@intel.com, joe.konno@intel.com, lgirdwood@gmail.com, sathyanarayana.nujella@intel.com, naveen.m@intel.com, vedang.patel@intel.com
List-Id: alsa-devel@alsa-project.org


--===============0150741310481736213==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Z8pjODCYYz+3zRe3"
Content-Disposition: inline


--Z8pjODCYYz+3zRe3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 03, 2015 at 04:13:39PM -0800, yang.a.fang@intel.com wrote:
> From: M Naveen <naveen.m@intel.com>
>=20
> There is naming conflict with dai stream_name defined in dmic.c
> so assign different name

What sort of conflict?  All names are scoped within their device,
conflicts are inevitable since we support havig more than one instance
of a device in the system.

--Z8pjODCYYz+3zRe3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWOeteAAoJECTWi3JdVIfQGz0H+gORmOAwhQljQBpMJEFWAqFW
FRm+K5wbuH2orAyYqLVXUbbnH+4sSjn1NQsH3ebVjLiYUZyJb3EmJaMyk2e+jMbP
qOcjAxArVLcBFrheHWto3nE/3nP887RNNMiQAXLee9+PFXpKLsBpHJB8xE2Y9ubj
XQ5k6S8OEfRdqadGAkJhn8fR7hMXF+vTixnFwGGPGHarX9D9mGYIJwYZCqGug01c
ObHdqf8T7MUwFbNADFc0h6OWU9aMDY08jYPyoXHjUN2/Fgi3wiRHAE8wDfFriMQp
pZBd6my4uRppzA7YGSuYRJbJ9f2ER1Cd6Pok4XuwLrFEkBiNsPzt3fkHOd4xq1c=
=hQ+O
-----END PGP SIGNATURE-----

--Z8pjODCYYz+3zRe3--

--===============0150741310481736213==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0150741310481736213==--
