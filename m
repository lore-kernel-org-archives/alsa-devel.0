From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 2/5] ASoC: sirf: add I2S CPU DAI driver
Date: Mon, 6 Jan 2014 17:12:56 +0000
Message-ID: <20140106171256.GL31886@sirena.org.uk>
References: <1388729104-28643-1-git-send-email-rongjun.ying@csr.com>
 <1388729104-28643-3-git-send-email-rongjun.ying@csr.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5361675372815650938=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 672532610CA
 for <alsa-devel@alsa-project.org>; Mon,  6 Jan 2014 18:13:03 +0100 (CET)
In-Reply-To: <1388729104-28643-3-git-send-email-rongjun.ying@csr.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: RongJun Ying <rjying@gmail.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Workgroup.linux@csr.com, Rongjun Ying <Rongjun.Ying@csr.com>
List-Id: alsa-devel@alsa-project.org


--===============5361675372815650938==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n46tNtduvSxuckhl"
Content-Disposition: inline


--n46tNtduvSxuckhl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 03, 2014 at 02:05:01PM +0800, RongJun Ying wrote:

> +static int sirf_i2s_dai_probe(struct snd_soc_dai *dai)
> +{
> +	dai->playback_dma_data = &dma_data[0];
> +	dai->capture_dma_data = &dma_data[1];
> +	return 0;
> +}

Call snd_soc_dai_init_dma_data() rather than assigning directly.

> +	},
> +	.ops = &sirfsoc_i2s_dai_ops,
> +};
> +#ifdef CONFIG_PM_RUNTIME

Blank line after the struct please.

> +		writel(si2s->i2s_ctrl, si2s->base + AUDIO_CTRL_I2S_CTRL);
> +		/*Restore MCLK enable and reference clock select bits.*/

/* text */

> +	si2s->sirf_pcm_pdev = platform_device_register_simple("sirf-pcm-audio",
> +			0, NULL, 0);
> +	if (IS_ERR(si2s->sirf_pcm_pdev))
> +		return PTR_ERR(si2s->sirf_pcm_pdev);

This should just be a call to register the DMA directly rather than
create a device to do it.

> +	ret = of_address_to_resource(pdev->dev.of_node, 0, &mem_res);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "Unable to get i2s memory resource.\n");
> +		return ret;
> +	}

It is more normal to use platform_get_resource(), it works fine with OF
resources and is more idiomatic than using the OF specific stuff.

--n46tNtduvSxuckhl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSyuQVAAoJELSic+t+oim9TtMP/i9JAWcktQBCfafdMmiIH/RD
Fr9n79fPmVzGOQ/81QE0pvaYGWZfnyo3gaBUfAM6cGqqe9C4e28Dpa4P3kGt+wNf
SAvUxVdr8wn1BbgoNw/V65vxCJudXJSfzLZevOgb2Tt/pYr6w7AqzwZ5fwjs64rX
MBZ98VqrfE4ySjm0hD1ent8l5R7j24YqAQnEaKSFL0kayX18fSf9SpRfPHT15UpT
9St5hSu6YCV8bho8/kLuBTyCAcqCnwkQuUX3EUTsdf2vsXjBqHP7Ed3xftJmpSRp
uMKgaZmHTUihQW3rZ6j61u2kazLL+8qdYMjyCaZYrvD1pcKajSDoTc64JYRCAkac
wkso0T+p5m8xVJ21mtonJJkkRgWTqOvrnAqE2YPwOMf7KxXee7v4kS4PI8QDKKpZ
EhJoI/f+YRt1Wa8nDCu4O3NtDLgkYYuUF0YY1pVLfST/LBJUk2DioLreZOPhynwE
gZVdmQVX9lxQKFsMNWEPjrWf4u3VNvsqyA0ovza1+/6S9OgnNIgWflt5DYXHkHGQ
WOvim0BRrGaEmIP2T5RIAw5q7GXi2yLi8A0szY4j1Vhmq6YDNep6WFyV6kBcZU2d
UP07yUiEqoL1K0LQzZLX0D0eOv9qbAlicZxmpxlKfzhNQwJiu+nGFv/UjppJ3Msv
IBkcva9CxBAPVB4qZATv
=WWou
-----END PGP SIGNATURE-----

--n46tNtduvSxuckhl--

--===============5361675372815650938==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5361675372815650938==--
