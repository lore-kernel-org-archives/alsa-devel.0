From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/9] ASoC: Intel: Skylake: Add pipe and
 modules handlers
Date: Sat, 19 Sep 2015 09:00:23 -0700
Message-ID: <20150919160023.GC30445@sirena.org.uk>
References: <1439832404-12424-2-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4289908835730157205=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2194B266015
 for <alsa-devel@alsa-project.org>; Sun, 20 Sep 2015 02:32:53 +0200 (CEST)
In-Reply-To: <1439832404-12424-2-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: patches.audio@intel.com, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============4289908835730157205==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vOmOzSkFvhd7u8Ms"
Content-Disposition: inline


--vOmOzSkFvhd7u8Ms
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 17, 2015 at 10:56:36PM +0530, Vinod Koul wrote:

> +static int skl_tplg_bind_unbind_pipes(struct skl_module_cfg *src_module,
> +	struct skl_module_cfg *sink_module, struct skl_sst *ctx, bool bind)
> +{
> +	int ret;
> +
> +	if (!bind) {
> +		ret =3D skl_stop_pipe(ctx, src_module->pipe);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret =3D skl_unbind_modules(ctx, src_module, sink_module);
> +	} else {
> +		ret =3D skl_bind_modules(ctx, src_module, sink_module);
> +	}
> +
> +	return ret;
> +}

Can we *please* stop having these functions which optionally do several
different things with nothing at all shared between the different paths?
It just adds a layer of indentation in the function and makes everything
harder to read (including at the call site - how does the reader know if
a given call will bind or unbind?).

I'm sure I've raised this before.

> +static bool skl_tplg_is_pipe_mem_available(struct skl *skl,
> +                               struct skl_module_cfg *mconfig)

I'm not seeing any users of this function (unlike the mcps checker).

> +	if (skl->resource.mem + mconfig->pipe->memory_pages > skl->resource.max=
_mem) {
> +		dev_err(ctx->dev, "exceeds ppl memory available=3D%d > mem=3D%d\n",
> +				skl->resource.max_mem, skl->resource.mem);
> +		return false;
> +	}

I'm not sure how the user is going to be able to tell what exceeded the
maximum memory here. =20

> +static bool skl_tplg_is_pipe_mcps_available(struct skl *skl,
> +				struct skl_module_cfg *mconfig)

This looks an awful lot like the memory check.  Can we make a struct or
ideally array for the constraints and then have a single function which
checks them all?

> +	list_for_each_entry(p, &w->sinks, list_source) {
> +		if ((p->sink->priv =3D=3D NULL)
> +			&& (!is_skl_dsp_widget_type(w)))
> +			continue;
> +
> +		if ((p->sink->priv !=3D NULL) && (p->connect)
> +			&& (is_skl_dsp_widget_type(p->sink))) {

This is harder to read with the extra brackets.

--vOmOzSkFvhd7u8Ms
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV/YaTAAoJECTWi3JdVIfQ58wH+wZsDdTw/ZucWHMSY2sp8xKE
Ku2WvIWYkZZNaKdLPihajRpkiVmYXhhZlNNlkQq2Gyj3+4PWhcr3PMAq9PeFf3iZ
nDSfIi5Ao+TrIaaSWS6ASPkz6DuS9rsEVXzBZfEDJQBXMsoh6J907DSMv0rlSSsl
zc/5eXFOslh3x3RhxAPAk169LffDkMl34ooCf6V+kjXCwHSb60Zwjrb+LxWeuR2L
chxndKsYYNRVLnkfuM8YemTKDudb3ZEr/OydJ0YU3DWn+utWvVyKCNiXLG4z+TPI
QRkrQV/sFWDA8+r+mKOfAMO5vvQP1MV64Kfx519+Lins14QQqj9z8/aG1Q7vJ9s=
=0hIw
-----END PGP SIGNATURE-----

--vOmOzSkFvhd7u8Ms--

--===============4289908835730157205==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4289908835730157205==--
