From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: cygnus-audio: adding device tree bindings
Date: Tue, 31 Mar 2015 08:00:01 +0100
Message-ID: <20150331070001.GF2869@sirena.org.uk>
References: <1427771784-29950-1-git-send-email-sbranden@broadcom.com>
 <1427771784-29950-2-git-send-email-sbranden@broadcom.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="heQF7/FOvX7GgW47"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1427771784-29950-2-git-send-email-sbranden@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Scott Branden <sbranden@broadcom.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org, Dmitry Torokhov <dtor@google.com>, Anatol Pomazao <anatol@google.com>, abrestic@google.com, bryeung@google.com, olofj@google.com, pwestin@google.com, Lori Hikichi <lhikichi@broadcom.com>
List-Id: alsa-devel@alsa-project.org


--heQF7/FOvX7GgW47
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 30, 2015 at 08:16:23PM -0700, Scott Branden wrote:

> +Required properties:
> +	- compatible : "brcm,cygnus-audio"
> +	- #address-cells: 32bit valued, 1 cell. <1>
> +	- #size-cells:  32bit valued, 1 cell. <1>
> +	- reg : Should contain audio registers location and length
> +	- interrupts: audio DMA interrupt number
> +
> +SSP Subnode properties:

This document does rather gloss over the fact that the binding requires
subnodes, it should mention this requirement and say what they mean.

--heQF7/FOvX7GgW47
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVGkXxAAoJECTWi3JdVIfQz8cIAIR8jeTG3UP+V0whUM0oJcqu
zMYdFw5mfde67G/aN2quuK+ICp4gma3I250obkTiarNX2XAdY7pYedOHlIx+5DcY
5mbTJ0BYQq6/zpa02+wVjL1NVguYDmWiM780WJs5g2V59Qsv8w2wS7GFGyo7RojQ
gZsiLb/pHpVvawrugD3rYq4vMLeG2DWAsRjwNXocOWp3iU0Ddqe0I2wmFrP3kDG2
lK5HYkYzrPH/vJnasjzZXDaj0F0K2DGSyzFP4O/7/e1pBXovfPDaT/0sDzbHMNB2
XbGQMp+CFV40yIwqFX7tgsk9wyccKD3LomBTmXsNeMSuGqNTBh/5L+rEuEKydko=
=elSm
-----END PGP SIGNATURE-----

--heQF7/FOvX7GgW47--
