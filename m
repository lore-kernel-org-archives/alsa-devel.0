From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 11/12] ASoC: dapm: Add a few supply widget
	sanity checks
Date: Wed, 22 Oct 2014 12:21:32 +0100
Message-ID: <20141022112132.GW2344@sirena.org.uk>
References: <1413826604-3212-1-git-send-email-lars@metafoo.de>
 <1413826604-3212-12-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2297754707176219046=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2EE1C264FDF
 for <alsa-devel@alsa-project.org>; Wed, 22 Oct 2014 13:21:47 +0200 (CEST)
In-Reply-To: <1413826604-3212-12-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============2297754707176219046==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6B5oiwbC31sfIr4n"
Content-Disposition: inline


--6B5oiwbC31sfIr4n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 20, 2014 at 07:36:43PM +0200, Lars-Peter Clausen wrote:

> 	* Paths with a connected() callback that have a non-supply widget as a
> 	  sink. The DAPM algorithm only uses the conneceted() callback for

This change is OK but I think you mean source rather than sink here -
supplies are normally the source of a route (except in supply chains).

--6B5oiwbC31sfIr4n
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUR5M7AAoJECTWi3JdVIfQx1EH/1aeVCeUeYLfXZaEqOtc7KyC
IVd76ouLHfzoOIp0sdAU5Mn/MwRlBPYtlrg+UCeepCh9MWcERTUrHBMl8qy8kyl4
xoedzXvUVTyO+QQB41MEZShODE8AbdULhDzC4NTRFuz+AQEN/rf6pekPoX4Brq3b
Ptb1hYEXsqnm1H3jWXNm9dzB16hPya7JbZBeOHydhduelpQgTzLPPzlJSRFEJ8t2
dm20ttke29tXvk2/WQvbI7cfiUboFqEWtVFqdp1xT44HDUB/aySX08aA4McG9upX
h1v30bjTAsu9oo8cE8pVoFh1kpCLQqgNiiPQgJ/Bs2gXsvouHh9RpovhciXW9sc=
=NMsc
-----END PGP SIGNATURE-----

--6B5oiwbC31sfIr4n--

--===============2297754707176219046==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2297754707176219046==--
