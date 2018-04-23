From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: tas6424: Allow disabling auto
 diagnostics for faster power-on
Date: Mon, 23 Apr 2018 16:44:12 +0100
Message-ID: <20180423154411.GK19834@sirena.org.uk>
References: <1524218684-19752-1-git-send-email-jjhiblot@ti.com>
 <1524218684-19752-2-git-send-email-jjhiblot@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8980880342058464309=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 0CB9E266CA1
 for <alsa-devel@alsa-project.org>; Mon, 23 Apr 2018 17:44:22 +0200 (CEST)
In-Reply-To: <1524218684-19752-2-git-send-email-jjhiblot@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jean-Jacques Hiblot <jjhiblot@ti.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.com, afd@ti.com, robh+dt@kernel.org, dannenberg@ti.com
List-Id: alsa-devel@alsa-project.org


--===============8980880342058464309==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2WS97oupGEGbYNpW"
Content-Disposition: inline


--2WS97oupGEGbYNpW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 20, 2018 at 12:04:42PM +0200, Jean-Jacques Hiblot wrote:
> The TAS6424 incorporates both DC-load and AC-load diagnostics which are
> used to determine the status of the load. The DC diagnostics runs when any
> channel is directed to leave the Hi-Z state and enter the MUTE or PLAY
> state.
> The DC diagnostics are turned on by default but if a fast startup without
> diagnostics is required the DC diagnostics can be bypassed by adding the
> property "disable-auto-diagnostics".

This is making me think we should be smarter here and either only run
the diagnostics once during boot or provide a user control for the
diagnostics.  It seems like something that is more of a runtime software
decision than something that's fixed in hardware design, is there
anything about the hardware design that'd make it impossible to run
diagnostics?

> +	if (tas6424->no_auto_diags) {
> +		/*
> +		 * Disable DC auto-diagnostics to save time when channel leave
> +		 * Hi-Z state
> +		 */
> +		ret = regmap_update_bits(tas6424->regmap,
> +					 TAS6424_DC_DIAG_CTRL1,
> +					  0xff, TAS6424_LDGBYPASS);

This could just be exposed to userspace as a simple switch control
couldn't it?  I do note that it masks more bits than it sets though...

--2WS97oupGEGbYNpW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrd/0sACgkQJNaLcl1U
h9BJJQf+LarwNv6nMCjPJuZ01r2WdQ8JnLzPZ8TUSXu7IoQHYAgSthTL024mNAi5
4q5+gnO3UtOYJ6ij62m8j6btoTZTBWh3Xtc/oABbFYA46hThuw3w9oNgLWXL9eWd
SmETAZ1RVCmQ8KrmRf2XF3hmHgba4Y14ts1gQsF203iFa69FLhFOs99r7rWzoOS1
NZQ4+0bUJNh0MCAr5kuGiZmofDCevGCBHKBWUVG/fhWKGirsXNko02uDak/12Hvd
dM/9wXXaYyvKScbPoBoYnXLgvvFw8drprINRTw9RkE2CrW+tyKX9+2Pvz+ZVKVDu
Jm643AogFadU8Kp6s86j+9eBqjRDdg==
=ruBO
-----END PGP SIGNATURE-----

--2WS97oupGEGbYNpW--

--===============8980880342058464309==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8980880342058464309==--
