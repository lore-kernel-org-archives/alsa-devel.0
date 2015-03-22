From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 08/10 v3] ASoC: rsnd: don't call
 clk_prepare_enable/unprepare() from inside spin lock
Date: Sun, 22 Mar 2015 18:20:14 +0000
Message-ID: <20150322182014.GZ6643@sirena.org.uk>
References: <87mw39eide.wl%kuninori.morimoto.gx@renesas.com>
 <87bnjpei8l.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5167384815835517807=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 58B432650B4
 for <alsa-devel@alsa-project.org>; Mon, 23 Mar 2015 06:02:03 +0100 (CET)
In-Reply-To: <87bnjpei8l.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, shiiba <naoya.shiiba.nx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, Das Biju <biju.das@bp.renesas.com>
List-Id: alsa-devel@alsa-project.org


--===============5167384815835517807==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xmHgJexE5s//CZci"
Content-Disposition: inline


--xmHgJexE5s//CZci
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 19, 2015 at 04:15:01AM +0000, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> clk_prepare_enable/unprepare() uses mutex inside, and it uses __schedule(=
).
> Then, raw_spin_lock/unlock_irq() is called, and it breaks Renesas
> sound driver's spin lock irq.
> This patch moves clk_prepare_enable/unprepare to out of spin lock area.
> Special thanks to Das Biju.

This is definitely a bug which should be fixed but this means we should
send a fix to Linus rather than having something that depends on -next.
Also...

> +int rsnd_mod_clk(struct rsnd_mod *mod, int enable)
> +{
> +	struct rsnd_priv *priv =3D rsnd_mod_to_priv(mod);
> +	struct device *dev =3D rsnd_priv_to_dev(priv);
> +
> +	/*
> +	 * clk_prepare_enable/unprepare() should not be called
> +	 * from inside spin lock
> +	 */
> +	if (enable)
> +		clk_prepare_enable(mod->clk);
> +	else
> +		clk_disable_unprepare(mod->clk);

It's not entirely clear what this wrapper function is doing (and note
that we don't check the error code from clk_prepare_enable()).

> @@ -345,6 +366,9 @@ static int rsnd_soc_dai_trigger(struct snd_pcm_substr=
eam *substream, int cmd,
>  	int ret;
>  	unsigned long flags;
> =20
> +	if (cmd =3D=3D SNDRV_PCM_TRIGGER_START)
> +		rsnd_dai_call(clk, io, 1);
> +
>  	rsnd_lock(priv, flags);

The trigger function is called from atomic context so this seems to
leave us with the same problem this was supposed to be fixing?

> +static int rsnd_ssi_clk(struct rsnd_mod *mod, int enable)
> +{
> +	struct rsnd_ssi *ssi =3D rsnd_mod_to_ssi(mod);
> +	struct rsnd_dai_stream *io =3D rsnd_mod_to_io(mod);
> +	struct rsnd_dai *rdai =3D rsnd_io_to_rdai(io);
> +
> +	rsnd_mod_clk(mod, enable);
> +
> +	if (rsnd_rdai_is_clk_master(rdai)) {
> +		if (rsnd_ssi_clk_from_parent(ssi))
> +			rsnd_mod_clk(&ssi->parent->mod, enable);
> +	}

This would be clearer with a single if statement with an &&, however it
seems like something that the clock API should be doing itself - it's
already got support for handling enabling of parents.  If we need to
manually handle dependencies (which is what this looks like) that seems
like a problem.

--xmHgJexE5s//CZci
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVDwfdAAoJECTWi3JdVIfQqJAH/28kv50s8J9nAhnm5xRJ+Iz/
hyCpDNmOS6maTDk6MtRUDZwg7zHkGIeDw5GSkkyQMKUkC4f24Z9P9YwK7zQtGsXB
2w43jk8hxDBK7BNE+KiG8NAjj3/V2FSHgiZrA5ZBFw6yHOkvMsJZBZ9k7i+7hkfg
dhip/Y5cvQLvHgdUrq+dkkw+KdwdhYAolScINwaJoXqe/0bGQGlVg8+bFWg3pMXk
y1kmC+5tuRgPGwcDuNA/9LEkNLZf+N7Wz8Rg0/U3ZaqD9Ba0UOs5abHDGlSrr6oD
4pqN0zvFqOjVK2Ig4ApySUa2lvYOa0s33cLrZwIqrlVNNkn7qn+XH0L96DhCgeM=
=dKeg
-----END PGP SIGNATURE-----

--xmHgJexE5s//CZci--

--===============5167384815835517807==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5167384815835517807==--
