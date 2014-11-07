From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/2] ASoC: rt5677: Use specific r/w
 function for DSP mode
Date: Fri, 7 Nov 2014 11:19:12 +0000
Message-ID: <20141107111912.GK8509@sirena.org.uk>
References: <1415166173-7504-1-git-send-email-oder_chiou@realtek.com>
 <1415166173-7504-2-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3400773104863774625=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 648882610A1
 for <alsa-devel@alsa-project.org>; Fri,  7 Nov 2014 12:19:33 +0100 (CET)
In-Reply-To: <1415166173-7504-2-git-send-email-oder_chiou@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oder Chiou <oder_chiou@realtek.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, benzh@google.com, anatol@google.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============3400773104863774625==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Szjv/c9llTLHYn9R"
Content-Disposition: inline


--Szjv/c9llTLHYn9R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 05, 2014 at 01:42:53PM +0800, Oder Chiou wrote:
> In DSP mode, the register r/w should use the specific function to access
> that is invoked by address mapping of the DSP.

Applied, thanks.

--Szjv/c9llTLHYn9R
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUXKqwAAoJECTWi3JdVIfQad4H/2D3xqfzTmmpVjHbr/IPHxUb
Hrsu9rd7+QwI1Eu0ofZ1r0zKmosUIen7ljV2jPzaM7GIvbb9Cn8Fevi9D/eMDCRJ
J/8A2IsFtEISD8IFFMH8W0WQvYR2vpjUaEz+jZPYzDbMFrRyHD0ctTBnrDu2bjkQ
zaR7bgW5wn5sXS4DkFfLaVu+2rOUesmbO4A2n/ne4sU+kKjDoxxnW6me/GmQKDZ5
LR8pghRDYKe5n8b26i75Ax93KCT/m2IXNDXU8Y6Pr5r46B5TwrjBIhhz6mXr2sYj
5/QiUGxXIDJDZMt7OIn5lRq6dkbb1CYZPPHLyswlAKgLqkQxAQ1BHFnA6bX0+OU=
=ax8s
-----END PGP SIGNATURE-----

--Szjv/c9llTLHYn9R--

--===============3400773104863774625==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3400773104863774625==--
