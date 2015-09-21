From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 1/9] ASoC: Intel: Skylake: Add pipe and
 modules handlers
Date: Mon, 21 Sep 2015 09:07:13 +0530
Message-ID: <20150921033713.GF2381@localhost>
References: <1439832404-12424-2-git-send-email-vinod.koul@intel.com>
 <20150919160023.GC30445@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6559987227408012352=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id C5C28260537
 for <alsa-devel@alsa-project.org>; Mon, 21 Sep 2015 05:34:32 +0200 (CEST)
In-Reply-To: <20150919160023.GC30445@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: patches.audio@intel.com, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============6559987227408012352==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FFoLq8A0u+X9iRU8"
Content-Disposition: inline


--FFoLq8A0u+X9iRU8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 19, 2015 at 09:00:23AM -0700, Mark Brown wrote:
> On Mon, Aug 17, 2015 at 10:56:36PM +0530, Vinod Koul wrote:
>=20
> > +static int skl_tplg_bind_unbind_pipes(struct skl_module_cfg *src_modul=
e,
> > +	struct skl_module_cfg *sink_module, struct skl_sst *ctx, bool bind)
> > +{
> > +	int ret;
> > +
> > +	if (!bind) {
> > +		ret =3D skl_stop_pipe(ctx, src_module->pipe);
> > +		if (ret < 0)
> > +			return ret;
> > +
> > +		ret =3D skl_unbind_modules(ctx, src_module, sink_module);
> > +	} else {
> > +		ret =3D skl_bind_modules(ctx, src_module, sink_module);
> > +	}
> > +
> > +	return ret;
> > +}
>=20
> Can we *please* stop having these functions which optionally do several
> different things with nothing at all shared between the different paths?
> It just adds a layer of indentation in the function and makes everything
> harder to read (including at the call site - how does the reader know if
> a given call will bind or unbind?).

Well while reading based on the argument bind we would know if we are doing
bind or unbind. While binding we call only bind. On unbind we have to stop
and then unbind.

I will remove this and few other wrappers like this which will help in
readability and reviews

>=20
> I'm sure I've raised this before.
Sorry to miss that, will fix this time for sure


> > +static bool skl_tplg_is_pipe_mem_available(struct skl *skl,
> > +                               struct skl_module_cfg *mconfig)
>=20
> I'm not seeing any users of this function (unlike the mcps checker).

It is called in skl_tplg_mixer_dapm_pre_pmu_event() which is in Patch 3 of
this series.

> > +	if (skl->resource.mem + mconfig->pipe->memory_pages > skl->resource.m=
ax_mem) {
> > +		dev_err(ctx->dev, "exceeds ppl memory available=3D%d > mem=3D%d\n",
> > +				skl->resource.max_mem, skl->resource.mem);
> > +		return false;
> > +	}
>=20
> I'm not sure how the user is going to be able to tell what exceeded the
> maximum memory here. =20

Module Id and Instance Id are printed before this but yes that is debug, so
merging the two to error alone makes sense, will do that here


> > +static bool skl_tplg_is_pipe_mcps_available(struct skl *skl,
> > +				struct skl_module_cfg *mconfig)
>=20
> This looks an awful lot like the memory check.  Can we make a struct or
> ideally array for the constraints and then have a single function which
> checks them all?

No it only two checks, one for MCPS and one for memory. We cannot have
single function as they are checked at two places. Due to FW construction.
MCPS is property of each module whereas memory is for complete pipe.
For each module while initialization we check MCPS whereas for pipe creation
we check memory


> > +	list_for_each_entry(p, &w->sinks, list_source) {
> > +		if ((p->sink->priv =3D=3D NULL)
> > +			&& (!is_skl_dsp_widget_type(w)))
> > +			continue;
> > +
> > +		if ((p->sink->priv !=3D NULL) && (p->connect)
> > +			&& (is_skl_dsp_widget_type(p->sink))) {
>=20
> This is harder to read with the extra brackets.
Will fix this

--=20
~Vinod

--FFoLq8A0u+X9iRU8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJV/3tpAAoJEHwUBw8lI4NHQAsP/jL5rYLJKsI7Y2OuJoP1SojW
fQhurKJH8VIi/BRg0fSXmOQlFhWJRKdknAjNOUdJvREzGJLBLkPx47E5Mg43KW2Y
/1MnV3k5Sc+tITZw/AKKgR+5pcAdmBRXkckE0mXZeiJXndLfQiDyiIQxnyP/18Gz
dlg8R6r/zNHWF4SD97W1ANOx0oWH85Yx+29oeK0e+h3AIIF2jV3KslmFsQptJ5L9
ePEeVzQ2ZXkyyDTQaYNz8oh2IuT3wA3e5HRvEwRQhfDt3xi7WVsU8QnujyLEMZUc
u6C8FS4VxH06+3L7J5w2nDQ+0Bv50KpDuLCo7A3qt2QjRtKC4NyWlsCmoFTLTJHV
Tdo82cCCOrbO8ut0hXV9N4tgj5FSnf+oy0B7QlJG5aYBy/2/k6JZ/gNR5rLtZbSw
PhOejZ2KK3pJv6Pkn22Htd0w/bf5VFiwCDpAjraJsyblK4ohlxFQPya9f5j++Rf+
Rq2BqESu7nd9rs2g+/BYmoX7uYBCbNOiEY1nSGUbnvhP6mL/FCccXjHOj1pJahig
fWkLTYFZgG8WKtEKB+OIR/4Kh8eBb9+yuYqTRI5X/MXl08cSu32kJT5eimv66Cy/
EzghPObHWn3BuJufnUWbpgFFb5NlO0fIoZ7gbynxcIhXv2AScBurFdlKGbQZe30/
FNAm2nAcH8JaKXXCFmpk
=a8ja
-----END PGP SIGNATURE-----

--FFoLq8A0u+X9iRU8--

--===============6559987227408012352==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6559987227408012352==--
