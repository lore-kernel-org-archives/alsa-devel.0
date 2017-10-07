From: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: Re: [Patch v6 4/7] slimbus: Add support for 'clock-pause' feature
Date: Sat, 7 Oct 2017 10:06:25 +0200
Message-ID: <20171007080625.gotgts2ssgacawpx@latitude>
References: <20171006155136.4682-1-srinivas.kandagatla@linaro.org>
 <20171006155136.4682-5-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="gjykqnoluazweuwr"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171006155136.4682-5-srinivas.kandagatla@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: srinivas.kandagatla@linaro.org
Cc: gregkh@linuxfoundation.org, broonie@kernel.org, alsa-devel@alsa-project.org, sdharia@codeaurora.org, bp@suse.de, poeschel@lemonage.de, treding@nvidia.com, gong.chen@linux.intel.com, andreas.noever@gmail.com, alan@linux.intel.com, mathieu.poirier@linaro.org, daniel@ffwll.ch, jkosina@suse.cz, sharon.dvir1@mail.huji.ac.il, joe@perches.com, davem@davemloft.net, james.hogan@imgtec.com, michael.opdenacker@free-electrons.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kheitke@audience.com, linux-arm-msm@vger.kernel.org, arnd@arndb.de
List-Id: alsa-devel@alsa-project.org


--gjykqnoluazweuwr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi, some trivial comments below.

On Fri, Oct 06, 2017 at 05:51:33PM +0200, srinivas.kandagatla@linaro.org wr=
ote:
> From: Sagar Dharia <sdharia@codeaurora.org>
>=20
> Per slimbus specification, a reconfiguration sequence known as
> 'clock pause' needs to be broadcast over the bus while entering low-
> power mode. Clock-pause is initiated by the controller driver.
> To exit clock-pause, controller typically wakes up the framer device.
> Since wakeup precedure is controller-specific, framework calls it via
> controller's function pointer to invoke it.
>=20
> Signed-off-by: Sagar Dharia <sdharia@codeaurora.org>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
[...]
> @@ -429,6 +444,14 @@ void slim_return_tx(struct slim_controller *ctrl, in=
t err)
>  		cur.cb(cur.ctx, err);
> =20
>  	up(&ctrl->tx_sem);
> +	if (!cur.clk_pause && (!cur.need_tid || err)) {
> +		/**

This isn't really a kerneldoc comment.

> +		 * remove runtime-pm vote if this was TX only, or
> +		 * if there was error during this transaction
> +		 */
> +		pm_runtime_mark_last_busy(ctrl->dev.parent);
> +		pm_runtime_put_autosuspend(ctrl->dev.parent);
> +	}
>  }
>  EXPORT_SYMBOL_GPL(slim_return_tx);
> =20
[...]
> +/**
> + * slim_ctrl_clk_pause: Called by slimbus controller to enter/exit 'cloc=
k pause'
> + * Slimbus specification needs this sequence to turn-off clocks for the =
bus.
> + * The sequence involves sending 3 broadcast messages (reconfiguration
> + * sequence) to inform all devices on the bus.
> + * To exit clock-pause, controller typically wakes up active framer devi=
ce.
> + * @ctrl: controller requesting bus to be paused or woken up
> + * @wakeup: Wakeup this controller from clock pause.
> + * @restart: Restart time value per spec used for clock pause. This value
> + *	isn't used when controller is to be woken up.
> + * This API executes clock pause reconfiguration sequence if wakeup is f=
alse.
> + * If wakeup is true, controller's wakeup is called.
> + * For entering clock-pause, -EBUSY is returned if a message txn in pend=
ing.
> + */
> +int slim_ctrl_clk_pause(struct slim_controller *ctrl, bool wakeup, u8 re=
start)
> +{
> +	int i, ret =3D 0;
> +	unsigned long flags;
> +	struct slim_sched *sched =3D &ctrl->sched;
> +	struct slim_val_inf msg =3D {0, 0, NULL, NULL, NULL, NULL};
> +
> +	DEFINE_SLIM_BCAST_TXN(txn, SLIM_MSG_MC_BEGIN_RECONFIGURATION,
> +				3, SLIM_LA_MANAGER, &msg);
> +
> +	if (wakeup =3D=3D false && restart > SLIM_CLK_UNSPECIFIED)
> +		return -EINVAL;
> +
> +	mutex_lock(&sched->m_reconf);
> +	if (wakeup) {
> +		if (sched->clk_state =3D=3D SLIM_CLK_ACTIVE) {
> +			mutex_unlock(&sched->m_reconf);
> +			return 0;
> +		}
> +
> +		/**

ditto

> +		 * Fine-tune calculation based on clock gear,
> +		 * message-bandwidth after bandwidth management
> +		 */
> +		ret =3D wait_for_completion_timeout(&sched->pause_comp,
> +				msecs_to_jiffies(100));
> +		if (!ret) {
> +			mutex_unlock(&sched->m_reconf);
> +			pr_err("Previous clock pause did not finish");
> +			return -ETIMEDOUT;
> +		}
> +		ret =3D 0;
> +
> +		/**

ditto

> +		 * Slimbus framework will call controller wakeup
> +		 * Controller should make sure that it sets active framer
> +		 * out of clock pause
> +		 */
> +		if (sched->clk_state =3D=3D SLIM_CLK_PAUSED && ctrl->wakeup)
> +			ret =3D ctrl->wakeup(ctrl);
> +		if (!ret)
> +			sched->clk_state =3D SLIM_CLK_ACTIVE;
> +		mutex_unlock(&sched->m_reconf);
> +
> +		return ret;
> +	}
[...]


Thanks,
Jonathan Neusch=C3=A4fer

--gjykqnoluazweuwr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAABAgAGBQJZ2Ir5AAoJEAgwRJqO81/b2dUQAJsTacXWwUV9IHUmB5UaTYO1
+pflBXtB6t72cX6M+eGKPlOHaPTEZZNwgZW3hKVU55Cy195xCRiuBiIIemn34OEp
kMSRFYIq2XsKkq9PevPlqL242hGZ6iAT1Iu0ZndCQakbQt+J/nF9RFCGHsYo3Xe5
1x7q0oAU1cEIguXS4pq9LibxaKZGjm1BLl8xierqJqVVv8AyMcPWCsFFSw6jE0ho
8ivPQtF5DC6tlL5wnrere6vJOR/WvMGukDnn7cu9LeGm9IThCFTyVAK9uETw3EY7
icEvU3L5yN0nS96ElAG1Sv3/M95+Cln48/VIVmYoXPBpqjWhW40uv4AK6sc3djiw
lchon8j+c7MKt0Kuk/FlLRNFWZqZ17MbVNTfwHf61UMZnzgM7iRP/tFurlPbweRN
dZko1m3uVYxNlkVWzjvwaqiM2C9Wu2+rGIE/QnCHFsB1rYaGji6VWek02H5XMO0C
Jr7FxjK8Kyfy/MM0tdfqV2RSQCPri8EVTbwgz57JqAuEZbT2hboJU42zZRCHZ+j3
QYq2YqAfODuSrwT/GmmnoQmIyUKORcqNyzpJOB85H2lBqYXK3W7by4Q0h/ECvBrY
e6xUb+NKDpVcu+arwrD06rsgOhi1/GcgMulAHMqBBQGiCyScSkjptH/Qk97/ACr4
qarrMMVZz2lDq9ZP/5WP
=Qh9z
-----END PGP SIGNATURE-----

--gjykqnoluazweuwr--
