From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 15/49] ASoC: simple-card-core: add
 asoc_simple_card_init_jack()
Date: Tue, 31 May 2016 15:51:13 +0100
Message-ID: <20160531145113.GD29837@sirena.org.uk>
References: <87lh35rs8w.wl%kuninori.morimoto.gx@renesas.com>
 <87zirlqd4t.wl%kuninori.morimoto.gx@renesas.com>
 <20160530171402.GX29837@sirena.org.uk>
 <87lh2rrnmr.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="iig7nzZQzi/oiJm2"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87lh2rrnmr.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Simon <horms@verge.net.au>, linux-renesas-soc@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--iig7nzZQzi/oiJm2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 31, 2016 at 02:08:31AM +0000, Kuninori Morimoto wrote:

> > There was some recent discussion about a more complete core binding
> > for this based on the work that Dylan Reid had been pushing a while ago
> > - it's not clear that the simple-card binding is great for
> > generalization here.

> Can you show me where can I see it ?
> Anyway, I will keep this related function as static in simple-card,
> not simple-card-utils in v2.

This is the proposal from Dylan I was thinking of:

   http://thread.gmane.org/gmane.linux.alsa.devel/138906

--iig7nzZQzi/oiJm2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXTaTYAAoJECTWi3JdVIfQP4gIAIGgZzJgSINSkwywDUjXkEw8
1EMOouoewlZ/nEpCKFORBdZ5xKrwXfg13whCfYM3uTSA5pw8pdnZjkqb6A/BN6d5
oVocdFjCyI6TLcGwEq5CQo/xm9+u17+5RPJ9F/zoTpcAplYAvxv30A4gm2qjuwOI
RkSqiMc7Xw+hlD0MPONdmC9oC25yWq0CqbCjpSS16qIxDtamaRbVPkx+FNH7Bzdr
1FdFxnw7W15WnfyCqEqf0v+qifcl5Q2aEM9NLqYlg9rflTm/MmfowVRZisemZ/vB
W0xS0gFcO5H0i381sgrUDJhC5v/9qxrzg97fXE+yAb7ydwRv0+0XFVRfFvqtBVs=
=JISJ
-----END PGP SIGNATURE-----

--iig7nzZQzi/oiJm2--
