From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 1/6] ASoC: davinci-mcbsp: add binding for McBSP
Date: Thu, 21 Apr 2016 09:42:08 -0500
Message-ID: <CAL_JsqJEGwhPk+79-bg48KAOPK+n3eNNB8NXPZvG6Uk8zBKFpg@mail.gmail.com>
References: <1460375117-4311-1-git-send-email-petr@barix.com>
 <1460375117-4311-2-git-send-email-petr@barix.com> <20160413143014.GA12136@rob-hp-laptop>
 <5710AACF.9070402@barix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5710AACF.9070402-Qh/3xLP0EvwAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Petr Kulhavy <petr-Qh/3xLP0EvwAvxtiuMwx3w@public.gmane.org>
Cc: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 15, 2016 at 3:48 AM, Petr Kulhavy <petr-Qh/3xLP0EvwAvxtiuMwx3w@public.gmane.org> wrote:
>
> On 13.04.2016 16:30, Rob Herring wrote:
>>
>> On Mon, Apr 11, 2016 at 01:45:12PM +0200, Petr Kulhavy wrote:
>>>
>>> Add devicetree binding for the TI DA8xx/OMAP-L1x/AM17xx/AM18xx
>>> MultiChannel Buffered Serial Port (McBSP)
>>>
>>> The optional register range "dat" is not implemented at the moment.
>>> The current driver supports only DMA into RX/TX registers but no FIFO.
>>> Once the FIFO is implemented in the driver the "dat" range will be used.
>>>
>>> Signed-off-by: Petr Kulhavy <petr-Qh/3xLP0EvwAvxtiuMwx3w@public.gmane.org>
>>> ---
>>> v1: initial
>>> v2: add missing TC channel in dmas properties (for compatibility with the
>>> new EDMA3 binding)
>>>      remove "-audio" postfix from the compatible string
>>>      remove "channel-combine" property
>>>
>>>   .../devicetree/bindings/sound/davinci-mcbsp.txt    | 51
>>> ++++++++++++++++++++++
>>>   1 file changed, 51 insertions(+)
>>>   create mode 100644
>>> Documentation/devicetree/bindings/sound/davinci-mcbsp.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/sound/davinci-mcbsp.txt
>>> b/Documentation/devicetree/bindings/sound/davinci-mcbsp.txt
>>> new file mode 100644
>>> index 000000000000..de45865c3863
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/sound/davinci-mcbsp.txt
>>> @@ -0,0 +1,51 @@
>>> +Texas Instruments DaVinci McBSP module
>>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>> +
>>> +This binding describes the "Multi-channel Buffered Serial Port" (McBSP)
>>> +audio interface found in some TI DaVinci processors like the OMAP-L138
>>> or AM180x.
>>> +
>>> +
>>> +Required properties:
>>> +~~~~~~~~~~~~~~~~~~~~
>>> +- compatible : "ti,da850-mcbsp"
>>
>> You list several SoCs above, but only one compatible string here. A
>> specific compatible string per SoC please.
>>
> Hi Rob,
>
> thank you for your feedback. I can test only on the AM1808 platform, however
> as far as I understand the OMAP L138 and AM1808 use the same McBSP hardware.
> The TI guys can give more insight here... Isn't it then redundant to define
> more compatible strings? Sorry for my ignorance, I just don't know the
> policy of defining the compatible strings.

Based on Sekhar's reply okay.

>>> +
>>> +- reg : physical base address and length of the controller memory mapped
>>> +        region(s).
>>> +- reg-names : Should contain:
>>> +        * "mpu" for the main registers (required). For compatibility
>>> with
>>> +          existing software, it is recommended this is the first entry.
>>
>> s/recommended/required/
>
> Recommended is correct, but I think it make sense to drop the sentence.
> If the reg-names are provided then the probe() finds the resource regardless
> of the index.
> If not provided it expects it at index 0.
> But since we declare that the reg-names is mandatory this sentence is just
> confusing and should be removed.

No, required is correct. The order of reg (or any other property)
entries must be defined regardless of the use of *-names or not.

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
