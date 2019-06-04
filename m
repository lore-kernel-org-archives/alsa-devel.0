From: Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v4 8/9] ASoc: sun4i-i2s: Add 20, 24 and 32
 bit support
Date: Tue, 4 Jun 2019 10:19:38 +0200
Message-ID: <20190604081938.npye7brtjv7c7noj@flea>
References: <20190603174735.21002-1-codekipper@gmail.com>
 <20190603174735.21002-9-codekipper@gmail.com>
Reply-To: maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6wxkr4ordbttpslj"
Return-path: <linux-sunxi+bncBDSJBYGBRIMBBH6T3DTQKGQE7SKHX6Q-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <20190603174735.21002-9-codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: wens-jdAy2FN1RRM@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, be17068-p0aYb1w59bq9tCD/VL7h6Q@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--6wxkr4ordbttpslj
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline

On Mon, Jun 03, 2019 at 07:47:34PM +0200, codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:
> From: Marcus Cooper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>
> Extend the functionality of the driver to include support of 20 and
> 24 bits per sample for the earlier SoCs.
>
> Newer SoCs can also handle 32bit samples.
>
> Signed-off-by: Marcus Cooper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  sound/soc/sunxi/sun4i-i2s.c | 34 +++++++++++++++++++++++++++++++---
>  1 file changed, 31 insertions(+), 3 deletions(-)
>
> diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> index 3549a87ed9e9..351b8021173b 100644
> --- a/sound/soc/sunxi/sun4i-i2s.c
> +++ b/sound/soc/sunxi/sun4i-i2s.c
> @@ -428,6 +428,11 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
>  	case 16:
>  		width = DMA_SLAVE_BUSWIDTH_2_BYTES;
>  		break;
> +	case 20:
> +	case 24:
> +	case 32:
> +		width = DMA_SLAVE_BUSWIDTH_4_BYTES;
> +		break;

Doesn't this test the physical width? If so, then I'm not sure that 20
even exists, and that we can support 24.

>  	default:
>  		dev_err(dai->dev, "Unsupported physical sample width: %d\n",
>  			params_physical_width(params));
> @@ -440,7 +445,18 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
>  		sr = 0;
>  		wss = 0;
>  		break;
> -
> +	case 20:
> +		sr = 1;
> +		wss = 1;
> +		break;
> +	case 24:
> +		sr = 2;
> +		wss = 2;
> +		break;
> +	case 32:
> +		sr = 4;
> +		wss = 4;
> +		break;

This doesn't really works, wss being the slot size, and you can have a
different slot size and sample size. I have a patch that reworks this,
I'll send it.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
--6wxkr4ordbttpslj--
