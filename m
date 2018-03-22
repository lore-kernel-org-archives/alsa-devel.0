From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: max98357a: Fix speaker pop when
	starting playback
Date: Thu, 22 Mar 2018 09:54:56 +0800
Message-ID: <20180322015456.GZ2186@sirena.org.uk>
References: <20180321223015.32173-1-ezequiel@vanguardiasur.com.ar>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6561085058102253501=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id B7EC4267282
 for <alsa-devel@alsa-project.org>; Thu, 22 Mar 2018 02:55:22 +0100 (CET)
In-Reply-To: <20180321223015.32173-1-ezequiel@vanguardiasur.com.ar>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Stephen Barber <smbarber@chromium.org>, Mac Chiang <mac.chiang@intel.com>, Ezequiel Garcia <ezequiel@collabora.co.uk>, kernel@collabora.com
List-Id: alsa-devel@alsa-project.org


--===============6561085058102253501==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ui+0LsrIBWBNb/ay"
Content-Disposition: inline


--ui+0LsrIBWBNb/ay
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 21, 2018 at 07:30:15PM -0300, Ezequiel Garcia wrote:

> +- sdmode-delay : specify a delay time for SD_MODE pin. According
> +        to the DAC datasheet, if LRCLK is removed while BCLK is present,
> +        the DAC output can cause loud pop/crack noises. This property
> +        specifies a delay for the SD_MODE pin assert, required to
> +        eliminate the noise.

Why is this configurable?  This sounds like something entirely within
the digital domain of the device rather than something that depends on
board configuration and it's hard to see how someone would configure
this.

> +static void max98357a_enable_sdmode_work(struct work_struct *work)
> +{
> +	struct max98357a_priv *max98357a = container_of(work,
> +		struct max98357a_priv, enable_sdmode_work.work);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&max98357a->sdmode_lock, flags);
> +	gpiod_set_value(max98357a->sdmode, max98357a->sdmode_enabled);
> +	spin_unlock_irqrestore(&max98357a->sdmode_lock, flags);
> +}

What is this lock supposed to accomplish?  We perform a single action
under the lock which itself has internal locking, it's not going to have
any meaningful effect.

--ui+0LsrIBWBNb/ay
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqzDO8ACgkQJNaLcl1U
h9AZ3gf/bLafaSGs8Oa1wG+5lDRdHy+agDdxHVfJtp218XHYFliVXjl7ULPh46qj
JnkEuagL94IZUeexYrafobfVGzmP2JFYMrIh9x6hGgZklmJg23sWGa1QkJRekuLY
uTgks7x5JJKNjehJyXacbv2q8gusRh6F02kPCmsT74a8ICfRII1CRcTALtf9YzFz
He3qG/gAByBJyQeQRtsTysXAOjKttAM2oNXoF4aO2QBZXL9WYYuz4ROiehgjBLJV
7DDpHhkj/3VGGW0/r3XxAaXK5isE4WRBEb8aXQleVu2MW+60rq6f8t9gZQW7+MHU
egxDWsnUSPZ1+kZt1rIfVBJV3CALuQ==
=4xJt
-----END PGP SIGNATURE-----

--ui+0LsrIBWBNb/ay--

--===============6561085058102253501==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6561085058102253501==--
