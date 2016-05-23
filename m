From: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Subject: Re: [alsa-devel] [RFC-PATCH 0/2] ASoC: simple_card: support for
 hw-params rules
Date: Mon, 23 May 2016 20:26:41 +0200
Message-ID: <57434B61.2080705@metafoo.de>
References: <1463747445-14167-1-git-send-email-kernel@martin.sperl.org>
 <573F6279.8040008@metafoo.de> <20160523165931.GY8206@sirena.org.uk>
 <20160523171515.GI4976@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160523171515.GI4976@leverpostej>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On 05/23/2016 07:15 PM, Mark Rutland wrote:
> On Mon, May 23, 2016 at 05:59:31PM +0100, Mark Brown wrote:
>> On Fri, May 20, 2016 at 09:16:09PM +0200, Lars-Peter Clausen wrote:
>>
>>> How about allowing to embed eBPF bytecode in the DT that can be installed as
>>> a constraint set? This would allow maximum for flexibility and also make the
>>> implementation a lot easier.
>>
>> That seems somewhat Linux specific, I'd like to see some DT maintainer
>> buy in on that one as well as Takashi's thoughts.
> 
> I am very much not in favour of embedding eBPF bytecode into the DT.

This has to be seen in the context of the suggestion to reference kernel
symbols by name from the DT.

My opinion is that if the interdependence between the components in your
system is non-trivial you should write a proper driver. Otherwise we'll end
up with DT-script and replicate all the terrible things from the ACPI world
where people ship completely horrendous and broken byte code in the firmware.


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
