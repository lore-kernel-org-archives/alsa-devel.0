From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V3 2/2] ASoC: img: Add driver for Pistachio internal DAC
Date: Wed, 9 Dec 2015 20:17:35 +0000
Message-ID: <20151209201735.GH5727@sirena.org.uk>
References: <1449678609-5592-1-git-send-email-Damien.Horsley@imgtec.com>
 <1449678609-5592-3-git-send-email-Damien.Horsley@imgtec.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IPaxb0UBFekg84Ij"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1449678609-5592-3-git-send-email-Damien.Horsley@imgtec.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Damien Horsley <Damien.Horsley@imgtec.com>
Cc: alsa-devel@alsa-project.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, James Hartley <james.hartley@imgtec.com>
List-Id: alsa-devel@alsa-project.org


--IPaxb0UBFekg84Ij
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 09, 2015 at 04:30:09PM +0000, Damien Horsley wrote:

> +static const struct snd_kcontrol_new pistachio_internal_dac_snd_controls[] = {
> +	SOC_SINGLE("Mute Switch", PISTACHIO_INTERNAL_DAC_CTRL, 2, 1, 0)
> +};

This would normally be called "Playback Switch" and (presumably) have
the opposite sense - this is a standard name that applications know and
will be able to use automatically.

--IPaxb0UBFekg84Ij
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWaIxeAAoJECTWi3JdVIfQv3sH+gKyZPlfrGjuwBIA7ErLu/wA
lMg+afm8Bo1BTx9MmlcZ0OjamdC9IgrMJign5atNXqHFjz4DCUCP0pu8Pq9xH6n6
FoYFbRIVowszRWURrdSrqTeca5CCAeu1ji6P0U/ahu48KXTeqjsxAN+SKbbKtjkf
41fzWbTfTVLIzSUPqfq4w3L/0JTFCCWJktL+DgtHDW1Jw6J7CuJbqw/Nv4u7PSHo
JbiYmdGnn8isZpb0wuiBj2haqizaZ0PKpaEGjRYX+rPlidmwvGXyiDKLaH2WFakO
nuL6+1MoOZhIU6tgDAyjfUR51PZMdpl6BZ+1F+jjAg4WcQ1RJDbmhgQL0POMjo4=
=pvq8
-----END PGP SIGNATURE-----

--IPaxb0UBFekg84Ij--
