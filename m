From: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH 8/8] ASoC: add snd-soc-dummy DT support
Date: Sun, 24 Aug 2014 10:48:46 +0200
Message-ID: <53F9A6EE.5070005@metafoo.de>
References: <87fvgriqrb.wl%kuninori.morimoto.gx@gmail.com> <874mx7iqgt.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <874mx7iqgt.wl%kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Simon <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On 08/20/2014 09:13 AM, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
>
> This patch adds snd-soc-dummy DT binding support.

The devicetree describes the hardware, the snd-soc-dummy is a software only 
thing and should not be found in the devicetree.

> It removes .stream_name from dummy_dai,
> because "Playback" / "Capture" is very popular naming.
>
> The DAPM will lost correct route settings
> if other CPU/Codec was using same stream name.
> And it will be problem when DPCM case.
> Like below
>
> FE CPU   (rsnd):   "DAI0 Playback"
>     Codec (dummy):  "Playback"
>
> BE CPU   (dummy):  "Playback"
>     Codec (ak4642): "Playback"


That's something we need to fix, but I don't think removing the stream names 
is the right way to do this. In a multi CODEC environment you'll quite 
likely end up with widgets of the same name. Ideally a route endpoint would 
be expressed by a tuple of DT node and pin name. But I don't think it is 
possible to mix integer and string elements in a property.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
