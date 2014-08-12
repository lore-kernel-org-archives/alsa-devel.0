From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: wm8994: register irq handler for mic1 detect
Date: Tue, 12 Aug 2014 12:48:49 +0100
Message-ID: <20140812114849.GN17528@sirena.org.uk>
References: <1407843829-4908-1-git-send-email-nikesh@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GI3Lgxc05n+zHXcf"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1407843829-4908-1-git-send-email-nikesh@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nikesh Oswal <nikesh@opensource.wolfsonmicro.com>
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org


--GI3Lgxc05n+zHXcf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 12, 2014 at 12:43:49PM +0100, Nikesh Oswal wrote:

> --- a/sound/soc/codecs/wm8994.c
> +++ b/sound/soc/codecs/wm8994.c
> @@ -4099,6 +4099,15 @@ static int wm8994_codec_probe(struct snd_soc_codec *codec)
>  				dev_warn(codec->dev,
>  					 "Failed to request Mic1 detect IRQ: %d\n",
>  					 ret);
> +		} else {
> +			ret = wm8994_request_irq(wm8994->wm8994,
> +					WM8994_IRQ_MIC1_DET,
> +					wm8994_mic_irq, "Mic 1 detect",
> +					wm8994);
> +			if (ret != 0)
> +				dev_warn(codec->dev,
> +				"Failed to request Mic1 detect IRQ: %d\n",
> +				ret);

This need a better changelog and possibly some editing of the code to
make it clearer.  According to the above diff we're in the else case for
an if statement where the true path also requests the same interrupt (or
at least something with the same text reported in the error message).

--GI3Lgxc05n+zHXcf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT6f8eAAoJELSic+t+oim9HL8QAI+tLB4Eli/RmtQsAPyVkxD6
fF8mAuykUnJIE3ALY79dbEPpghx1CR+y+sSc5DLMmdnpLh1GEYRABySZ0bFjeJxR
/ZuDvh3NtNE/C3/3NZBNrqIGmDH19f0i3OzElsVZUL10NWS7OdgJ+l6r+adxd6fk
d9Ka50Pv6ajK9EKukH7/qiAN0sm4pMq1gV2IbLRx5TCVaprQZNH6f2NjQm8I1r+M
YD/HmyDbn3A12Cj1GZ8vpUddMKZxa489Vwrsdp5zVHwrSy6lNYOVaKPAlhx8wT7l
j0J4S+sbeI5kOI8ir38xcV50qDfCMKAH1/c2A/yA93RG7WHjfozoraSt9t57Hgrt
2QSAZN9Gu1G5TmxmCs5w1NMiJs434RIsUnI5QXtsSBQZNQbkA7ld25Ia5+0OsMrY
5GdMAEe1bSm20aooiFIxFL4MpikyargWEzPSzUxXi61hS4O3cBE6YsSjzbfTqR7U
Nzv+oS7g/boyWI9isTlSJKOErJAcJrRMug2tLzNZazYOii92oMwodWse71aACljN
ehpwLfwNWfShNu1lI2SFY+ymUOEvCp9Ge2lMBvk9j1JqqvbYKoczlS0v7pBj3TTS
K9LukEYRUCF/P5HPJTa0Oe6PTiMTTaAeUjzVlqyPZGXdPgRsxyu/ewF1FaLbul7K
uoTr1CdSRhu3W+mrOm3n
=AiIY
-----END PGP SIGNATURE-----

--GI3Lgxc05n+zHXcf--
