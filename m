From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/3] ASoC: rt5631: Cleanup bias level
	transitions
Date: Mon, 24 Nov 2014 18:07:31 +0000
Message-ID: <20141124180731.GS7712@sirena.org.uk>
References: <1416746872-11513-1-git-send-email-lars@metafoo.de>
 <1416746872-11513-3-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1269179414918736332=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0AC0A26067E
 for <alsa-devel@alsa-project.org>; Mon, 24 Nov 2014 19:09:35 +0100 (CET)
In-Reply-To: <1416746872-11513-3-git-send-email-lars@metafoo.de>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1269179414918736332==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Sr/1Pkwuhjf1+ztR"
Content-Disposition: inline


--Sr/1Pkwuhjf1+ztR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Nov 23, 2014 at 01:47:52PM +0100, Lars-Peter Clausen wrote:
> Set the CODEC driver's suspend_bias_off flag rather than manually going to
> SND_SOC_BIAS_OFF in suspend and SND_SOC_BIAS_STANDBY in resume. This makes
> the code a bit shorter and cleaner.

Applied, thanks.

--Sr/1Pkwuhjf1+ztR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUc3PiAAoJECTWi3JdVIfQU08H/iFKCp1g2WxlKOi/p0KB7xnL
TU/JZR0J1ncoFJHrpZUBl18dUVcRbwR64XRZW1Ke7ArlquOd4Xcwx9XIONxJQyje
MRgfSbs6iGKdIZ0nf154erbo8Gt2W49AbudRkbq/mqSCz5Duf0S0Ya6YZLOT+wHz
LmHHBxLTQ11U1VA0Oefmxk8nBAObgC3tg1cmZYeyfxfJUGGEaZV8bAETl8mP4IqF
849iIR9+jCFRQsl4SZL5VXbxEBV7rpd5BoHvxvo3lWGygITwjaNUTqPicUbdx506
f6tGZ0QO7rF2rZPMr0mJ8CXEGTO8VK8G2LBxl5FvSF/2BzHN3Zpa8pxaEBQ09f0=
=WS3J
-----END PGP SIGNATURE-----

--Sr/1Pkwuhjf1+ztR--

--===============1269179414918736332==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1269179414918736332==--
