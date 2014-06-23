From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: cs42l56: Fix stereo channel register
 assignment for Headphone and LineOut volume mixers
Date: Mon, 23 Jun 2014 17:26:42 +0100
Message-ID: <20140623162642.GB23300@sirena.org.uk>
References: <1403540273-15231-1-git-send-email-ryan.harvey@cirrus.com>
 <alpine.DEB.2.02.1406231124500.25941@heelrod>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8396886946045540728=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id F3FF126588C
 for <alsa-devel@alsa-project.org>; Mon, 23 Jun 2014 18:26:50 +0200 (CEST)
In-Reply-To: <alpine.DEB.2.02.1406231124500.25941@heelrod>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Brian Austin <brian.austin@cirrus.com>
Cc: alsa-devel@alsa-project.org, paul.handrigan@cirrus.com, lgirdwood@gmail.com, Ryan Harvey <ryan.harvey@cirrus.com>
List-Id: alsa-devel@alsa-project.org


--===============8396886946045540728==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IiVenqGWf+H9Y6IX"
Content-Disposition: inline


--IiVenqGWf+H9Y6IX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2014 at 11:25:18AM -0500, Brian Austin wrote:
> On Mon, 23 Jun 2014, Ryan Harvey wrote:
>=20
> >Stereo Headphone and LineOut volume mixers are now attached to HPA+HPB, =
LOA+LOB.

I don't seem to have been copied on the original patches here, or
they're snarled up somewhere in transmission anyway.

--IiVenqGWf+H9Y6IX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTqFU/AAoJELSic+t+oim97sAP/in+e0GSrwYOYLZLYzOggzJY
/MohdV8Tuh/P14Wn0xOClsHKTEYxa+3Qp2cyA2NK2txl+p7JwIW0BN9WHkXSwYzQ
9hFVPE49xKq+kLFoTv4z4uufKPB4v7JJVXlKbM9f1hazWpwSBt9os5MpMdLxDgWn
cSU0Dzevn5BJWmGs3J0wwoAnbgH2b2W2uaMWio9FI0D+K0nFyPpnK6X9z8YGX72T
9HufxvOYYEAWTx2837f+GHcSPw2ZuXEwEYDmxh2EoZD4e1HUOdQqYOHpyptg1Md+
Lb0ondj3FpwWzUyrpAekim++jN7DH9Wif3BxxzmeYD7KViq+jGyUtYPFVvRh5FTb
G4o2PqAAe0Tq9Kge/wbZHfv94wkb8gDMWHO75FbubIUnamMAA4fhDAw9ioNWYB3L
WmmlR83IAY8F/yFFSK3lwqBNMika82InuaOnronQKyo0giufT4rJCl0cfABAW2xw
nLUJardWHwNB0YuDdlil+dI0mNcdqINTbmziJNgUsTaGIP5uVGbSsZ06OQMvMZfs
W86XIkZ843LyqXcisNjfPpOroBNlhNYzwiRHV0J0WtMDm8QTrDUMfEyDco2PTnvV
AcpM864hK/13ZgzuFepSC7AX5/azqUea5QHux0cxnURADrjgFAKMTr+/QjgyLRcE
QZxsKhFpOp6/ht1vFzK5
=mvhe
-----END PGP SIGNATURE-----

--IiVenqGWf+H9Y6IX--

--===============8396886946045540728==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8396886946045540728==--
