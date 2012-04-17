From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Add support for CS42L52 Codec
Date: Tue, 17 Apr 2012 17:07:04 +0100
Message-ID: <20120417160703.GO6652@opensource.wolfsonmicro.com>
References: <1334609938-11671-1-git-send-email-brian.austin@cirrus.com>
	<20120417111359.GB6652@opensource.wolfsonmicro.com>
	<alpine.DEB.2.02.1204171040350.16471@heelrod.ad.cirrus.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2018200951466102594=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 53F811042D0
	for <alsa-devel@alsa-project.org>;
	Tue, 17 Apr 2012 18:07:09 +0200 (CEST)
In-Reply-To: <alpine.DEB.2.02.1204171040350.16471@heelrod.ad.cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Brian Austin <brian.austin@cirrus.com>
Cc: mbizon@freebox.fr, alsa-devel@alsa-project.org, lrg@ti.com, joe@nucleusys.com
List-Id: alsa-devel@alsa-project.org


--===============2018200951466102594==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4ZQ/M1iA+qg8otEW"
Content-Disposition: inline


--4ZQ/M1iA+qg8otEW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 17, 2012 at 10:55:59AM -0500, Brian Austin wrote:
> On Tue, 17 Apr 2012, Mark Brown wrote:
> >On Mon, Apr 16, 2012 at 03:58:58PM -0500, Brian Austin wrote:

> >>+		snd_soc_update_bits(codec, CS42L52_PWRCTL1,
> >>+				    CS42L52_PWRCTL1_PDN_CODEC |
> >>+				    CS42L52_PWRCTL1_PDN_CHRG, 0);

> >This looks odd, especially having it in _ON - perhaps a comment
> >explaining why?

> I'm just enabling the power for the codec. Are you refering to the
> Charge Pump enable?

Both, really - it's just generally incredibly unusual to have anything
in _ON, and looking at the names these look like supplies for other bits
of the CODEC so things that I'd expect to be turned on early rather than
late in the sequence.  If it were in _PREPARE it'd be less surprising.

--4ZQ/M1iA+qg8otEW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPjZUgAAoJEBus8iNuMP3dO7AP+waM2TYPn1Hp05C+pUxsbz3H
5p2xb+GNP1nNhTLz6FcGrOg4EuRyUcNaPByKSckcxECkqkDH3rJtMuK0HaE7cB/l
vMjtYgbklp78BewLarezDGsr0DZPtDXwUBp8ya004qVEctZ2YPM1GfNsOzhwxj0h
sPDog2PmWlsV6OrUfOMz0jB/SqSn3212By70txovC7JeVn9AyzQ++iySJnOtkrq4
28O4bEclqS/lc5i41ACl2aovSr9vQXzhaHWfpJ3aGiF+n6Mi374qLqZlwzcSaQnk
CKniFvcidtlYR15MWj2r0335inJFKRd3SFTEOlbpNeQUZgurRpdDnOyRlZiYO+kW
q7qLRsJzeYMySmCcyUk4aCKhCGK4gLaAQkB8AiGwnA6HLRI+8t0EQYtoufbNoV4k
ChBMA+c37jeUxuI57tYxZfH6Dk6iu04QfhLhmn6YNS/pyTv6Zioead9Bzgx2xDeG
rKI8flVv9e1kXqFrJtnx+TjtImtx3i/aGQ0Vqz5U/j3dZG1pmzbmAc+L6Z0IW+kk
R/btXE7uKkpMvXD5m1OQHsEDDuaAQ9TGsuvvTInFRfLqxvANaclOMSGF3gUSS7sS
TlxeoFTx8WL0ZOdALUem9B6dJtJkT7HchTRkOpM2n6CVulINndwN+2qC6qVe3IP+
J9oR2mupP2CLyO2NjVXQ
=ilD4
-----END PGP SIGNATURE-----

--4ZQ/M1iA+qg8otEW--

--===============2018200951466102594==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2018200951466102594==--
