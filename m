From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 4/6] ASoC: Intel: mrfld- add ACPI module
Date: Thu, 6 Nov 2014 12:43:49 +0000
Message-ID: <20141106124349.GB8509@sirena.org.uk>
References: <1415098520-14113-1-git-send-email-vinod.koul@intel.com>
 <1415098520-14113-5-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8171997745854102402=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 515CD265114
 for <alsa-devel@alsa-project.org>; Thu,  6 Nov 2014 13:45:08 +0100 (CET)
In-Reply-To: <1415098520-14113-5-git-send-email-vinod.koul@intel.com>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============8171997745854102402==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="T0u6oYl84yPn00Od"
Content-Disposition: inline


--T0u6oYl84yPn00Od
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 04, 2014 at 04:25:18PM +0530, Vinod Koul wrote:

> @@ -323,7 +324,11 @@ EXPORT_SYMBOL_GPL(sst_context_init);
>  void sst_context_cleanup(struct intel_sst_drv *ctx)
>  {
>  	pm_runtime_get_noresume(ctx->dev);
> +#if IS_ENABLED(CONFIG_ACPI)
> +	pm_runtime_disable(ctx->dev);
> +#else
>  	pm_runtime_forbid(ctx->dev);
> +#endif
>  	sst_unregister(ctx->dev);
>  	sst_set_fw_state_locked(ctx, SST_SHUTDOWN);
>  	flush_scheduled_work();

No, we should be able to build a kernel which runs with or without ACPI
- make this a runtime check if it's required (a comment might be in
order too since this is a weird thing to do).

> @@ -371,8 +376,19 @@ void sst_configure_runtime_pm(struct intel_sst_drv *ctx)
>  {
>  	pm_runtime_set_autosuspend_delay(ctx->dev, SST_SUSPEND_DELAY);
>  	pm_runtime_use_autosuspend(ctx->dev);
> +#if IS_ENABLED(CONFIG_ACPI)
> +	/*
> +	 * For acpi devices, the actual physical device state is
> +	 * initially active. So change the state to active before
> +	 * enabling the pm
> +	 */
> +	pm_runtime_set_active(ctx->dev);
> +	pm_runtime_enable(ctx->dev);
> +	sst_save_shim64(ctx, ctx->shim, ctx->shim_regs64);
> +#else
>  	pm_runtime_allow(ctx->dev);
>  	pm_runtime_put_noidle(ctx->dev);
> +#endif

The general idiom for runtime PM is that we should default to bringing
the device to power up anyway, that way the kernel continues to work if
runtime PM has been disabled.

> +	/* save the shim registers because PMC doesn't save state */
> +	if (ctx->dev_id == SST_BYT_ACPI_ID)
> +		sst_save_shim64(ctx, ctx->shim, ctx->shim_regs64);

Is there any harm in doing this unconditionally?

> +static acpi_status sst_acpi_mach_match(acpi_handle handle, u32 level,
> +				       void *context, void **ret)
> +{
> +	*(bool *)context = true;
> +	return AE_OK;
> +}
> +
> +static struct sst_machines *sst_acpi_find_machine(
> +	struct sst_machines *machines)
> +{
> +	struct sst_machines *mach;
> +	bool found = false;
> +
> +	for (mach = machines; mach->codec_id; mach++)
> +		if (ACPI_SUCCESS(acpi_get_devices(mach->codec_id,
> +						  sst_acpi_mach_match,
> +						  &found, NULL)) && found)
> +			return mach;

acpi_get_devices() seems painful.

> +#else
> +int sst_acpi_probe(struct platform_device *pdev)
> +{
> +	return -EINVAL;
> +}
> +
> +int sst_acpi_remove(struct platform_device *pdev)
> +{
> +	return -EINVAL;
> +}
> +#endif

Why not just not build this file if !CONFIG_ACPI?

> +static struct sst_machines sst_acpi_bytcr[] = {
> +	{"10EC5640", "T100", "bytt100_rt5640", NULL, "fw_sst_0f28.bin",
> +						&byt_rvp_platform_data },
> +	{},
> +};

Yay.  Much win.  Not that there's much that can be done at this point.

--T0u6oYl84yPn00Od
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUW20EAAoJECTWi3JdVIfQ0NQH/j+DedCyzaaoAdBqsPDJS1g/
H1vp3839GVX3sj6UHx+Kqna5Kno5gk1hxJdM/uFsUS2PhIAKje8i8rz1UrE1Npqm
/K9bQmM0aPo+mmyHyo0SlWsMe3rhQemtwdxg9x2wmpWgp6YGe8W9mqw0jaV46upI
hzXmhY+hswiA3GTot4kqaloydQO0fwNK09P+xVL5dm2Twg2e+i4HJ64jdTpY3JK9
mQwOVJZPULq351VoaRKrdMEqMikAA8vZFXB/g+l3HZkjBLl/rM5ZLgIELyVO2QJc
vd1zThwrSc05G5MBzlzZMqxPU6aAhRr7a9Rx2q/8eQBrVE9AVgGkS7lm0o58cIs=
=AwSJ
-----END PGP SIGNATURE-----

--T0u6oYl84yPn00Od--

--===============8171997745854102402==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8171997745854102402==--
