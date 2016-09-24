From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: cs4341: Add driver for CS4341
 CODEC
Date: Sat, 24 Sep 2016 20:07:38 +0100
Message-ID: <20160924190738.ggtxzmx3huqtr42h@sirena.org.uk>
References: <1473352169-23954-1-git-send-email-shc_work@mail.ru>
 <6d495e97-4677-4f1b-9a19-b3c92e4ca606@EX4.ad.cirrus.com>
 <1474448393.244848188@f267.i.mail.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7109820374230266279=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 09AC42665B0
 for <alsa-devel@alsa-project.org>; Sun, 25 Sep 2016 08:04:40 +0200 (CEST)
In-Reply-To: <1474448393.244848188@f267.i.mail.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: "\"Austin, Brian\"" <Brian.Austin@cirrus.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.com>, "\"Handrigan,
 Paul\"" <Paul.Handrigan@cirrus.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============7109820374230266279==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jruvwnnoy5gbfdmu"
Content-Disposition: inline


--jruvwnnoy5gbfdmu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 21, 2016 at 11:59:53AM +0300, Alexander Shiyan wrote:
> >On 9/8/16, 11:29 AM, "Alexander Shiyan" < shc_work@mail.ru > wrote:

> >Can we use regmap_update_bits where we can?

> So you say that regmap_update_bits() is prefferred than snd_soc_update_bits() ?

It's a bit better, yes.

--jruvwnnoy5gbfdmu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJX5s75AAoJECTWi3JdVIfQqX4H/jMp6G8UB7EkebobxdvsJXu8
m1sN/4P/6S6VmHVB/VdBwjSVxZDQkOqczZTcC8ieuPACvNJQYWBsbpFVRSFpyMjf
+49oBwInBgvLffAd+3oVzk6Es7fJer/lvUbRz3GvMSH+2tJwvmd/WLpWNZnWhtBY
/aSpmYWY28eAp7IIFowE9w8v6O0Rym8w2WvMt2bO6YswUSBewon9VTNlHUKq27NY
TbLYDM8Lfv1oNR8Ren5IKGbzrkeQvMHOLQoGl6KKx0Uoqbpc7ubYM2YErbSlRQ7C
pJPYry/FKl20JmSfVm7G3JK+LnERpOuTADNA3iwEQ0KWZWGqeuzrcTeTUDidaOw=
=WBav
-----END PGP SIGNATURE-----

--jruvwnnoy5gbfdmu--

--===============7109820374230266279==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7109820374230266279==--
