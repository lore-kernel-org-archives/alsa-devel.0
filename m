From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: cygnus-audio: adding device tree bindings
Date: Tue, 31 Mar 2015 06:58:06 +0100
Message-ID: <20150331055806.GB2869@sirena.org.uk>
References: <1427771784-29950-1-git-send-email-sbranden@broadcom.com>
 <1427771784-29950-2-git-send-email-sbranden@broadcom.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="GLUG07LsNvqYBoXx"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1427771784-29950-2-git-send-email-sbranden@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Scott Branden <sbranden@broadcom.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org, Dmitry Torokhov <dtor@google.com>, Anatol Pomazao <anatol@google.com>, abrestic@google.com, bryeung@google.com, olofj@google.com, pwestin@google.com, Lori Hikichi <lhikichi@broadcom.com>
List-Id: alsa-devel@alsa-project.org


--GLUG07LsNvqYBoXx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 30, 2015 at 08:16:23PM -0700, Scott Branden wrote:

> +SSP Subnode properties:
> +- dai-name: The name of the DAI registered with ASOC

ASoC.

Why is this in the DT - it sounds like this is just an internal
implementation detail for Linux, not a property of the hardware.

> +- mode: Controls if this port should be configured as I2S or TDM mode.
> +	Valid values are: "tdm" or "i2s"
> +- tdm-bits-per-frame:  only if mode is "tdm" then this property must set.
> +	Valid values are (128/256/512)

We'd normally leave these up to the machine driver to set as they're
link wide things for system integration.  The bits per frame in
particular looks like something that's not going to be fixed by the
hardware and could be varied at runtime.

> +- port-status: Controls if port is enabled or not
> +	Valid values "enabled" or "disabled"

This sounds like it's replicating the DT standard status property?

> +- channel-group: Control grouping of serial port
> +	Valid values are "2_0", "3_1", or "5_1"

What does this mean?  It looks like it's setting the number of channels
which again seems like a runtime thing.

--GLUG07LsNvqYBoXx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVGjduAAoJECTWi3JdVIfQu48H/1fN7LiL7Q1KKED+fWLN6nPb
6t8INocmBJfGooSDZJFtYNmfyaW6ZbaMl+eFgnVadAB5v5Bcsvpbo5knImr3gBEm
dzTTe0nmKCylkzDuC9ox+4lcgrmfj+DvEHyL5OdoQSRt1NP9dLyFjmLUzJaI39/A
hejBHriJpSRLb1tWb7w8k1AftoZwRUiIuqQ2noRuXUzIJD8lE/ofpdezNt47hClk
6uu1zSDL5zqP6EMEYrwUgm0n5zE0Gqv08LBiVFoIVWZQLTSmk2WBJnlFNjo+rJSL
4ZUNzKHW0XVOb15SJnkskjMVOkxxClyJkJXgSOI+x7+uCFk68u5tgHG/iLm5SGw=
=zmeu
-----END PGP SIGNATURE-----

--GLUG07LsNvqYBoXx--
