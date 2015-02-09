From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: core: call
 snd_soc_unregister_card() when component cleanup
Date: Mon, 9 Feb 2015 16:22:17 +0800
Message-ID: <20150209082217.GE2593@finisterre.sirena.org.uk>
References: <87h9v4gbhg.wl%kuninori.morimoto.gx@renesas.com>
 <87iofj7qhc.wl%kuninori.morimoto.gx@renesas.com>
 <20150204205503.GM21293@sirena.org.uk>
 <87lhkcj55p.wl%kuninori.morimoto.gx@renesas.com>
 <87k2zwj4zf.wl%kuninori.morimoto.gx@renesas.com>
 <20150206214659.GA31311@finisterre.sirena.org.uk>
 <87lhk7x58a.wl%kuninori.morimoto.gx@renesas.com>
 <87egpzx0id.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3682586804024733819=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F39F260525
 for <alsa-devel@alsa-project.org>; Mon,  9 Feb 2015 09:22:47 +0100 (CET)
In-Reply-To: <87egpzx0id.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============3682586804024733819==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gMR3gsNFwZpnI/Ts"
Content-Disposition: inline


--gMR3gsNFwZpnI/Ts
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 09, 2015 at 02:48:09AM +0000, Kuninori Morimoto wrote:

> In normal ASoC card, it will re-try .probe if necessary cpu/codec was not probed
> (= -EPROBE_DEFER in soc_bind_dai_link()).
> This is the before state of card was instantiated.
> Returning everything to the before state = unregister card is very natural I think...
> If possible, we want to add this card driver to deferred_probe_pending_list
> in drivers/base/dd.c, but it is over kill ?

That's something we need to do, we're relying on deferred probe to
instantiate the cards when their components are registered.

--gMR3gsNFwZpnI/Ts
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU2G44AAoJECTWi3JdVIfQqQ0H+waboe3Wk3+uG37OOaMzXpat
hTRJZUp2EpguZbHBNX6Jd0HyxbLnlH8aSBiyYkEAecY1zJWM3YmKANx4Iao/IXz2
ZBgh21HJmy67dO/k2LC2IzO83gLaaE4d+D5xg9hLEIR7pST4mFhOLvScUgKSyz55
Fo1ZxoiaQYkar5eWKQi7Wa62Li7SLfUVyvyLKApX/fCplRpTCqSi62RmgCHstCB4
dXlYt5rjEYb27/rh2PaVvKDOw49cTFEXRSrRUhx/Cf7lWDE5qfhd9fedSQULZrH7
SyhWeaAMQAcDjqijsDQYKZ3tKGkjLg6F0Q/SX5dWgNsMWmFswQhtFFJ0jgAUMvw=
=8wCr
-----END PGP SIGNATURE-----

--gMR3gsNFwZpnI/Ts--

--===============3682586804024733819==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3682586804024733819==--
