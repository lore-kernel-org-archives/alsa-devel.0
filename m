From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: rsnd: enable SRC setting via DT
Date: Tue, 29 Jul 2014 19:28:16 +0100
Message-ID: <20140729182816.GC17528@sirena.org.uk>
References: <87oawzum8z.wl%kuninori.morimoto.gx@gmail.com>
 <20140711123026.GK30458@sirena.org.uk>
 <87oaws1rhm.wl%kuninori.morimoto.gx@renesas.com>
 <877g32gpgu.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1436795535524635081=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DB8802652AC
 for <alsa-devel@alsa-project.org>; Tue, 29 Jul 2014 20:28:21 +0200 (CEST)
In-Reply-To: <877g32gpgu.wl%kuninori.morimoto.gx@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org


--===============1436795535524635081==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dMULN7IjMgCcEAKn"
Content-Disposition: inline


--dMULN7IjMgCcEAKn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 24, 2014 at 07:08:19PM -0700, Kuninori Morimoto wrote:

> > > >   48kHz   --->      48kHz
> > > >   44.1kHz ---> [SRC] ---> [codec]
> > > >   96kHz   --->

> > > This is something which really should be implemented using the
> > > frameworks (DPCM mainly in this case as previously discussed for this
> > > and other bits of the hardware) rather than with something custom to the
> > > driver - we already have a way of forcing a DAI link into a single
> > > configuration, we should be using it.

> If my understand is correct,
> current upstream code doesn't have above feature at this point,
> and, I can update DPCM feature for it ?

> If yes, and if I want to exchange rate from 96kHz -> 48kHz,
> I can use be->dai_link->be_hw_params_fixup() for 48kHz settings ?

That's the idea, yes.

> Then, FE side want to know this result (= BE want to use 48kHz).
> I can add something new method for it ?

Let's have a look at the code - it might be easier to do it within the
driver but a framework feature is also OK.

> Or does current upstream code already have something this feature ?

No, just the fixup functions.

--dMULN7IjMgCcEAKn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT1+e8AAoJELSic+t+oim9zEIQAJryjOjwaQZenmkG3gdvyNNh
8P5XWQp+K4f/hsw5/nnECnu5FpT2/aM+RJHFAADsyLdXzOeFz0b2UPGjSRXORR3N
4zP0nmyYQFZq1BO5FuQO0KJqE0u6Ze3hXAR7xhz7qb3A52SCEI8q50LuN9Tnh2Qp
w0QcRuCiMDPiechYhC70Q5fz3VixtPdyC/WqfYGAWN5N8RhsmGJ2/g7V/7b4xCK9
/kHwaSZeZLQ6VJvDFsw6tiaX0rnjjqgOy8lqpE3Jzz3K6jqKDkEVxGgdsq5STzjH
8c2gMjs9l0typ2q9mdIs3715ZUSS//d5P1u2+uJmF47a8xZPA6KH0Uq3PPQJ3UFH
dKaM7JDtauP0x517DEUFaznhB90P2xksQ5HtwqM8BaTCWSuFnxn9l/vpScxwXC3I
r6RhX9QaLqQxev4zcrtsaXBbhMXcCPUrQO8iqiHiu17U95Uz/hIalPtoPqV3s2ts
pE6odrZUuwt03xC52YqHFdsLHUHLuIanqXUPQSN7PrHGumXy4umAnUMhUFUhIcCN
0Eq0tmttNSCIKQ+DCuNtrKAz04HdJQy1vvHGabBGCD2RC/KAmzVpvY7L3sovghaH
WM7VE3w4LTWWAB8TW18twZntkiYmkElFsQMiWzJkGy8qyw80Q9TxWqthHZqDYde9
SkM1o/Gg4/vH277mHzaM
=nQRu
-----END PGP SIGNATURE-----

--dMULN7IjMgCcEAKn--

--===============1436795535524635081==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1436795535524635081==--
