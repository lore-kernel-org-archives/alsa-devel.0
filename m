From: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Subject: Re: [PATCHv2 3/4] ASoC: simple-card: Adjust the comments of simple
 card.
Date: Tue, 2 Sep 2014 12:44:38 +0200
Message-ID: <20140902124438.36da4b85@armhf>
References: <1409649969-15759-1-git-send-email-Li.Xiubo@freescale.com>
	<1409649969-15759-4-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1409649969-15759-4-git-send-email-Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Xiubo Li <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, tiwai-l3A5Bk7waGM@public.gmane.org, andrew-g2DYL2Zd6BY@public.gmane.org, kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, jsarha-l0cyMroinI0@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Tue, 2 Sep 2014 17:26:08 +0800
Xiubo Li <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org> wrote:

> @@ -285,11 +287,11 @@ static int asoc_simple_card_dai_link_of(struct =
device_node *node,
>  		dai_props->codec_dai.sysclk);
> =20
>  	/*
> -	 * soc_bind_dai_link() will check cpu name
> -	 * after of_node matching if dai_link has cpu_dai_name.
> -	 * but, it will never match if name was created by fmt_single_name(=
)
> -	 * remove cpu_dai_name to escape name matching.
> -	 * see
> +	 * In soc_bind_dai_link() will check cpu name after
> +	 * of_node matching if dai_link has cpu_dai_name.
> +	 * but, it will never match if name was created by
> +	 * fmt_single_name() remove cpu_dai_name to escape
> +	 * name matching. Please see:
>  	 *	fmt_single_name()
>  	 *	fmt_multiple_name()
>  	 */

The patch done by Kuninori, setting the cpu_dai_name to NULL in all
cases, does not work. This sequence should be replaced where is was
previously.

--=20
Ken ar c'henta=C3=B1	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
