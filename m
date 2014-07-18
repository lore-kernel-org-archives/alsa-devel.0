From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 5/7] ASoC: Intel: sst: add power management
	handling
Date: Fri, 18 Jul 2014 12:46:11 +0100
Message-ID: <20140718114611.GM17528@sirena.org.uk>
References: <1404898076-1882-1-git-send-email-vinod.koul@intel.com>
 <1404898076-1882-6-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4939563591337440406=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1177B2655ED
 for <alsa-devel@alsa-project.org>; Fri, 18 Jul 2014 13:46:31 +0200 (CEST)
In-Reply-To: <1404898076-1882-6-git-send-email-vinod.koul@intel.com>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============4939563591337440406==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZcSASNCKFtrdv99s"
Content-Disposition: inline


--ZcSASNCKFtrdv99s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 09, 2014 at 02:57:53PM +0530, Vinod Koul wrote:

> +static int sst_save_dsp_context_v2(struct intel_sst_drv *sst)

_v2?

> +static int intel_sst_runtime_suspend(struct device *dev)
> +{
> +	int ret = 0;
> +	struct intel_sst_drv *ctx = dev_get_drvdata(dev);
> +
> +	pr_info("runtime_suspend called\n");

This is way too noisy.

> +	if (ctx->sst_state == SST_RESET) {
> +		pr_debug("LPE is already in RESET state, No action");
> +		return 0;
> +	}
> +	/*save fw context*/
> +	if (ctx->ops->save_dsp_context(ctx))
> +		return -EBUSY;
> +
> +	/* Move the SST state to Reset */
> +	sst_set_fw_state_locked(ctx, SST_RESET);
> +
> +	flush_workqueue(ctx->post_msg_wq);
> +	synchronize_irq(ctx->irq_num);

This is very strange - we're flushing the work *after* resetting the DSP
which suggests there might be something else trying to access the DSP
while it is being put into reset.  Presumably that'd be bad.

> +	/* When fw_clear_cache is set, clear the cached firmware copy */
> +	/* fw_clear_cache is set through debugfs support */
> +	if (atomic_read(&ctx->fw_clear_cache) && ctx->fw_in_mem) {

Why?  It'd seem more direct to just have the debugfs write trigger
trashing of the firmware on demand...

> +static int intel_sst_suspend(struct device *dev)
> +{
> +
> +	return intel_sst_runtime_suspend(dev);
> +}

You currently need to check that the device isn't runtime suspended
before you try to reuse runtime PM ops in suspend.

> +static int intel_sst_runtime_idle(struct device *dev)
> +{
> +	struct intel_sst_drv *ctx = dev_get_drvdata(dev);
> +
> +	pr_info("runtime_idle called\n");
> +	if (ctx->sst_state != SST_RESET) {
> +		pm_schedule_suspend(dev, SST_SUSPEND_DELAY);
> +		return -EBUSY;
> +	} else {
> +		return 0;
> +	}
> +	return -EBUSY;
> +
> +}

This is very strange, what is going on?

--ZcSASNCKFtrdv99s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTyQkAAAoJELSic+t+oim92NUP+gN6QqtozcFfWaQR6nx702WS
COkGqszfqPITbELJBGVO2dtXFFv1vL1lfaySvsaovEiAtn+DLOP7V+MUO0YzFx7p
8cJ16ItfqKuJW4q9HXXmNibvkvDrdcPDADkUl+3QolO1dmiNCSthAuz+n7ng9LM/
w874Imvlx51cRIlWzsSlaU/jz2iw38K1KTjmNyAupS5xs2+iLvPtXuxKeG3KybFe
mPattOAsxMbCuWn2VpmIvO50zz854HdO9LEUqbwZ+q7wLieii8meWd+bD085WEf2
gtZCX0ysMatxPEiDya0uwtj9VLyapekHqzs6YafNb2oIC6KyC3Ckm6BFLxv4w1HD
3SIFM2DD43Vnvf8u2tXyGQ10fs417S2B1ISMPkUn4tRKUfvpOG6hwWXW92enrFY/
lsnNRGS2HSeJDsg7IZe/mvHf45FYkCAPgzunQ8qdY41q2RDwU0CqBv299wnVJCO0
IQwdtdbSl8W5SXp1bH4InQeYNPUzGJG54SDXVKF4pAJiLd4pQnX7qK0yI4ux6Oa/
nLiMw23/ujwYN+83iRC2gaiLY8VTLaFQHAXTSVSkTGwt2Lm4eUL7t07lRpJ4sq9A
MH2CNVaECdBkljJeENHUqTdtZUtghiIg53bMguOTCPiUBVN0P6VRPi/9syA/epSx
fiT+Pb/cy/CpbEsw01Tq
=Bydq
-----END PGP SIGNATURE-----

--ZcSASNCKFtrdv99s--

--===============4939563591337440406==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4939563591337440406==--
