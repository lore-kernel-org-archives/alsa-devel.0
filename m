From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [RFC 4/9] ASoC: hda: Add DSP init and boot up
	functionality
Date: Sun, 26 Apr 2015 19:51:15 +0530
Message-ID: <20150426142115.GT2738@intel.com>
References: <1429276567-29007-1-git-send-email-vinod.koul@intel.com>
 <1429276567-29007-5-git-send-email-vinod.koul@intel.com>
 <20150424171140.GU22845@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5032364438551144900=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id AD8562606AC
 for <alsa-devel@alsa-project.org>; Sun, 26 Apr 2015 16:24:04 +0200 (CEST)
In-Reply-To: <20150424171140.GU22845@sirena.org.uk>
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
Cc: liam.r.girdwood@linux.intel.com, tiwai@suse.de, alsa-devel@alsa-project.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org


--===============5032364438551144900==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="x1F0m3RQhDZyj8sd"
Content-Disposition: inline


--x1F0m3RQhDZyj8sd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 24, 2015 at 06:11:40PM +0100, Mark Brown wrote:
> On Fri, Apr 17, 2015 at 06:46:02PM +0530, Vinod Koul wrote:
>=20
> > +static int ssth_acquire_irq(struct ssth_lib *ctx)
> > +{
> > +	if (request_threaded_irq(ctx->irq, ssth_interrupt,
> > +			NULL, IRQF_SHARED, KBUILD_MODNAME, ctx)) {
> > +		dev_err(ctx->dev, "unable to grab threaded IRQ %d, disabling device\=
n", ctx->irq);
> > +		return -1;
>=20
> Don't discard the return code, pass it back.  I'm pretty sure the error
> wasn't -EPERM anyway.  Though...
yes, we will fix it

>=20
> > +
> > +	/* initialize IPC */
> > +	ctx->ipc =3D ssth_ipc_init(ctx->dev, ctx);
> > +	if (ctx->ipc =3D=3D NULL)
> > +		ret =3D -ENODEV;
> > +
> > +	/* Now let's request the IRQ */
> > +	ssth_acquire_irq(ctx);
>=20
> ..of course we ignore errors anyway.  Why not just inline this?
thats not right, we should do that...

>=20
> > +int ssth_dsp_free0(struct ssth_lib *dsp)
> > +{
> > +	int ret =3D 0;
> > +
> > +	dev_dbg(dsp->dev, "In %s\n", __func__);
> > +
> > +	ssth_ipc_int_disable(dsp);
> > +
> > +	free_irq(dsp->irq, dsp);
> > +	ssth_ipc_free(dsp->ipc);
> > +	ssth_disable_dsp_core(dsp);
> > +	kfree(dsp);
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(ssth_dsp_free0);
>=20
> free0?
crap, will fix

>=20
> > +bool ssth_dsp_is_running(struct ssth_lib *ctx)
> > +{
> > +	bool ret =3D 0;
> > +
> > +	mutex_lock(&ctx->sst_lock);
> > +	ret =3D (ctx->sst_state =3D=3D SST_DSP_RUNNING) ? 1 : 0;
> > +	mutex_unlock(&ctx->sst_lock);
>=20
> How does this get used?  The state could change immediately after
> returning.  Also no need for the ternery operator there, logic
> operations generate logic results anyway.
yes you are right, we should hold the lock and check, will fix this

Thanks
--=20
~Vinod

--x1F0m3RQhDZyj8sd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJVPPRbAAoJEHwUBw8lI4NHMOYP/2NyAGi4uQVrfFKq9ODLhbBH
d3WmhMOlfto2N8vz+f9pdJNNBJheVnVZMdSUDbA+ghRnELkMGvbSxNZ3hJjO3btU
InkW9magEa4ZlkcYLdV2EDNad2HDHiwj5soLETw6d2jJW36j1WlnGTYJTNUS5Zi8
t4JR+YA4kf54jnjrZDiElrQ3Fd7x2o1UsbnX1tLHO2U0b4j/FxC5Tv9eCaSV2/xo
WdV0jsn/My2bwoZDgVW2rUMvLYwETXbUlcaKyEuUux5ZcjTNRxELl97NmxCjQ+rU
fCDVQGJ/1GIk+uBmLFCuZxTh9lXRSNfp0h1tLCiFAG/KVzsKZm6CiNCbkHxFzk2B
D8/CQtnNnfGMiWqIpdVmA4oadUj+FxksF8GtO13BmDHyUAoiu/vd5sKqv+LbMFm0
EA1ONaBkZVW1KAK+ZOIRk69n4F5uiSS1fS0yNxYTlZZNDTYl/ts8ZUkoNDQ9YyxE
Vpm7Ri1BMOk06WwyGHacLfjJkufKqatRPRLSfa9Gao1QHRKAzOjP4lbpof2k4FFa
+Bon98C50Lzp0aKIE0irhnyjYZJjyVGUGq2IlUjR3F0XahOk/om1APPkAISMF96m
hiBdsFdL0srwSsCBgMZtcJ6tVoJ2DyKRdxbqJEUj/pfe8rW7YzxJabTXuXinHrB1
WATfmSRZcP8OxSJH+VeB
=QZHb
-----END PGP SIGNATURE-----

--x1F0m3RQhDZyj8sd--

--===============5032364438551144900==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5032364438551144900==--
