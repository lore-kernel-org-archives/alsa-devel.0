From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: Add driver for CX2092X I2S Audio
	DSP
Date: Sun, 19 Feb 2017 16:27:17 +0000
Message-ID: <20170219162717.kwbeapezjjpcp6br@sirena.org.uk>
References: <1487427991-18174-3-git-send-email-simon.ho@conexant.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6477978271575773274=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1226F26583C
 for <alsa-devel@alsa-project.org>; Sun, 19 Feb 2017 17:27:38 +0100 (CET)
In-Reply-To: <1487427991-18174-3-git-send-email-simon.ho@conexant.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: simon.ho.cnxt@gmail.com
Cc: Simon Ho <simon.ho@conexant.com>, alsa-devel@alsa-project.org, tiwai@suse.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============6477978271575773274==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oqjok3vuxzgot3pr"
Content-Disposition: inline


--oqjok3vuxzgot3pr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Feb 18, 2017 at 10:26:31PM +0800, simon.ho.cnxt@gmail.com wrote:

> +static const struct snd_kcontrol_new cx2092x_snd_controls[] = {
> +	CX2092X_CONTROL("SendCmd", cmd_info, cmd_get, cmd_put,
> +		SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_WRITE|
> +		SNDRV_CTL_ELEM_ACCESS_VOLATILE),

This is just tunnels commands from some magic userspace application
straight through to the device, taking all the control out of standard
Linux.  What are these controls doing and why aren't we managing them
through standard interfaces?  This tends to end up creating problems
with things like power management as for example userspace might not
figure out that things like suspend and resume are happening.

> +static int cx2092x_reset(struct snd_soc_codec *codec)
> +{
> +	struct cx2092x_priv *cx2092x = snd_soc_codec_get_drvdata(codec);
> +
> +	if (gpio_is_valid(cx2092x->gpio_reset)) {
> +		gpio_set_value(cx2092x->gpio_reset, 0);
> +		mdelay(10);
> +		gpio_set_value(cx2092x->gpio_reset, 1);

Use the _cansleep() versions unless you've got a good reason not to,
that way GPIOs on slow buses can be used.

> +	if (of_match_device(cx2092x_dt_ids, dev))
> +		cx2092x->gpio_reset =
> +			of_get_named_gpio(dev->of_node, "reset-gpio", 0);

Why do we care if we managed to match the device ID?  The GPIO is
optional anyway.  It's also better to use the gpiod_ APIs if you can,
that's more modern and removes the need to special case DT.

> +	if (gpio_is_valid(cx2092x->gpio_reset)) {
> +		int ret;

Don't declare variables in the middle of functions.

--oqjok3vuxzgot3pr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlipx2QACgkQJNaLcl1U
h9C3Wgf9EUV+ZHXqvpMSViKywGUXUazJ4FS6Xq5DQAu/uABXmLpF1x9Gh7PPx5T6
1iplnFOAp3TmyyRiv8FFS6ETPETFuZyQIIm/iKt6xz70ul9XfsR9AF5oGz/h6hIk
4oQxcaFRALjIHvTPzk1PF1bUfQbqOw9HfYYPvCyQyweqsiZcvsn6GYG8sNDtq9nW
kwNXdwfKL3xfKL9ns6m4SMPD/zsJsF2X2C97Ly+R/j49YolyhcIkUOUS3pyjKGZa
HJ6ejYh+ZqZoDg9hUwcHaMRDlWUTWR51Sw7YZfFE1WiIo1j5SXKJzdStzmC4aYXx
hAGWiXj2etCkTfTM4aDYoa1weu33tg==
=6Ieh
-----END PGP SIGNATURE-----

--oqjok3vuxzgot3pr--

--===============6477978271575773274==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6477978271575773274==--
