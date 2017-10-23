From: Mark Brown <broonie@kernel.org>
Subject: Re: [Patch v6 1/7] slimbus: Device management on SLIMbus
Date: Mon, 23 Oct 2017 11:06:54 +0200
Message-ID: <20171023090654.ydaoom7pye72frvd@sirena.org.uk>
References: <20171006155136.4682-1-srinivas.kandagatla@linaro.org>
 <20171006155136.4682-2-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yvzcuim5ww5lon27"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171006155136.4682-2-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: srinivas.kandagatla@linaro.org
Cc: gregkh@linuxfoundation.org, alsa-devel@alsa-project.org, sdharia@codeaurora.org, bp@suse.de, poeschel@lemonage.de, treding@nvidia.com, gong.chen@linux.intel.com, andreas.noever@gmail.com, alan@linux.intel.com, mathieu.poirier@linaro.org, daniel@ffwll.ch, jkosina@suse.cz, sharon.dvir1@mail.huji.ac.il, joe@perches.com, davem@davemloft.net, james.hogan@imgtec.com, michael.opdenacker@free-electrons.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kheitke@audience.com, linux-arm-msm@vger.kernel.org, arnd@arndb.de
List-Id: alsa-devel@alsa-project.org


--yvzcuim5ww5lon27
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 06, 2017 at 05:51:30PM +0200, srinivas.kandagatla@linaro.org wrote:

> ---
>  Documentation/devicetree/bindings/slimbus/bus.txt |  57 ++
>  Documentation/slimbus/summary                     | 109 ++++

This is a 40k patch which is a bit offputting for review.  Splitting the
docs out would help this a bit.

> +static int slim_boot_child(struct device *dev, void *unused)
> +{
> +	struct slim_driver *sbdrv;
> +	struct slim_device *sbdev = to_slim_device(dev);
> +
> +	if (sbdev && sbdev->dev.driver) {
> +		sbdrv = to_slim_driver(sbdev->dev.driver);
> +		if (sbdrv->boot_device)
> +			sbdrv->boot_device(sbdev);
> +	}
> +	return 0;
> +}

We silently don't boot a device if it hasn't got a driver - is that the
right thing?  It feels like the silencing should be in the calling
function.

> +ret_assigned_laddr:
> +	mutex_unlock(&ctrl->m_ctrl);
> +	if (exists || ret)
> +		return ret;
> +
> +	dev_info(&ctrl->dev, "setting slimbus l-addr:%x, ea:%x,%x,%x,%x\n",
> +		*laddr, e_addr->manf_id, e_addr->prod_code,
> +		e_addr->dev_index, e_addr->instance);

dev_dbg()?

--yvzcuim5ww5lon27
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlntsS0ACgkQJNaLcl1U
h9DF3gf9EmuE2gecayadrX+9wcXYmpFA3V78a7kZmZWzqqjm2pXZ+5Lzo+GwmK0B
ezNv1CxBcHM/SNgO5XgP+ClAHsDd+snyiXDgEEbAs+zaPK3MkUee5JTTFZAhqRZ+
f+81AmCW9CeXOtwJCRnIf7K68//nCCwaPxwxdzYUVgr82mUptOO70E+/yjv/wDMm
D3f7TVCFnHjLxru48Mv0wjhIH2XxoHfUEU9Lo+C+423zheUQoutgpLWV6Cb7O3l0
h/trq6G0TeTop3YFC+zNBgqvzEn3C+PwRP68fLi+falghsi3n7Ep+kZUeQ+EOg3U
6UpbawH7r2/cWNpLnGJ33P59prU2BA==
=1a7F
-----END PGP SIGNATURE-----

--yvzcuim5ww5lon27--
