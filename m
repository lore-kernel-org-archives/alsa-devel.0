From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: wm8904: rework FLL handling
Date: Tue, 23 Jul 2019 15:38:35 +0100
Message-ID: <20190723143835.GF5365@sirena.org.uk>
References: <cover.1563817201.git.mirq-linux@rere.qmqm.pl>
 <3e104cf18cb4e26096f0fe065a2c0e80373f861c.1563817201.git.mirq-linux@rere.qmqm.pl>
 <20190723082716.GM54126@ediswmail.ad.cirrus.com>
 <20190723105248.GA5365@sirena.org.uk>
 <20190723115415.GA14036@qmqm.qmqm.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9032503928241986313=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2FFA0F800E8
 for <alsa-devel@alsa-project.org>; Tue, 23 Jul 2019 16:38:39 +0200 (CEST)
In-Reply-To: <20190723115415.GA14036@qmqm.qmqm.pl>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc: alsa-devel@alsa-project.org, Charles Keepax <ckeepax@opensource.cirrus.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, patches@opensource.cirrus.com, Nicolas Ferre <nicolas.ferre@microchip.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Ludovic Desroches <ludovic.desroches@microchip.com>, Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
List-Id: alsa-devel@alsa-project.org


--===============9032503928241986313==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rWhLK7VZz0iBluhq"
Content-Disposition: inline


--rWhLK7VZz0iBluhq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2019 at 01:54:15PM +0200, Micha=C5=82 Miros=C5=82aw wrote:
> On Tue, Jul 23, 2019 at 11:52:48AM +0100, Mark Brown wrote:

> > Right, it's not like it's the same IP being dropped into multiple chips
> > in an identical fashion.  There's a lot of high level similarities in
> > the register interfaces but also many small per device tweaks, and it's
> > not clear what benefit we get from refactoring at this point.

> This would be mainly code separation, so it's easier to understand and
> has a potential for direct reuse. I can see that clock selection needs
> to be changed, but the idea is to have it configurable via device-tree.

Not all the world is DT...

> I picked at random WM9081. It's FLL implementation looks very similar -
> major diffferences being in FLL_OUTDIV selection (direct divider vs 2^N)
> and register block offset.

> Another random pick - WM8900. The general FLL idea seems the same, but
> this one has a bit more complicated register layout, so I wouldn't
> consider it at first.

Yeah, there's a lot that on the surface looks similar but there's a lot
of variations in the detail - different numbers getting plugged in,
register layouts getting tweaked, different sets of sources and so on.
I get that we can potentially combine the implementations which in
theory is code reuse but what is the end goal for that code reuse given
that all the refactoring is going to warrant some testing over a bunch
of different parts.

--rWhLK7VZz0iBluhq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl03G+oACgkQJNaLcl1U
h9CI1gf/UNPF1xRtujg8VeDKY9wZc2+nweeVK+19nTrn8hsGY9isyGpvwlLE5E/K
JnNf+XeaKQkvsPM2h2c02z3sJJaSk9fCH9+m1dEfS+2hjFoYmvdQIepmTIU2Fosy
YE+XLRzYAL49m4b2SdRMosss5kN3cUSPqkVwf6p5lKTTo6uAE19TmS0L0NinrCbU
PC/CjdzYgtiDCQ8B4E9MEqcoKM/GZF26B2McxL6gaK7VF+BUb4gEZdyhfoK5jZhe
xVlyyFWggddfnUDjEoNw5pk1jM838i/S/VGYRXF5ma3YqwH0SCkHH6UiqmzO6dXP
3dhafvv8W2NnL8UZ54oYou+1MHRP/w==
=gNrk
-----END PGP SIGNATURE-----

--rWhLK7VZz0iBluhq--

--===============9032503928241986313==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9032503928241986313==--
