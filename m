From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: alc5632: add an of_match table
Date: Tue, 1 Apr 2014 00:05:17 +0100
Message-ID: <20140331230517.GH2269@sirena.org.uk>
References: <1396291098-13796-1-git-send-email-swarren@wwwdotorg.org>
 <20140331192349.GA3431@mithrandir> <5339C638.5030303@wwwdotorg.org>
 <20140331224520.GF2269@sirena.org.uk>
 <5339F205.50403@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1616933682978678086=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B2B952651CF
 for <alsa-devel@alsa-project.org>; Tue,  1 Apr 2014 01:05:33 +0200 (CEST)
In-Reply-To: <5339F205.50403@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: alsa-devel@alsa-project.org, Thierry Reding <thierry.reding@gmail.com>, Stephen Warren <swarren@nvidia.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1616933682978678086==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fqI+47YoL7hbVrTK"
Content-Disposition: inline


--fqI+47YoL7hbVrTK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 31, 2014 at 04:53:57PM -0600, Stephen Warren wrote:
> On 03/31/2014 04:45 PM, Mark Brown wrote:

> > of_match_ptr() is supposed to avoid the warnings that the ifdefs fixed
> > more prettily - I suspect you'll find that the ones that don't use it
> > either predate of_match_ptr() or copied something that did.

> I believe you either have the ifdef and the of_match_ptr(), or you have
> neither. The use of of_match_ptr() is required when you wrap the
> struct/array in an ifdef, so that the struct/array is only referenced
> when it's declared.

> I guess from your response you want the struct/array wrapped in an
> ifdef, and to use of_match_ptr() when referencing it. I'll go ahead with
> that; no need to reply if that's what you meant.

No, what I'm saying is you shouldn't need the ifdef any more if you use
of_match_ptr() and that's the more modern way to do things.

--fqI+47YoL7hbVrTK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTOfSqAAoJELSic+t+oim9QkoP/2Cd8kUe90juJugxkbmLzJFq
/W704CfJfYtgK9vG2dIF7nkHivOkzHMLIG70H8HSQ+CzTB2mWW8fE2rML7OLgvi0
C+j4We5kfIe1gS2Ger5bGt4xc//O50K67z4S1LKRWjXrKdrySNMyhQAmTde84LxM
ipG0ZNXKy2UQkSCiKxAk1t/E+baAI3yqIjUQ6Hc3nJRr7KmVimLQiz+WL35YhtMN
rm3jcnvGEXtgCGjyComXX0en7gayUFSgmmyPJTc4nE0p5A5NKSMvYDWSBOgYqDX8
UHOeJ6VZM+LR9v7FnUgHtowqvD7HKV0Vj8nIIFW7pcu4IYlwkXR/SvkvfOHLa5Im
qL6TFdEimiZtvyDuEnNtqLGBIah0/tDsoaAKGHRSfw/jNdRcIR0j4qwCIrQ5oV9o
vL6hVPEj1DWJ9AnuC77+b0ekajfId2zSIAO6mZWIEsCtkn0/97IYNZKjV2ovFQeB
0CAXV22xI87RSPpn+mlSyChO2KlXRe1ckzGmqwgwaYL40CTR7vqWV3SupLMC6vpN
0YpAOOFiI0kSEpn5p+0rShlPVbwWVKpM/hP669xIuBitTCSUUttGMS/DfTsLssrx
fXY0Cdx0Pxgu9s1K00Ak6Q/Q6pGloXWqYpTfdilxJ2H/LvU7s5Io1/yeWZVv1C4t
8iWSPXr8B0o0WVgfJFip
=KsUd
-----END PGP SIGNATURE-----

--fqI+47YoL7hbVrTK--

--===============1616933682978678086==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1616933682978678086==--
