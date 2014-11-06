From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v3 4/6] ASoC: Intel: mrfld- add ACPI module
Date: Thu, 6 Nov 2014 18:39:09 +0530
Message-ID: <20141106130909.GC1870@intel.com>
References: <1415098520-14113-1-git-send-email-vinod.koul@intel.com>
 <1415098520-14113-5-git-send-email-vinod.koul@intel.com>
 <20141106124349.GB8509@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3649951738701676946=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 507C3260632
 for <alsa-devel@alsa-project.org>; Thu,  6 Nov 2014 14:08:31 +0100 (CET)
In-Reply-To: <20141106124349.GB8509@sirena.org.uk>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============3649951738701676946==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dTy3Mrz/UPE2dbVg"
Content-Disposition: inline


--dTy3Mrz/UPE2dbVg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 06, 2014 at 12:43:49PM +0000, Mark Brown wrote:
> On Tue, Nov 04, 2014 at 04:25:18PM +0530, Vinod Koul wrote:
>=20
> > @@ -323,7 +324,11 @@ EXPORT_SYMBOL_GPL(sst_context_init);
> >  void sst_context_cleanup(struct intel_sst_drv *ctx)
> >  {
> >  	pm_runtime_get_noresume(ctx->dev);
> > +#if IS_ENABLED(CONFIG_ACPI)
> > +	pm_runtime_disable(ctx->dev);
> > +#else
> >  	pm_runtime_forbid(ctx->dev);
> > +#endif
> >  	sst_unregister(ctx->dev);
> >  	sst_set_fw_state_locked(ctx, SST_SHUTDOWN);
> >  	flush_scheduled_work();
>=20
> No, we should be able to build a kernel which runs with or without ACPI
> - make this a runtime check if it's required (a comment might be in
> order too since this is a weird thing to do).
yes that is doable by adding a parameter and setting that in specfic probe,
will add.

>=20
> > @@ -371,8 +376,19 @@ void sst_configure_runtime_pm(struct intel_sst_drv=
 *ctx)
> >  {
> >  	pm_runtime_set_autosuspend_delay(ctx->dev, SST_SUSPEND_DELAY);
> >  	pm_runtime_use_autosuspend(ctx->dev);
> > +#if IS_ENABLED(CONFIG_ACPI)
> > +	/*
> > +	 * For acpi devices, the actual physical device state is
> > +	 * initially active. So change the state to active before
> > +	 * enabling the pm
> > +	 */
> > +	pm_runtime_set_active(ctx->dev);
> > +	pm_runtime_enable(ctx->dev);
> > +	sst_save_shim64(ctx, ctx->shim, ctx->shim_regs64);
> > +#else
> >  	pm_runtime_allow(ctx->dev);
> >  	pm_runtime_put_noidle(ctx->dev);
> > +#endif
>=20
> The general idiom for runtime PM is that we should default to bringing
> the device to power up anyway, that way the kernel continues to work if
> runtime PM has been disabled.
ok

>=20
> > +	/* save the shim registers because PMC doesn't save state */
> > +	if (ctx->dev_id =3D=3D SST_BYT_ACPI_ID)
> > +		sst_save_shim64(ctx, ctx->shim, ctx->shim_regs64);
>=20
> Is there any harm in doing this unconditionally?
Shouldnt be, let me verify

>=20
> > +static acpi_status sst_acpi_mach_match(acpi_handle handle, u32 level,
> > +				       void *context, void **ret)
> > +{
> > +	*(bool *)context =3D true;
> > +	return AE_OK;
> > +}
> > +
> > +static struct sst_machines *sst_acpi_find_machine(
> > +	struct sst_machines *machines)
> > +{
> > +	struct sst_machines *mach;
> > +	bool found =3D false;
> > +
> > +	for (mach =3D machines; mach->codec_id; mach++)
> > +		if (ACPI_SUCCESS(acpi_get_devices(mach->codec_id,
> > +						  sst_acpi_mach_match,
> > +						  &found, NULL)) && found)
> > +			return mach;
>=20
> acpi_get_devices() seems painful.
>=20
> > +#else
> > +int sst_acpi_probe(struct platform_device *pdev)
> > +{
> > +	return -EINVAL;
> > +}
> > +
> > +int sst_acpi_remove(struct platform_device *pdev)
> > +{
> > +	return -EINVAL;
> > +}
> > +#endif
>=20
> Why not just not build this file if !CONFIG_ACPI?
Yes, anway this is only for ACPI systems.

>=20
> > +static struct sst_machines sst_acpi_bytcr[] =3D {
> > +	{"10EC5640", "T100", "bytt100_rt5640", NULL, "fw_sst_0f28.bin",
> > +						&byt_rvp_platform_data },
> > +	{},
> > +};
>=20
> Yay.  Much win.  Not that there's much that can be done at this point.
Yup, hopefully _DSD migration will help us here

--=20
~Vinod

--dTy3Mrz/UPE2dbVg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJUW3L1AAoJEHwUBw8lI4NHrGMP/323urSDd0bOa9SY5zdAoXPk
Ygc1VxihQhuOVoRvwSuqA7D5cZ+g3ONtmugK7nFNHrupLjQIVdaKOuglE/FPWVyV
9em34KovmaxgCL6ucIeZZ9BIWLegrVf5oifofaMrD4KiRw9YYKGOdAOyopdAHJbh
q4w9SZH4ZU79VADCt7n1arXQmVEmsaS9SUnNOYyFWYziq08FKsawknKykdnhSMzV
XfMGjLl392YfdNxN1DG1bNAtvlu++498O0WfDAtoFou3gG3Sr9/kC29O5S5rqcrF
vFJ7d6jQbPfzURmllc8vSOyBhIJ9lGqoQyzm2E729kJWqI4Ujnm+TPbCU1/QQzNG
TFgi5UB5p67hENmvef3cotL/QmsPlDjAMcXZRZprIk622/bB5GcF3fEm7t1KYuP3
Zd3eRLh8YuOUw8BDf2cNwMtT0A/FSPhbAyuuHeCrITfF8QlgAmyatrIo5rP7W2Io
g604+toMzNHA41Mz4NnL1s1Js0MaHR5DHty5S7950a+MKPJSPVQwAwXRP7Yz6Zg3
7bP1Cu0U83s3dfeZd7wemgSfYkclmxnY/+MyJBF9IlcRjMf72VGLDLiz/wGlWQYQ
tmKUF7MnbHjlNr4YD2QayxaeC5qyB0Dunql4ju7A6JSvEmy40eRKT25TwZtyA9ID
L7V3qQHYYIKlvKPS5IL+
=ODw5
-----END PGP SIGNATURE-----

--dTy3Mrz/UPE2dbVg--

--===============3649951738701676946==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3649951738701676946==--
