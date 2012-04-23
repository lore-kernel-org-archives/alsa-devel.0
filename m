From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 8/8] ASoC: Ux500: Add machine-driver
Date: Mon, 23 Apr 2012 20:05:08 +0100
Message-ID: <20120423190508.GX8318@opensource.wolfsonmicro.com>
References: <1334914409-27592-1-git-send-email-ola.o.lilja@stericsson.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2689718524849489445=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8B69A104333
	for <alsa-devel@alsa-project.org>;
	Mon, 23 Apr 2012 21:05:11 +0200 (CEST)
In-Reply-To: <1334914409-27592-1-git-send-email-ola.o.lilja@stericsson.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ola Lilja <ola.o.lilja@stericsson.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============2689718524849489445==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vavxEBoGuREFpPEl"
Content-Disposition: inline


--vavxEBoGuREFpPEl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 20, 2012 at 11:33:29AM +0200, Ola Lilja wrote:

> +snd-soc-ux500-mach-objs := u8500.o ux500_ab8500.o
> +obj-$(CONFIG_SND_SOC_UX500_AB8500) += snd-soc-ux500-mach.o

This split into multiple files *really* doesn't seem like it adds
anything but complexity, the small amount of reuse just doesn't seem
worth it.

> +	/* Setup codec depending on driver-mode */
> +	driver_mode = (channels == 8) ?
> +		DRIVERMODE_CODEC_ONLY : DRIVERMODE_NORMAL;
> +	dev_dbg(dev, "%s: Driver-mode: %s.\n", __func__,
> +		(driver_mode == DRIVERMODE_NORMAL) ? "NORMAL" : "CODEC_ONLY");
> +
> +	ab8500_audio_set_bit_delay(codec_dai, 1);

What's this configuring?  I didn't notice it on the CODEC driver as the
function wasn't exported IIRC.

> +	} else {
> +		ab8500_audio_set_word_length(codec_dai, 20);

This should be done by using the TDM slot API - the slot length is one
of the parameters.

> +	status = snd_soc_add_codec_controls(codec, ux500_ab8500_ctrls,
> +			ARRAY_SIZE(ux500_ab8500_ctrls));

Do this from the driver.

> +	status = snd_soc_dapm_enable_pin(&codec->dapm, "Headset Left");
> +	status |= snd_soc_dapm_enable_pin(&codec->dapm, "Headset Right");

No need to do this, everything defaults on.

--vavxEBoGuREFpPEl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPlafUAAoJEBus8iNuMP3d1dUP+gMQ36njKj/IGmo5Q0KTCZQI
P4sgvGivVdb+/0QuCO6dwX5pzSyhiQvGzFnheIq70jTd5g/7iYClLZvmb7PIpTOG
ZieLZA+WBrM3ZRuqMNbRckQ8N1Znydw0W1tchJ+8g4bo54X6rVtukKBdMjQLmIGF
OL1Q/6fTOciy56h93bLUOCSHkkl9Vdw57uK0sBH6ZDs/ZqZ8fL11RJSroL2cmSbf
x6bzqVtDeuD0DTbdIfJGOB/ybERPBoktWBOblErVLcZb2fEpfUoM1TpihKGgFlE1
UJ6SU7Wplr+pXf+xkdtzIKV/B+1H29AKEwwHKtI7Xfw3PVvgD7NsHhFzGXtY3j2T
1vIT+grz93aP/zwmAURjihsi5c8DOVBcc3gDJUR2jiUwPEUCpv7PD0vqOMNtijFf
CqWdsrZvGVJCJ4n17JEgMHf/z2a7a59mvZmaJEICHretTRJCg6vrvVPYlZpkZDwt
UHfeU6esoLrwz73QsqjRoaXnTExo2i9GhzTUE47hshaS0G5DM7Z+AgcRcEIFgJsX
/OcFXovSXCAZx5rR+jeeyxoWSghCalcElIgakG/roESeMJirOKpVTydUq7d/2i0j
hoM6fQv43DxFlu+SA1zVswJYxxwpi2+E5wmfghMGstdReObIuZZBBbD77LRKanfB
YavKGaR52NgCmdByo0gx
=z06x
-----END PGP SIGNATURE-----

--vavxEBoGuREFpPEl--

--===============2689718524849489445==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2689718524849489445==--
