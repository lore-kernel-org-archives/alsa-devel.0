From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5670: add HS ground control
Date: Sat, 4 Feb 2017 17:11:14 +0100
Message-ID: <20170204161114.v2cifi66qbybyizi@sirena.org.uk>
References: <1482999827-14705-1-git-send-email-bardliao@realtek.com>
 <s5hwpdceuns.wl-tiwai@suse.de>
 <20170201114713.osuuhyomfuswnrgt@sirena.org.uk>
 <s5hy3xqaxa1.wl-tiwai@suse.de>
 <20170201145956.ecoksw7ntapt76n4@sirena.org.uk>
 <s5ha8a6apux.wl-tiwai@suse.de>
 <20170201174359.buiiybffgk6ya62d@sirena.org.uk>
 <ABFD875FF5FB574BA706497D987D48D70124DF38@RTITMBSV03.realtek.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4660300872290954704=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A6C352667CC
 for <alsa-devel@alsa-project.org>; Sat,  4 Feb 2017 17:11:29 +0100 (CET)
In-Reply-To: <ABFD875FF5FB574BA706497D987D48D70124DF38@RTITMBSV03.realtek.com.tw>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, Jack Yu <jack.yu@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lars@metafoo.de" <lars@metafoo.de>, Takashi Iwai <tiwai@suse.de>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Shuming =?utf-8?B?W+iMg+abuOmKmF0=?= <shumingf@realtek.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============4660300872290954704==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="n4d4dpxtsfnyqjma"
Content-Disposition: inline


--n4d4dpxtsfnyqjma
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 02, 2017 at 02:38:55AM +0000, Bard Liao wrote:

> It is a codec GPIO, indeed. But we don't register it to gpiolib.
> So there is no other way to touch the GPIO. We are using it to
> do headset ground control and we should control its level according
> to if headset is using. That's why we control it by a DAPM event.

So one option here would be to register it with gpiolib...

--n4d4dpxtsfnyqjma
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAliV/SIACgkQJNaLcl1U
h9CC+Af/anXTnEG0ruDhf4fIE2JgD7atKjwmRSKGb4POmLXRV3cX1diUrzyA4oaz
IZT0/ueHLMPBpohjIuPqNhggePaCMr2aRJEvKtlZR2o8D95FRt8eyoR9Yv3RC9XZ
3WEOVtiKvBlm5mMJt67RrDncg1GFyfAcZydr8eXvrt6ic+eg+UTp0Pw5wYgT10my
9qTpFLgxKipLA5BByRFBOxGsj03453PZWqT5vbNSVjD9OG8PblkbMQ2+Dd56um0t
Mtk/yo7M0ixuWDGRlW+Bij5Bk/jEuGDWG/0cLbdzyv3nrQj0NbPGra9Lvfg5iSlV
l3cNUj+SBW4ptVoo3PcldrUMuzh9yg==
=+DDb
-----END PGP SIGNATURE-----

--n4d4dpxtsfnyqjma--

--===============4660300872290954704==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4660300872290954704==--
