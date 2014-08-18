From: "Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [PATCH] ASoC: fsl-asrc: Convert to use regmap framework's
 endianness method.
Date: Mon, 18 Aug 2014 12:43:43 +0000
Message-ID: <18ffec9378de4e47ba641df5d21eb62a@BY2PR0301MB0613.namprd03.prod.outlook.com>
References: <1408352215-12014-1-git-send-email-Li.Xiubo@freescale.com>
 <20140818095155.GD14559@leverpostej>
 <e2a8e001e3d945a9ba9fafc1cfebe0a8@BY2PR0301MB0613.namprd03.prod.outlook.com>,<20140818122141.GG14559@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140818122141.GG14559@leverpostej>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: "broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "tiwai-l3A5Bk7waGM@public.gmane.org" <tiwai-l3A5Bk7waGM@public.gmane.org>, "perex-/Fr2/VpizcU@public.gmane.org" <perex-/Fr2/VpizcU@public.gmane.org>, "varkabhadram-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <varkabhadram-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

[...]
>> >Why does this have to change the semantics of the DT binding?
>> >
>>
>> I'm thinking that maybe in the late fulture, this device will be
>> applied to some PowerPC SoC, from the regmap framework code, we can
>> see that the 'big-endian' property could be ignored.
>>
>> So,in this case,  if it is absent, the default endian mode should be
>> used as defualt or native as the regmap framework said.
>
> As I have mentioned in the past w.r.t. endianness bindings, there is no
> such thing as a "default endianness" or "native endianness".
>
> PowerPC and ARM can be Bi-endian, configured by the kernel.
>
> The hardware's registers have a fixed endianness regardless of this
> runtime configuration.
>
> So describe that fixed property, as that does not vary with kernel
> configuration (and is therefore a property of the HW rather than the
> combination of HW + kernel).
>

Yeah, okay.

I'll remove the document binding's modification.



> Thanks,
> Mark.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
