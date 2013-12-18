From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH] ASoC: wm_adsp: Change ADSPs to be
 mixer widgets rather the PGAs
Date: Wed, 18 Dec 2013 11:27:39 +0000
Message-ID: <20131218112739.GH28455@sirena.org.uk>
References: <1387364024-15708-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7546270618473684123=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 714DB2615EC
 for <alsa-devel@alsa-project.org>; Wed, 18 Dec 2013 12:27:42 +0100 (CET)
In-Reply-To: <1387364024-15708-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============7546270618473684123==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Q3iZjccpNGsIEgQL"
Content-Disposition: inline


--Q3iZjccpNGsIEgQL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 18, 2013 at 10:53:44AM +0000, Charles Keepax wrote:

> Was also considering if it would be worth adding an
> additional snd_soc_dapm_dsp id? That could sit between
> mixers and pgas, but I can't really see any obvious issue
> with treating the DSP as a mixer and it is a much simpler
> change. Although I am open to writing the other change if it
> is preferred?

One of the issues here was trying to ensure that the DSP started up with
its inputs stable so noise from them starting didn't propagage into the
algorithm and confuse it.  The expecation with putting it as a PGA was
that it would start with the outputs mute and do a digital unmute to
bring them up.  Since everything is digital this should all be more
robust than it would be for analogue.

If anything I'd have a specific DSP widget type which is one of the last
things to start.

--Q3iZjccpNGsIEgQL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSsYaoAAoJELSic+t+oim94mcP/jUoDYXXpgjsGa3byIuGHKAx
IzCSudLUfvmy60FacifNzOEBuQRQkKOqlVo9uHdUK9aHHcmehXNzqydkuGTqSPzt
DhaUQq9COFe3DPDWv2IX0lEoVtJDD949Xz7VLtzJLH96tNvKyeGBExBWK9eRSWjy
3Xf0jWSaofgFQ3Ka/IcesURVvWso8/JdP7XYya7gPGebRd6VsressJsSSufmsryz
bodgLQOLzRS4/2c9n6Ek0i/bOSG7cUQqHiC5khrVVQS+p6R9wnsptkTLvHWCrzOB
z7YfYLqUIRiCrWpylcanid6KQeEcXffwjHkhMJhuiSuOZyIrhY8eQcnuF0KJNYy5
kgxhPcanbF0+chLg+Zx50bT/LqOWtOiXKHp6F7LEqAa4lxkglPQZyX8oGJsd3tSu
YIwli+CxSgfb2mJmNMJ1FhGUssLPpkmv/r2JOgxbx7q71k9f9AwwBTZPJNWvJwGs
i+Frg99rE6pJ4KkwL0X/KNw2JMpTRuY1KuViFwKfJcCJXA26yZCw6EM28R8bcciE
mdS0dW+HVo8pk2NVZNjUZ3ifTcNz3gm9RBPAYgECxeWv9lSgjC3jpAm0lCY2d/DL
HB3xL0Fb1uAJXUFQrP1FVI+rTTZuF2z252JmVd68GbvEf2Ho5yCZBokCEk0/xPnE
7SFolo44h5rKNcf08YNh
=VTUL
-----END PGP SIGNATURE-----

--Q3iZjccpNGsIEgQL--

--===============7546270618473684123==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7546270618473684123==--
