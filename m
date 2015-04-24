From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC 4/9] ASoC: hda: Add DSP init and boot up
	functionality
Date: Fri, 24 Apr 2015 18:11:40 +0100
Message-ID: <20150424171140.GU22845@sirena.org.uk>
References: <1429276567-29007-1-git-send-email-vinod.koul@intel.com>
 <1429276567-29007-5-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1951999159492685261=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0A5952605CE
 for <alsa-devel@alsa-project.org>; Fri, 24 Apr 2015 19:11:48 +0200 (CEST)
In-Reply-To: <1429276567-29007-5-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, tiwai@suse.de, alsa-devel@alsa-project.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org


--===============1951999159492685261==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DvPFmGkU59k8wvGQ"
Content-Disposition: inline


--DvPFmGkU59k8wvGQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 17, 2015 at 06:46:02PM +0530, Vinod Koul wrote:

> +static int ssth_acquire_irq(struct ssth_lib *ctx)
> +{
> +	if (request_threaded_irq(ctx->irq, ssth_interrupt,
> +			NULL, IRQF_SHARED, KBUILD_MODNAME, ctx)) {
> +		dev_err(ctx->dev, "unable to grab threaded IRQ %d, disabling device\n", ctx->irq);
> +		return -1;

Don't discard the return code, pass it back.  I'm pretty sure the error
wasn't -EPERM anyway.  Though...

> +
> +	/* initialize IPC */
> +	ctx->ipc = ssth_ipc_init(ctx->dev, ctx);
> +	if (ctx->ipc == NULL)
> +		ret = -ENODEV;
> +
> +	/* Now let's request the IRQ */
> +	ssth_acquire_irq(ctx);

..of course we ignore errors anyway.  Why not just inline this?

> +int ssth_dsp_free0(struct ssth_lib *dsp)
> +{
> +	int ret = 0;
> +
> +	dev_dbg(dsp->dev, "In %s\n", __func__);
> +
> +	ssth_ipc_int_disable(dsp);
> +
> +	free_irq(dsp->irq, dsp);
> +	ssth_ipc_free(dsp->ipc);
> +	ssth_disable_dsp_core(dsp);
> +	kfree(dsp);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(ssth_dsp_free0);

free0?

> +bool ssth_dsp_is_running(struct ssth_lib *ctx)
> +{
> +	bool ret = 0;
> +
> +	mutex_lock(&ctx->sst_lock);
> +	ret = (ctx->sst_state == SST_DSP_RUNNING) ? 1 : 0;
> +	mutex_unlock(&ctx->sst_lock);

How does this get used?  The state could change immediately after
returning.  Also no need for the ternery operator there, logic
operations generate logic results anyway.

--DvPFmGkU59k8wvGQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVOnlLAAoJECTWi3JdVIfQcfMH/3duCFsbIifOUEoJDSs93u7b
QOtzAOZuwI3jxe8SiJBI5sYYrdYiXVvSTTZAHBLTvYhyJ3pZ696BDnlqplYdu6gF
OXy1F1VllFA24UhXpnpvqPYlp0AWQisvE/6nFlf/1n91WmRI2lUaipiYwVtDcFxB
MEU/yYpnYeXtjZis7xZEoyXtyjmX7y+WXO2WJIb7HSGYoVtrIbDuAxvv1tAf3TYq
KjXEipR3qPORalLCyf2aNysrISmZmbOtNMG31MU2K9GMDBWRI3+TXEmJjkW8e5hQ
Hl/P3+PsEcQesk5pzytWOdOKHtk4xloKUBA30Axm04g1byM3th67gEnE4e+jWa0=
=rXQN
-----END PGP SIGNATURE-----

--DvPFmGkU59k8wvGQ--

--===============1951999159492685261==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1951999159492685261==--
