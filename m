From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH] ASoC: wm8731: let codec to manage
	clock by itself
Date: Tue, 3 Feb 2015 16:21:28 +0000
Message-ID: <20150203162128.GP21293@sirena.org.uk>
References: <1422934415-24957-1-git-send-email-voice.shen@atmel.com>
 <CAOLZvyE6W8-X2_M+-KQNry2VPwLzwbBLuxr5Z5EdBQo7Skv2RQ@mail.gmail.com>
 <20150203124441.GK21293@sirena.org.uk>
 <CAOLZvyEVQmqg9Jn5Kt_2m5K0-taJcGf6mweK4T=fwKOwn-Ovxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0386436221782372345=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 73B0626047C
 for <alsa-devel@alsa-project.org>; Tue,  3 Feb 2015 17:22:24 +0100 (CET)
In-Reply-To: <CAOLZvyEVQmqg9Jn5Kt_2m5K0-taJcGf6mweK4T=fwKOwn-Ovxg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Manuel Lauss <manuel.lauss@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Richard Purdie <richard@openedhand.com>, patches@opensource.wolfsonmicro.com, LKML <linux-kernel@vger.kernel.org>, linux-sound@vger.kernel.org, Manuel Lauss <manuel.lauss@googlemail.com>, Bo Shen <voice.shen@atmel.com>, linux-arm-kernel@lists.infradead.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org


--===============0386436221782372345==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6N0KlctTh4dwosRA"
Content-Disposition: inline


--6N0KlctTh4dwosRA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 03, 2015 at 03:40:45PM +0100, Manuel Lauss wrote:
> On Tue, Feb 3, 2015 at 1:44 PM, Mark Brown <broonie@kernel.org> wrote:

> >> +    wm8731->mclk = devm_clk_get(&spi->dev, "mclk");
> >> +    if (IS_ERR(wm8731->mclk)) {
> >> +        wm8731->mclk = NULL;
> >> +        dev_warn(&spi->dev, "assuming static MCLK\n");
> >> +    }

> > This is broken for both deferred probe and in the case where the clock
> > API genuinely returns a NULL clock.  Other than that it's the kind of
> > thing that we've done for some other drivers, though it's not good to
> > have to do this.  Check them for correct behaviour.

> Hm, so the only option is to create the simples possible 12MHz clk object?

Well, that's the best option in general.  You can get away with just
making sure that -EPROBE_DEFER is handled and that IS_ERR() is used to
check for an invalid clock but if you can define a clock that's even
better (and should be pretty painless), we're going to want to do that
transition at some point.

--6N0KlctTh4dwosRA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU0PWHAAoJECTWi3JdVIfQ04QH/jbACrSSpMvI16Nvv/qkyZn7
0YKsObUq85akkoO3SMdRnHIr4HOqgtywq2Z8J+wl4tBbintub02S5whqTBRnDbJv
sxxvNajT2ZtgOBQHBKLu8f/vUqKj3O6BceFWgYS9RCKroUMMQYjguKprcd+mzzWl
YAYwhFbq3HdpWY1xj8O2MqsDxav4IT4mJ6NAkL7Qk/b6dra9Uil5JgLRrTy+jmR/
qj8NLCsNcRvpp39Hf/ISHbJ/1GZN3UplD8jaoVWgcwU//iVv1SLEWuqIh7Tgvg29
jfJFf9kMYGWQr1v1GLL6A48Mt7ufx3vbKIH9CFtKEqNTeg8AdiQim8JjPZLBIE0=
=q63h
-----END PGP SIGNATURE-----

--6N0KlctTh4dwosRA--

--===============0386436221782372345==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0386436221782372345==--
