From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: wm8962: Replace
 codec->control_data with wm8962->regmap
Date: Tue, 25 Feb 2014 13:36:00 +0900
Message-ID: <20140225043600.GU25940@sirena.org.uk>
References: <1393090325-10712-1-git-send-email-lars@metafoo.de>
 <1393090325-10712-2-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4252998060346732916=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 24B0E265546
 for <alsa-devel@alsa-project.org>; Tue, 25 Feb 2014 05:36:05 +0100 (CET)
In-Reply-To: <1393090325-10712-2-git-send-email-lars@metafoo.de>
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
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============4252998060346732916==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FJElHjmgcQaLLX7x"
Content-Disposition: inline


--FJElHjmgcQaLLX7x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Feb 22, 2014 at 06:32:05PM +0100, Lars-Peter Clausen wrote:
> With the ongoing component-ization of the ASoC framework and the continuing
> migration to using regmap for IO the control_data field of the snd_soc_codec
> struct will eventually be removed. Prepare the wm8962 driver for this by using
> wm8962->regmap instead of accessing the CODEC's control_data field.

Applied, thanks.

--FJElHjmgcQaLLX7x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTDB2tAAoJELSic+t+oim9ifsP/RJd+GD2/3kRxhESOI59jHcx
hr2C1yBshjNAAiZG30V4TW3BwNG2bWzqKAGQMOVjavbnZ3OXm7oede2PKLKTiomD
N5TS9MhmCny7yWG2z7ORB4k7NNmmm8yNPPBiEV/SdSlE33aTY32sE0v4M35zsvks
YFKtclH9GdQuzTVWlLBvM0FT60OzKBXACLk1kOpXHbTmX1tMtBLCjme6lK3VW6/j
qos42l/z8dgo/xqMEMQUB/mOYnhRCKSKzCN/U1KpJCImpEP5h/y8Q5bK35Y6Ler4
o5hbb1vRTTFV0lFWsqXYiZNyX22pa4e3NCzs0tSanQahCiGza3dBCFWalvChhn2v
C+/UdvaYkafG65OcwRRARvKk3pEhvLZH3KA0c8J6KrDYMY3/4Y+gzz3JCVpauPzb
1PWcxOWi0vuGk6950XHJycQ8biiZIwh3rE4m9bvO7oG2/4zBBFB+vLPgfoFv/b2U
PzmlSQ/TR7oDS52NuJphH7hMX7Z9VCEo4CwEqt3d83CKCnQzNAeAh3iiVLe9g5QC
KwQdhd9N3agAgwNiErZTiuvQFJiWvUVCE2k7/g+Wu3SCCmILsrykrA7URkBgXPJL
67P0CreymdJ26eCuqJDqB2U81ucl5dkI9si4QpuKgr3naLzQ7Mduu/thQWcqQVXf
YaeF9dEG5u57LewiVNoz
=Is2I
-----END PGP SIGNATURE-----

--FJElHjmgcQaLLX7x--

--===============4252998060346732916==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4252998060346732916==--
