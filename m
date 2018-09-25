From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: soc-utils: Rename dummy_dma_ops to
	snd_dummy_ops
Date: Tue, 25 Sep 2018 09:49:41 -0700
Message-ID: <20180925164941.GN20825@sirena.org.uk>
References: <20180925004711.99422-1-mka@chromium.org>
 <CAHp75VeEaB7VwO9S6y3o55XL_D27b=GhEk1sZhF9Pvsj2XsFFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3476580307002266395=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 953402678AF
 for <alsa-devel@alsa-project.org>; Tue, 25 Sep 2018 18:49:44 +0200 (CEST)
In-Reply-To: <CAHp75VeEaB7VwO9S6y3o55XL_D27b=GhEk1sZhF9Pvsj2XsFFg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Matthias Kaehlcke <mka@chromium.org>
List-Id: alsa-devel@alsa-project.org


--===============3476580307002266395==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YuJye9aIuN0w6xGV"
Content-Disposition: inline


--YuJye9aIuN0w6xGV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 25, 2018 at 11:36:55AM +0300, Andy Shevchenko wrote:
> On Tue, Sep 25, 2018 at 3:48 AM Matthias Kaehlcke <mka@chromium.org> wrote:

> >   extern const struct dma_map_ops dummy_dma_ops;
> >                                   ^

> > Rename the symbol in soc-utils.c to 'snd_dummy_ops' to avoid the conflict.

> But it misses 'dma' part as I can see they are still DMA related.

> snd_dummy_dma_ops ?

Yes, we have many different set of operations in ALSA, snd_dummy_ops is
just inviting further collisions.

--YuJye9aIuN0w6xGV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluqZyEACgkQJNaLcl1U
h9AdQwgAheMn3bz50bARVTfx4ejXNfP8dBxZZEsIbr6PXpeSEqhWDjyvqfZ8vRtH
NFHwlD1W3z4KojNe4CEhlElg1pVVy1wJJWrIF29QPmnoPLddrKQEUthoDFbbfg7y
8cHmNeBICXa7yggpjgEhCeXvm12GpxccQer9lmNRABdOEqunMJXrrapdvFWUc8bm
BzJmcRPyb/nKlV6Q4qenHXterbAivYdzhYj7MVt9t9T4MO7C/728qtEpoxv0XgR9
s1UtcHbGiZCMoMo+BjykvKopzAYVqsKSvIdpPF2BIhwWj5LqGAXk1oWDc0NC69iJ
ZYpi81FNXuRLCiNjCTcgE0adE0en7Q==
=lrxi
-----END PGP SIGNATURE-----

--YuJye9aIuN0w6xGV--

--===============3476580307002266395==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3476580307002266395==--
