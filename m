From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 4/9] ASoC: Intel: Skylake: Add FE and BE
 hw_params handling
Date: Sat, 19 Sep 2015 09:22:10 -0700
Message-ID: <20150919162210.GE30445@sirena.org.uk>
References: <1439832404-12424-1-git-send-email-vinod.koul@intel.com>
 <1439832404-12424-5-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1124728457069682512=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0C1192605D8
 for <alsa-devel@alsa-project.org>; Sun, 20 Sep 2015 02:31:55 +0200 (CEST)
In-Reply-To: <1439832404-12424-5-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============1124728457069682512==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9crTWz/Z+Zyzu20v"
Content-Disposition: inline


--9crTWz/Z+Zyzu20v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 17, 2015 at 10:56:39PM +0530, Vinod Koul wrote:

> +/* Run/Stop the FE pipeline */
> +int skl_tplg_set_fe_pipeline_state(struct snd_soc_dai *dai, bool start,
> +								int stream)
> +{
> +	struct skl *skl =3D get_skl_ctx(dai->dev);
> +	struct skl_sst *ctx =3D skl->skl_sst;
> +	struct skl_module_cfg *mconfig =3D NULL;
> +
> +	dev_dbg(dai->dev, "%s: enter, dai-name=3D%s dir=3D%d\n", __func__, dai-=
>name, stream);
> +
> +	mconfig =3D skl_tplg_fe_get_cpr_module(dai, stream);
> +	if (mconfig !=3D NULL) {
> +		if (start)
> +			return skl_run_pipe(ctx, mconfig->pipe);
> +		else
> +			return skl_stop_pipe(ctx, mconfig->pipe);
> +	}
> +
> +	return 0;
> +}

Another one of these wrappers with basically no shared code :( =20

--9crTWz/Z+Zyzu20v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV/YuxAAoJECTWi3JdVIfQS5cH/AxDd3PrQQCPN2zWRI9grVFG
JhlP/Q6R3IrYhcS6f7+mfL44fJSvFeDTgQBEr89wmHp+gyMjFLt1kuyjC8mlXJUB
9dEEpSv2a0Y7pxCXvrFzPa02SG7AMdcCRAZZY2lOwWQZl5G4HzWuaZjTgFBlFmi/
HIhJj0L9RFVaB+if8HWeNb0YLugc9pYQWKVsfeivdTjYN9sPaD0gnneojWnLfahc
jBKWo25pS/4xLJXSUpUR/m6vhuvvg+90I81P2iAce25Vi0TCk+MrWg+to664/PRO
hxra89CuXf6iYaaiWVMk2vJsJtGXblaSPwApah5NSyaKMJtIjDjl1PjbfAY1tJc=
=xkwb
-----END PGP SIGNATURE-----

--9crTWz/Z+Zyzu20v--

--===============1124728457069682512==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1124728457069682512==--
