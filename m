From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/3] ASoC: simple-card: make sysclk index
	configurable
Date: Tue, 29 May 2018 12:24:47 +0100
Message-ID: <20180529112447.GC23509@sirena.org.uk>
References: <20180528193503.18905-1-daniel@zonque.org>
 <20180528193503.18905-3-daniel@zonque.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8648798941008440712=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id C6C6226763F
 for <alsa-devel@alsa-project.org>; Tue, 29 May 2018 13:24:49 +0200 (CEST)
In-Reply-To: <20180528193503.18905-3-daniel@zonque.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@zonque.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, lgirdwood@gmail.com, kuninori.morimoto.gx@renesas.com
List-Id: alsa-devel@alsa-project.org


--===============8648798941008440712==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oJ71EGRlYNjSvfq7"
Content-Disposition: inline


--oJ71EGRlYNjSvfq7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 28, 2018 at 09:35:02PM +0200, Daniel Mack wrote:
> The simple-card driver currently hard-codes the clk_id parameter in
> snd_soc_dai_set_sysclk() to 0. Make this configrable for both CPU and
> codec dai sub-nodes.

> This still has the limitation that only one clk_id can be configured, but it
> should help some more platforms to use simple-card in favor to a more
> specific machine driver.

If we want to get more complex usage of clocks in the DT we should be
moving the CODECs over to using the standard clock bindings for this
stuff rather than inventing custom ASoC clock bindings for it.  That way
we don't have to deal with the pain of trying to join things up in the
future.

As a practical matter we also don't have any CODECs specifying any
bindings for ASoC level clock IDs right now either.

--oJ71EGRlYNjSvfq7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsNOH4ACgkQJNaLcl1U
h9Bqawf/aeT6yE81J0OddBUC3umFgqaTPbW5SwsxTmPbem8FRYgRQmeQ2SxcGuwH
9lD0dVZB/9d/twjT5dPwE+Tq/F4oRhegHuHlxGZsha473Di91dPfyMJDhTdhvhux
dLE54B+gLIjzPm+ceKUlwdDUnY7kpBH0ZUnvWFRbOyg/mK0pssWFWiJkDkJi+8Jm
sAAjFKPnmu/zCGd41+XBHLWc4Z1qzXso/NsZPH3czakHGGhR1tB77J5kXYF3gVAD
Nlyf7JXJjLyK9gL9acno/nXM/fqd8oGs5JQVCkXslUd2hZmY+0G0p9ZSvq9JFAEQ
DAuSGKw3Cs3r+TZA2bSTsUZgjPczqg==
=zezX
-----END PGP SIGNATURE-----

--oJ71EGRlYNjSvfq7--

--===============8648798941008440712==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8648798941008440712==--
