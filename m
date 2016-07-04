From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 07/39 v2] ASoC: simple-card-utils: add
 asoc_simple_card_parse_card_name()
Date: Mon, 4 Jul 2016 10:50:03 +0200
Message-ID: <20160704085003.GS6247@sirena.org.uk>
References: <87fusysjam.wl%kuninori.morimoto.gx@renesas.com>
 <8760tusj2q.wl%kuninori.morimoto.gx@renesas.com>
 <20160629181555.GJ6247@sirena.org.uk>
 <874m8bbdei.wl%kuninori.morimoto.gx@renesas.com>
 <20160701095249.GJ6247@sirena.org.uk>
 <874m861dzi.wl%kuninori.morimoto.gx@renesas.com>
 <871t3a1crg.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7HHdeecsxVcUoH+o"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <871t3a1crg.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Simon <horms@verge.net.au>, linux-renesas-soc@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--7HHdeecsxVcUoH+o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 04, 2016 at 12:20:29AM +0000, Kuninori Morimoto wrote:

> > > > > > +	if (!card->name)
> > > > > > +		card->name = card->dai_link->name;

> > > > > This will unconditionally defererence dai_link but it's optional - we
> > > > > can have analogue only cards.

> > > > This is not new feature. Current simple-card already has it.

> > > Right, but simple-card does need DAIs IIRC while this is intended to be
> > > more general.  All it needs is a check before the dereference to be safe
> > > so it's trivial to handle.

> > Sorry, I'm not 100% understand.
> > Do you mean we don't need handle card->name ? (= we should remove above ?)
> > If so, we can't register card on simple-card. Because snd_soc_register_card()
> > requests it.

> This function tries to get card name from snd_soc_of_parse_card_name().
> and it tries to set card->name from dai_link if card still doesn't have name.
> So, above is optional 2nd try.
> Or, do you mean this if (!card->name) can goes to simple-card, instead of utils ?
> I have no objection about it , but it can be double handling ?
> Because other simple family have same situation.

If we try to dereference card->dai_link without checking to see if it's
set then we'll crash.

--7HHdeecsxVcUoH+o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXeiM6AAoJECTWi3JdVIfQ1NoH/1kL1Q8QbTOYJ7nKJUrK6Q9g
dmVozObpUEq/NH9pGpCEL1GQ9qDkuWwuZVgEWE1l2j17CJMAyan1bWrubk8Pidmv
MuvhqwbM4uunhtC/rSsACM16pjT0NXL1l40OToJUaZt2E1TSiHiH4SHkvqmpU7Bh
qcv2ntXPGSFwxO7kEKOAbHKf7IO/vMx2/VIhAZe6MMK1zK+sOpmi2bkutOLoq+3K
A5a+SQlkm8IGhdT4Q6pvVVp2wAKU1fwwOVOg17Z7lHO9GE8LMvsx4plwQ38PgRMS
jhQuOvjMTPwPJSqa1D3o+RKYA3wXDS4ZP5eFYFvZ2UdRFbEt/Q+C6QT3rt9EZ/o=
=CIDB
-----END PGP SIGNATURE-----

--7HHdeecsxVcUoH+o--
