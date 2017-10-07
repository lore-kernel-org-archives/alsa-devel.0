From: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: Re: [Patch v6 5/7] slimbus: qcom: Add runtime-pm support using
 clock-pause feature
Date: Sat, 7 Oct 2017 10:22:59 +0200
Message-ID: <20171007082259.kumlkus5mg5eh5cr@latitude>
References: <20171006155136.4682-1-srinivas.kandagatla@linaro.org>
 <20171006155136.4682-6-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ezdii7jlobx6xej4"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171006155136.4682-6-srinivas.kandagatla@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: srinivas.kandagatla@linaro.org
Cc: gregkh@linuxfoundation.org, broonie@kernel.org, alsa-devel@alsa-project.org, sdharia@codeaurora.org, bp@suse.de, poeschel@lemonage.de, treding@nvidia.com, gong.chen@linux.intel.com, andreas.noever@gmail.com, alan@linux.intel.com, mathieu.poirier@linaro.org, daniel@ffwll.ch, jkosina@suse.cz, sharon.dvir1@mail.huji.ac.il, joe@perches.com, davem@davemloft.net, james.hogan@imgtec.com, michael.opdenacker@free-electrons.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kheitke@audience.com, linux-arm-msm@vger.kernel.org, arnd@arndb.de
List-Id: alsa-devel@alsa-project.org


--ezdii7jlobx6xej4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi, some more trivial comments below.

On Fri, Oct 06, 2017 at 05:51:34PM +0200, srinivas.kandagatla@linaro.org wr=
ote:
> From: Sagar Dharia <sdharia@codeaurora.org>
>=20
> Slimbus HW mandates that clock-pause sequence has to be executed
> before disabling relevant interface and core clocks.
> Runtime-PM's autosuspend feature is used here to enter/exit low
> power mode for Qualcomm's Slimbus controller. Autosuspend feature
> enables driver to avoid changing power-modes too frequently since
> entering clock-pause is an expensive sequence
>=20
> Signed-off-by: Sagar Dharia <sdharia@codeaurora.org>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
[...]
> +static int msm_clk_pause_wakeup(struct slim_controller *ctrl)
> +{
> +	struct msm_slim_ctrl *dev =3D slim_get_ctrldata(ctrl);
> +
> +	clk_prepare_enable(dev->hclk);
> +	clk_prepare_enable(dev->rclk);
> +	enable_irq(dev->irq);
> +
> +	writel_relaxed(1, dev->base + FRM_WAKEUP);
> +	/* Make sure framer wakeup write goes through before ISR fires */
> +	mb();
> +	/**

This isn't really a kerneldoc comment.

> +	 * HW Workaround: Currently, slave is reporting lost-sync messages
> +	 * after slimbus comes out of clock pause.
> +	 * Transaction with slave fail before slave reports that message
> +	 * Give some time for that report to come
> +	 * Slimbus wakes up in clock gear 10 at 24.576MHz. With each superframe
> +	 * being 250 usecs, we wait for 5-10 superframes here to ensure
> +	 * we get the message
> +	 */
> +	usleep_range(1250, 2500);
> +	return 0;
> +}
[...]
> +#ifdef CONFIG_PM_SLEEP
> +static int msm_slim_suspend(struct device *dev)
> +{
> +	int ret =3D 0;
> +
> +	if (!pm_runtime_enabled(dev) ||
> +		(!pm_runtime_suspended(dev))) {
> +		dev_dbg(dev, "system suspend");
> +		ret =3D msm_slim_runtime_suspend(dev);
> +	}
> +	if (ret =3D=3D -EISCONN) {
> +	/**

ditto.
Also, it looks misindented.

> +	 * If the clock pause failed due to active channels, there is
> +	 * a possibility that some audio stream is active during suspend.
> +	 * (e.g. modem usecase during suspend)
> +	 * We dont want to return suspend failure in that case so that
> +	 * display and relevant components can still go to suspend.
> +	 * If there is some other error, then it should prevent
> +	 * system level suspend
> +	 */
> +		ret =3D 0;
> +	}
> +	return ret;
> +}


Thanks,
Jonathan Neusch=C3=A4fer

--ezdii7jlobx6xej4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAABAgAGBQJZ2I7aAAoJEAgwRJqO81/bglEP/24cg2BZPl93DsIhXUXqoRO7
Ah5ObC/VnIswHMI8aywhAbovMBq/CR0PGLHlIAEcr23lQevwYdjlxiZ64Dh0PGCP
/C9cnsfg5VnGAh3lZe60sD+euLwYAJux+bVjouRB+P9Q6Ppin8BKbykjh+mkPhQm
tgvagfqkdpt3bCz86l6hECGUpbZkU6HJuMcV8B28buZjoszPA0rVfFzfTo/n6Y/I
yxvUMNfUg/7xc76iQ1R3lecsBQ3gdin4otO1crzvmZGA0A302S8qq6ulXtutFWFH
NPoqW//pZQVpnSdO1RxBVLqWCbtLNVLBpscUjEfNliFIC65Na43NCgFoPbRj0lfd
Kl6iLlwJcCefu2I2NBJOX6ZvJgUxSE1D6NTe38CxJoBkg5QamHVcH20NIwrql73j
WaHZYeKQujrH2u0B0Z/dvWKaV4mOZ4qECyrXhIB4qeefE5traaXDyJfhcTr2Z7M0
mX1F86pNK8b5ejLASCc8k2uJW8e7fHIkjs9a51a13c5vfuizOlucdVcRzdKK3etH
AQ7XTYdB/4dmNaOPl2RSNlntL2aukeL7WNviul9H866FD3nvwl2xlsRMyEjeoxUj
/CuwezwAR5dQGOR4cmsh1gmQuoi2B4olA03a1fmjlTscJhFjoof8mAzyyz9GnwGs
eJFV24oeOEjm9UPXS4mz
=OdJY
-----END PGP SIGNATURE-----

--ezdii7jlobx6xej4--
