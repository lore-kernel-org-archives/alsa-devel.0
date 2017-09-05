From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rsnd: stop all working stream when
 .remove
Date: Tue, 5 Sep 2017 15:04:00 +0100
Message-ID: <20170905140400.kiz4hlksdz25f7cu@sirena.org.uk>
References: <87d17akgqr.wl%kuninori.morimoto.gx@renesas.com>
 <s5h1snqvnnc.wl-tiwai@suse.de>
 <PS1PR0601MB1881FD07A3E16E039943DA7FD4910@PS1PR0601MB1881.apcprd06.prod.outlook.com>
 <s5h1snmuwxk.wl-tiwai@suse.de> <s5hziaati7p.wl-tiwai@suse.de>
 <PS1PR0601MB18818E81D00F3056E7F7D54CD4960@PS1PR0601MB1881.apcprd06.prod.outlook.com>
 <s5hk21dtvm6.wl-tiwai@suse.de>
 <PS1PR0601MB188127AD25441AE8543A0EE1D4960@PS1PR0601MB1881.apcprd06.prod.outlook.com>
 <s5hy3pto5ft.wl-tiwai@suse.de> <s5ho9qpnzs1.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4018484987444409803=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 7B50F26683B
 for <alsa-devel@alsa-project.org>; Tue,  5 Sep 2017 16:04:06 +0200 (CEST)
In-Reply-To: <s5ho9qpnzs1.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org


--===============4018484987444409803==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3oxughdf2bxaihxn"
Content-Disposition: inline


--3oxughdf2bxaihxn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 05, 2017 at 01:35:58PM +0200, Takashi Iwai wrote:

> So my idea is something like below (totally untested): call
> snd_card_disconnect_sync() at the remove call of each component at the
> beginning.
> That assures stopping all pending operations and syncs with the file
> releases.  For ASoC, we may want to wrap it with ASoC structs, but you
> can have an idea by this patch.

I'd say that in ASoC we'd have the call to this in the core rather than
wrapping it, I'd expect the first thing the drivers do is to unregister
the component.

--3oxughdf2bxaihxn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmurtAACgkQJNaLcl1U
h9BGGAf/WYoMX3G5evS1SPxUvHenbiiz+K+H72tNwaqQV45HtIzarmJ218Pf7KSz
nNzRciy2Xcxd3ZyxHIAkzPaLiJrBq++dW+ecgSOhcMq85EVcW1EvfN8WOAGDG3W2
UjWWtRLFCndfh2BI9m1nrD8lYJhxeDX7ekpS3b6Bc82/DVfDbCMj48r0D1eOscSX
wQfZr1uI3XKF3QGqFTXbySuzVS2Tfx3eW+7Txt99PksORf2qSWROYKUZfvokxORG
iMj2u5G4INqs1R8wvqNWzQWZmbiIbLIJi24KjdM4HQmQz/VGp8LNQSja7qYfgKdn
vaIoHIfOa8HZTn8+HPxJf/ufaq1Pqg==
=msOb
-----END PGP SIGNATURE-----

--3oxughdf2bxaihxn--

--===============4018484987444409803==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4018484987444409803==--
