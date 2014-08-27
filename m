From: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH 8/8] ASoC: add snd-soc-dummy DT support
Date: Wed, 27 Aug 2014 10:24:11 +0200
Message-ID: <53FD95AB.6080903@metafoo.de>
References: <87fvgriqrb.wl%kuninori.morimoto.gx@gmail.com> <874mx7iqgt.wl%kuninori.morimoto.gx@renesas.com> <53F9A6EE.5070005@metafoo.de> <871ts4nmki.wl%kuninori.morimoto.gx@gmail.com> <20140826062558.GR17528@sirena.org.uk> <87wq9vmyyc.wl%kuninori.morimoto.gx@gmail.com> <20140826091120.GC17528@sirena.org.uk> <53FC5105.6070901@metafoo.de> <20140826094211.GF17528@sirena.org.uk> <87r403mtip.wl%kuninori.morimoto.gx@gmail.com> <20140826105028.GK17528@sirena.org.uk> <87d2bmpwi2.wl%kuninori.morimoto.gx@gmail.com> <87a96qpqsy.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87a96qpqsy.wl%kuninori.morimoto.gx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kuninori Morimoto <kuninori.morimoto.gx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On 08/27/2014 05:14 AM, Kuninori Morimoto wrote:
>
> Hi Mark again
>
>> But, How about this case ?
>>
>>     FE cpu:   CPU-A
>>        codec: Codec-A
>>
>>     BE cpu:   CPU-B
>>        codec: Codec-B
>
> I found 1 method.
> I can create it if we can assume that
> "simple-card doen't support above style",
>
>> If the documentation refers to the interface as for example "I2S0" then
>> the DT should refer to it as I2S0 too.
>
> simple-card is using "format" property now,
> and I remember that someone want to exchange format in DPCM.
>
> My 1st DPCM patch used "remote" property for specify FE/BE.
> And, we can get DAI stream_name if we can update snd_soc_of_get_dai_name()
> This means, we can use DPCM like below
> if you can accept my previous "ASoC: dapm: enable DAI name on DAPM route"
> What do you think ?
>
> 	sound {
> 		compatible = "simple-audio-card";
>
> 		/* FrontEnd */
> 		simple-audio-card,dai-link@0 {
> 			...
> 			format = "left_j";
> 			remote = <&endpoint>;
>
> 			cpu {
> 				sound-dai = <&rcar_sound 0>;
> 			};
> 			codec { /* dummy */ };
> 		};
>
> 		/* BackEnd */
> 		endpoint: simple-audio-card,dai-link@1 {
> 			...
> 			format = "left_j";
>
> 			cpu { /* dummy */ };
> 			codec1: codec {
> 				sound-dai = <&ak4643>;
> 			};
> 		};
> 	};

When you try to come up with with a binding try to completely ignore that 
something call DPCM exists. The binding is supposed to describe the hardware 
and how the different hardware components are interconnected. So try to come 
up with a binding that accurately describes the hardware connections. Once 
that is done try to map the binding onto the existing software framework. 
The last step may require some adjustments to the framework.

- Lars

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
