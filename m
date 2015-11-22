From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 2/3] ASoC: cygnus: Add Cygnus audio DAI
	driver
Date: Sun, 22 Nov 2015 13:44:40 +0000
Message-ID: <20151122134440.GQ26072@sirena.org.uk>
References: <1447114664-21799-1-git-send-email-ssimran@broadcom.com>
 <1447114664-21799-3-git-send-email-ssimran@broadcom.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2570741453980301493=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D2E6826070E
 for <alsa-devel@alsa-project.org>; Sun, 22 Nov 2015 14:45:31 +0100 (CET)
In-Reply-To: <1447114664-21799-3-git-send-email-ssimran@broadcom.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Simran Rai <ssimran@broadcom.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Lori Hikichi <lhikichi@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Ray Jui <rjui@broadcom.com>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, bcm-kernel-feedback-list@broadcom.com, Kumar Gala <galak@codeaurora.org>, Arun Parameswaran <arunp@broadcom.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============2570741453980301493==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZgGN478A9hzzvyZc"
Content-Disposition: inline


--ZgGN478A9hzzvyZc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 09, 2015 at 04:17:43PM -0800, Simran Rai wrote:

> +#ifdef CONFIG_PM_SLEEP
> +static int cygnus_ssp_suspend(struct snd_soc_dai *cpu_dai)
> +{
> +	struct cygnus_aio_port *aio = cygnus_dai_get_portinfo(cpu_dai);
> +	struct cygnus_audio *cygaud = snd_soc_dai_get_drvdata(cpu_dai);
> +
> +	audio_ssp_out_disable(aio);
> +	audio_ssp_in_disable(aio);
> +	if (cygaud->active_ports > 0)
> +		cygaud->active_ports--;
> +
> +	return 0;
> +}
> +
> +static int cygnus_ssp_resume(struct snd_soc_dai *cpu_dai)
> +{
> +	return 0;
> +}

I'm a bit confused here - why do we need to disable things on suspend
but not reenable them on resume?  I'd expect that the core would have
quiesced any streams that need to be suspended before we get as far as
suspending the drivers.

Please also remove empty functions.

Now I check I see that I'm repeating the questions I had on my previous
review:

| Blank line between functions and remove empty functions.  Though I'm not
| clear why the result doesn't undo what the suspend did...

Please don't ignore review comments.

> +	parent = clk_get_parent(cygaud->audio_clk[0]);
> +	if (IS_ERR(parent)) {
> +		error = PTR_ERR(parent);
> +		goto err_get_parent;
> +	}
> +
> +	/* Set PLL VCO Frequency (Hz) to default */
> +	error = clk_set_rate(parent, DEFAULT_VCO);
> +	if (error) {
> +		dev_err(&pdev->dev,
> +			"%s Set PLL VCO rate failed: %d\n", __func__, error);
> +		goto err_get_parent;
> +	}

I would expect any initialisationn of clocks beyond the ones that the
device directly interacts with to be handled within the clock API
configuration rather than in a specific driver, this avoids the driver
being dependent on a particular system integration.

--ZgGN478A9hzzvyZc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWUcbHAAoJECTWi3JdVIfQ+eYH/2iAM5EG7TBiRDGOJ0CQr3cg
RctDChD6oLqIz/dnSybXSfMK7zsjO4WsVbvFC9ZIPNRB6mwn85llBAyufnIvMRM0
n5objnv43yRB/3sbV8Y/LxOS/HFUrlADbpXbXAE7ZEamF5M7a6TEcD6N8vVdUS9h
NmL7hRnKnO3axzaK8tRbR9hiS2Sy4Qjd9MN9lTOXdKuMo4801mFkMThTXb1ZbybG
e177iOopWw4fQnx/DKS3hGspbt2gtWJJw8jPdVAw2H/RQ4MDKxW1fDAbtjQhQvIR
JZj2tBc6k/Vw1cEWW/FFuylCQ8s6kcT9cxdlClgBVUkRHQDkYGViLgAEnFVvrXY=
=mY5B
-----END PGP SIGNATURE-----

--ZgGN478A9hzzvyZc--

--===============2570741453980301493==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2570741453980301493==--
