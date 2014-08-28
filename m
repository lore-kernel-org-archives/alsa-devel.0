From: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH 8/8] ASoC: add snd-soc-dummy DT support
Date: Thu, 28 Aug 2014 09:23:55 +0200
Message-ID: <53FED90B.8070308@metafoo.de>
References: <87fvgriqrb.wl%kuninori.morimoto.gx@gmail.com> <874mx7iqgt.wl%kuninori.morimoto.gx@renesas.com> <53F9A6EE.5070005@metafoo.de> <871ts4nmki.wl%kuninori.morimoto.gx@gmail.com> <20140826062558.GR17528@sirena.org.uk> <87wq9vmyyc.wl%kuninori.morimoto.gx@gmail.com> <20140826091120.GC17528@sirena.org.uk> <53FC5105.6070901@metafoo.de> <20140826094211.GF17528@sirena.org.uk> <87r403mtip.wl%kuninori.morimoto.gx@gmail.com> <20140826105028.GK17528@sirena.org.uk> <87d2bmpwi2.wl%kuninori.morimoto.gx@gmail.com> <87a96qpqsy.wl%kuninori.morimoto.gx@gmail.com> <53FD95AB.6080903@metafoo.de> <87fvghihaq.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87fvghihaq.wl%kuninori.morimoto.gx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kuninori Morimoto <kuninori.morimoto.gx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On 08/28/2014 02:33 AM, Kuninori Morimoto wrote:
>
> Hi Lars
>
> Thank you for your comment
>
>>> 	sound {
>>> 		compatible = "simple-audio-card";
>>>
>>> 		/* FrontEnd */
>>> 		simple-audio-card,dai-link@0 {
>>> 			...
>>> 			format = "left_j";
>>> 			remote = <&endpoint>;
>>>
>>> 			cpu {
>>> 				sound-dai = <&rcar_sound 0>;
>>> 			};
>>> 			codec { /* dummy */ };
>>> 		};
>>>
>>> 		/* BackEnd */
>>> 		endpoint: simple-audio-card,dai-link@1 {
>>> 			...
>>> 			format = "left_j";
>>>
>>> 			cpu { /* dummy */ };
>>> 			codec1: codec {
>>> 				sound-dai = <&ak4643>;
>>> 			};
>>> 		};
>>> 	};
>>
>> When you try to come up with with a binding try to completely ignore that
>> something call DPCM exists. The binding is supposed to describe the hardware
>> and how the different hardware components are interconnected. So try to come
>> up with a binding that accurately describes the hardware connections. Once
>> that is done try to map the binding onto the existing software framework.
>> The last step may require some adjustments to the framework.
>
> Now, my system is working well with simple-card by this
>
> 	sound {
> 		compatible = "simple-audio-card";
> 		...
>
> 		cpu {
> 			sound-dai = <&rcar_sound 0>;
> 		};
> 		codec {
> 			sound-dai = <&ak4643>;
> 		};
> 	};
>
> The reason why I'm tring to support DPCM on simple-card is "sampling rate convert".
> My rcar_sound can convert sampling rate, and I tried to add this feature as
> rcar_sound property.
> But, Mark rejected and requests me to use DPCM for it,
> since it can be common featrue.
> Current existing simple-card can't use it, and I'm tring.
> But, am I misunderstanding ?

Is the sample rate converter a extra module, or is the sample rate converter 
just a feature of the I2S core?

- Lars

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
