From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: gtm601: Remove .owner field from
 platform driver
Date: Wed, 24 Jun 2015 11:23:54 +0100
Message-ID: <20150624102354.GG14071@sirena.org.uk>
References: <1435114524.2082.1.camel@ingics.com>
 <1435114591.2082.2.camel@ingics.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6756892968838334705=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 631852658CB
 for <alsa-devel@alsa-project.org>; Wed, 24 Jun 2015 12:24:04 +0200 (CEST)
In-Reply-To: <1435114591.2082.2.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Marek Belisko <marek@goldelico.com>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============6756892968838334705==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WYeHKcgVFLkBoQ16"
Content-Disposition: inline


--WYeHKcgVFLkBoQ16
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 24, 2015 at 10:56:31AM +0800, Axel Lin wrote:
> Remove .owner field because the core will set it.
> Also clean up the code a bit to fix indent and make soc_codec_dev_gtm601
> const.

This doesn't apply against current code, please check and resend.

--WYeHKcgVFLkBoQ16
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVioU6AAoJECTWi3JdVIfQCj8IAIGIHoykC5RWFVDW9dbXFJg2
RSj1Xhhy3BPnaCi3/4nKva8aGDuq+S5YhxBHqc9hrfVsJflihRg3OKfSct6zz9ep
uVoRiuZ/7R6z2h0U9sr0LaJFT0z74BSukcbNU1jB9RaSy4U5OC+2q7IGvDAoP0YJ
hzVwscb7GX+BL2MlK8F73sYatDblwjGxGK4f/sxiWo70V7R7/5WaBeZaijcVvmLC
zX2g9eZQMDP5flfyxHZYePqPrzM5RoegrQjkLeHv2ZvWw3FNNsuVpWdVZt9dhj3q
VqGo9/CRz0gCAH/C4PTRmd3nVZi6kxb91jDrEpC5EdDNzX/o8BgR52nCQoVF21Q=
=/rWz
-----END PGP SIGNATURE-----

--WYeHKcgVFLkBoQ16--

--===============6756892968838334705==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6756892968838334705==--
