From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 24/32] ASoC: wm8990: Cleanup manual bias
	level transitions
Date: Mon, 24 Nov 2014 18:38:43 +0000
Message-ID: <20141124183843.GR7712@sirena.org.uk>
References: <1416746269-4935-1-git-send-email-lars@metafoo.de>
 <1416746269-4935-24-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7469393084550459237=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 321EB2657A6
 for <alsa-devel@alsa-project.org>; Mon, 24 Nov 2014 19:40:38 +0100 (CET)
In-Reply-To: <1416746269-4935-24-git-send-email-lars@metafoo.de>
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


--===============7469393084550459237==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xHTUIiWqaPwZ9IpM"
Content-Disposition: inline


--xHTUIiWqaPwZ9IpM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Nov 23, 2014 at 01:37:40PM +0100, Lars-Peter Clausen wrote:
> Set the CODEC driver's suspend_bias_off flag rather than manually going to
> SND_SOC_BIAS_OFF in suspend and SND_SOC_BIAS_STANDBY in resume. This makes
> the code a bit shorter and cleaner.

Applied, thanks.

--xHTUIiWqaPwZ9IpM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUc3syAAoJECTWi3JdVIfQ7PIH/09NwPkM4nz/KGTfRdeERKt1
XfcAEMsameY2lJ8iIF4NE9qSTZCHJ3hmLL7u9N00TizfaEU9oJfEMTi+PxP0FA0n
pGj1BORJzqsZPjMQBqR6ljuuOj/aYRSie7Z9QRDKYga8OLiLt4nsVDraeQGxX3hb
/ytYMxPll77DMz2ocmbWuWZdz4OGGzewZhig2VkTyZQL6ssN5vmLd/Uj4xfxSWeB
L38oxFLS3yi5By08sZ5S1CbZF44UQXK+XAyVhk8tXNRl4EKWslCD2hgyoawTlHVn
JbOO1WVwBN1PIMzPOKZsflTMoZ9eiVNAvZSJ4L4xZHiklfY+SzzXDSebE0Y8P/c=
=xpHK
-----END PGP SIGNATURE-----

--xHTUIiWqaPwZ9IpM--

--===============7469393084550459237==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7469393084550459237==--
