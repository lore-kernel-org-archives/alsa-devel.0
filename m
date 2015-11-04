From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/2] sound: soc: Add Cygnus audio driver
Date: Wed, 4 Nov 2015 14:28:32 +0000
Message-ID: <20151104142832.GF1717@sirena.org.uk>
References: <1446502284-23907-1-git-send-email-ssimran@broadcom.com>
 <1446502284-23907-3-git-send-email-ssimran@broadcom.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8049053661949844226=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0C537260481
 for <alsa-devel@alsa-project.org>; Wed,  4 Nov 2015 15:28:53 +0100 (CET)
In-Reply-To: <1446502284-23907-3-git-send-email-ssimran@broadcom.com>
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


--===============8049053661949844226==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ChQOR20MqfxkMJg9"
Content-Disposition: inline


--ChQOR20MqfxkMJg9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 02, 2015 at 02:11:24PM -0800, Simran Rai wrote:

>  sound/soc/bcm/Kconfig      |   18 +
>  sound/soc/bcm/Makefile     |    5 +
>  sound/soc/bcm/cygnus-pcm.c |  903 ++++++++++++++++++++++++++
>  sound/soc/bcm/cygnus-ssp.c | 1532 ++++++++++++++++++++++++++++++++++++++++++++
>  sound/soc/bcm/cygnus-ssp.h |  129 ++++

This is a very big patch which contains at least two drivers (a DMA
driver and a DAI driver).  Please split it into at least per-driver
patches for ease of review.

> +config SND_SOC_CYGNUS_DIAG
> +	bool "SoC platform audio for Broadcom Cygnus chips diagnostics"
> +	depends on SND_SOC_CYGNUS
> +	help
> +	  Say Y if you want to add diagnostics support in ASoC audio
> +	  on Broadcom Cygnus chips (bcm958300, bcm958305, bcm911360)
> +
> +	  If you don't know what to do here, say N.

These look like extremely specific diagnostics that I'd have expected to
be mostly doable using the standard kernel trace infrastructure which is
very low overhead and can just be left in the kernel all the time.  Why
is this a configurable option?

> +/*
> + * Enable diagnostics through menuconfig to debug the time intervals
> + * when each playback interrupt happens.
> + */

This should've been in the Kconfig help text.

> +	is_play = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK);

Why is_play?  It's only looked at once and makes things a bit more
confusing.

> +	/* If playback interrupt happened */
> +	if (ANY_PLAYBACK_IRQ & r5_status)
> +		handle_playback_irq(cygaud);
> +
> +	/* If  capture interrupt happened */
> +	if (ANY_CAPTURE_IRQ & r5_status)
> +		handle_capture_irq(cygaud);
> +
> +	/*
> +	 * clear r5 interrupts after servicing them
> +	 */
> +	writel(r5_status, cygaud->audio + INTH_R5F_CLEAR_OFFSET);

This will ack interrupts we didn't handle, it'd be better to mask out
unhandled interrupts.

> +	if (aio->port_type == PORT_TDM) {

> +	} else if (aio->port_type == PORT_SPDIF) {

> +	} else {
> +		dev_err(aio->cygaud->dev, "Port not supported\n");
> +		return -EINVAL;
> +	}

This looks like it should be a switch statement, you've got some other
similar constructs in the code.

> +	error = configure_vco(cygaud, p_entry);
> +	if (error)
> +		return error;

We appear to have multiple things calling configure_vco() but I can't
see what's ensuring that they all agree with each other about the
settings.

> +	/* Slot Width is either 16 or 32 */
> +	if (slot_width <= 16)
> +		bits_per_slot = 1;

The check doesnn't match the comment here.

> +}
> +static int cygnus_ssp_resume(struct snd_soc_dai *cpu_dai)

Blank line between functions and remove empty functions.  Though I'm not
clear why the result doesn't undo what the suspend did...

> +		ssp_regs[0] = (struct cygnus_ssp_regs) INIT_SSP_REGS(0);

Why the casts?

--ChQOR20MqfxkMJg9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWOhYQAAoJECTWi3JdVIfQjQYH/0YBwb+pyFyY1yZLhXs+2wi9
vLqNXkBeAxs6zbhoTz3S8wxJnL/ZszQ8wfiJ68gBGIQAM6mUuyMiCcfQvcLCIEfi
ke/2UKSjjYI6+9rysgz8JTv8SsyBzLLdQ404+ETmyDI0DKozaxN93VBcW9xo5E6k
O6AXLl6AJvKcszFDFdB2Bdck7zrX4Tcbi/L1IXUHiSdOpMe8E/fZ+S0UE3IQwRiL
/8rVnB3+v3AS00EYSdxHhD/Ooi7vT8tQWWtQL5Eiw31dFTjaR9jx5se5Q6h1ybkb
VumL9WIV5W5RYOPYjoGSTIMEyHyFtfHv7OAq1SEB8QtdxxXiIaYXEp68NKwHayk=
=wu88
-----END PGP SIGNATURE-----

--ChQOR20MqfxkMJg9--

--===============8049053661949844226==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8049053661949844226==--
