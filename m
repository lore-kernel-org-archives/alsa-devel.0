From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 5/7] ASoC: Intel: sst: add power management
	handling
Date: Fri, 18 Jul 2014 19:53:09 +0530
Message-ID: <20140718142309.GF1985@intel.com>
References: <1404898076-1882-1-git-send-email-vinod.koul@intel.com>
 <1404898076-1882-6-git-send-email-vinod.koul@intel.com>
 <20140718114611.GM17528@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5975677630814844165=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 1E0182608D3
 for <alsa-devel@alsa-project.org>; Fri, 18 Jul 2014 16:27:19 +0200 (CEST)
In-Reply-To: <20140718114611.GM17528@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============5975677630814844165==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hOcCNbCCxyk/YU74"
Content-Disposition: inline


--hOcCNbCCxyk/YU74
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 18, 2014 at 12:46:11PM +0100, Mark Brown wrote:
> On Wed, Jul 09, 2014 at 02:57:53PM +0530, Vinod Koul wrote:
>=20
> > +static int sst_save_dsp_context_v2(struct intel_sst_drv *sst)
>=20
> _v2?
v1 support older moorestown platforms. SO v2 here :)
>=20
> > +static int intel_sst_runtime_suspend(struct device *dev)
> > +{
> > +	int ret =3D 0;
> > +	struct intel_sst_drv *ctx =3D dev_get_drvdata(dev);
> > +
> > +	pr_info("runtime_suspend called\n");
>=20
> This is way too noisy.
>=20
> > +	if (ctx->sst_state =3D=3D SST_RESET) {
> > +		pr_debug("LPE is already in RESET state, No action");
> > +		return 0;
> > +	}
> > +	/*save fw context*/
> > +	if (ctx->ops->save_dsp_context(ctx))
> > +		return -EBUSY;
> > +
> > +	/* Move the SST state to Reset */
> > +	sst_set_fw_state_locked(ctx, SST_RESET);
> > +
> > +	flush_workqueue(ctx->post_msg_wq);
> > +	synchronize_irq(ctx->irq_num);
>=20
> This is very strange - we're flushing the work *after* resetting the DSP
> which suggests there might be something else trying to access the DSP
> while it is being put into reset.  Presumably that'd be bad.
the macro sst_set_fw_state_locked is used here :)

And state is marked reset, we dont do HW reset, so this is okay. After we r=
eturn the
suspend handler, PCI will put the device to D3.
=20
> > +	/* When fw_clear_cache is set, clear the cached firmware copy */
> > +	/* fw_clear_cache is set through debugfs support */
> > +	if (atomic_read(&ctx->fw_clear_cache) && ctx->fw_in_mem) {
>=20
> Why?  It'd seem more direct to just have the debugfs write trigger
> trashing of the firmware on demand...
That would work too but then sequencing the DSP while running would cause
issues elsewhere. Since we dont have debugs support in the series we cna
push this bits later when we send debugfs series amoung others :)

> > +static int intel_sst_suspend(struct device *dev)
> > +{
> > +
> > +	return intel_sst_runtime_suspend(dev);
> > +}
>=20
> You currently need to check that the device isn't runtime suspended
> before you try to reuse runtime PM ops in suspend.
Sorry didnt quite get why?

>=20
> > +static int intel_sst_runtime_idle(struct device *dev)
> > +{
> > +	struct intel_sst_drv *ctx =3D dev_get_drvdata(dev);
> > +
> > +	pr_info("runtime_idle called\n");
> > +	if (ctx->sst_state !=3D SST_RESET) {
> > +		pm_schedule_suspend(dev, SST_SUSPEND_DELAY);
> > +		return -EBUSY;
> > +	} else {
> > +		return 0;
> > +	}
> > +	return -EBUSY;
> > +
> > +}
>=20
> This is very strange, what is going on?
schedule suspend after SST_SUSPEND_DELAY. This should be updated with PM
framework calls for delay, will update


--=20
~Vinod

--hOcCNbCCxyk/YU74
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJTyS3NAAoJEHwUBw8lI4NHFoUP/2B3PvowkNwG8F530ZKfhl6V
kxjtyAQtrdu3upSp1rXAceMbBGv7m0uVPiK7DgDvOd3kJ3VMzY1VDTBDVzbfbfxR
QeLwG/akUI8layudKgfYMPvbAjBxpeZ92M/dg0NnEdQfDZr5qApWL0uNMwFwKaql
tT2FWOJG1+4e/fczWA4gHm1KSrmojcIhkfXg2Q+m5kT6Or3yxMPSzHm8X85ZnUK5
yACIfX232ZZE4wqmv77WHwWXRhAcmwLdg3g2WMUXivw9KuLwJ0zHpLAI3wLbHViI
Frrh46GOxanJ29LjZluv33H1lHxtJOy9KERKmHcEn4o9GFL+kGFvuAorNXOqWUsz
TL5Zi5WwsfaEsnxZmqROLrZsctQVDtKKyea7QYPPDwXcccnoc2/Yq9DpMnrYvxr5
OGE5qwhQ0xioCA1wKx68vvSlrJZxKn6foQT+JbDxpuyEt8QERHKUOieivHv+b7jB
WasS7H2+0NimB1ZPtAYB2QdbuQSeZDUQRj/EVuJQaeYiNTjF59O1yBBDHpV0isFm
NojkX/SWUg7bWmKqDrYij+ppvNUFqh1+bSvVF2GRSuAfbEJCkucBT0wdZBHrwJmQ
OORJS+hbjjlDbBuenefhd3uOqKxAFAHpEjNDdNqAIPo9Lbp/WvV3ysoqEZmWws3V
DF0eQZO7LEAGz2G+JEf1
=Zkqk
-----END PGP SIGNATURE-----

--hOcCNbCCxyk/YU74--

--===============5975677630814844165==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5975677630814844165==--
