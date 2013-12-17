From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: dmaengine: Add config parameter NULL
	check.
Date: Tue, 17 Dec 2013 11:18:16 +0000
Message-ID: <20131217111816.GN3185@sirena.org.uk>
References: <1387264600-14225-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0312322887503963325=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 9D7E8260890
 for <alsa-devel@alsa-project.org>; Tue, 17 Dec 2013 12:18:24 +0100 (CET)
In-Reply-To: <1387264600-14225-1-git-send-email-Li.Xiubo@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Xiubo Li <Li.Xiubo@freescale.com>
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, tiwai@suse.de, linux-kernel@vger.kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============0312322887503963325==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oMYUQGQaTbnds07l"
Content-Disposition: inline


--oMYUQGQaTbnds07l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 17, 2013 at 03:16:40PM +0800, Xiubo Li wrote:
> Because the "ASoC: dmaengine-pcm: Provide default config" has provided
> us one defualt config of DMA. When using this, the config parameter of
> devm_snd_dmaengine_pcm_register() will be NULL, so here we need to have
> a check before using it.

Applied, thanks.

--oMYUQGQaTbnds07l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSsDL0AAoJELSic+t+oim979YP/jeJcXPbJHMfVQngwCz5l9rt
vGK27S1M2fDu2S/RCD5l2GUioc7iuz068N8K96/CHjbsv3kazotaPgK4G3KCRW9G
HqbdzXV1DW0taqhdKFOAEjwZwMPOW//i6I2+DSiRdtN9wqPDoRieM20OwUZTOgeB
HZHiOH42YY5p09AmJHCW87NFWAvGcA5xT8J4btKRtG+sxM9Ps0EJRxZT/a3MvgrM
Oc1cgJTKsVWvZUDXAmepvH7ZgO14nKodfoUQQP4SNUUYSPfrtStMzeBVck+GuX7B
o/0LwAYY0Q7qf5H5Nmv/K6CsUPm5lBg/tRt9LNqXj5LP2wOBOo80bYUS+P+XMIq+
TGnJy6n0ydZBriR9wMRurWhZjHqd48zqabF2UVZmdgeR6RRToDlJTexCgpmAsMj9
UNozTqdnVd2n7QsdPLAAq4e+27jlMKDRoHw8vysr3J4Z2wVWrpl64XLQNyH4xux2
MIOIc2EDcXsZGVt2NfArkhyxooqDsbVkcpz0uubdLJVOLl6pIs8xrkcpyVQbSd6g
W/gptQKmh1GSiBDijO1a0RKLPUD4aq7rMdmRfOEc4Fi5FUQilmPUjerqdKDIxKs1
fFBpKA76y4mLeENvlGnTysfnAvS1RsJhdEW2up+hfv7+uGfZwWgez/6433FYtNHW
AelZ/XjDXKazQXdgcc9C
=8huy
-----END PGP SIGNATURE-----

--oMYUQGQaTbnds07l--

--===============0312322887503963325==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0312322887503963325==--
