From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 3/3] ASoC: da7213: Add bindings documentation for codec driver
Date: Thu, 8 Oct 2015 08:16:17 -0500
Message-ID: <CAL_JsqKnDVTONB4pUWiKV8Nhz=wWyQytkGjtak5BdT1K+RrOPg@mail.gmail.com>
References: <cover.1444223905.git.Adam.Thomson.Opensource@diasemi.com>
 <bfc7c5e61d8c398bc4cfa56a7908032dc3bdf82f.1444223905.git.Adam.Thomson.Opensource@diasemi.com>
 <CAL_JsqL0R0jVSm6w0V=F5c1Odw3RKATjcq96QaUcA99JJmD2Xw@mail.gmail.com> <2E89032DDAA8B9408CB92943514A0337D4609A3A@SW-EX-MBX01.diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <2E89032DDAA8B9408CB92943514A0337D4609A3A-68WUHU125fLLPO1uwJ3ImwLouzNaz+3S@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Support Opensource <Support.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 8, 2015 at 3:42 AM, Opensource [Adam Thomson]
<Adam.Thomson.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org> wrote:
> On October 07, 2015 17:22, Rob Herring wrote:
>
>> > +- dlg,micbias1-lvl : Voltage (mV) for Mic Bias 1
>> > +       [<1600>, <2200>, <2500>, <3000>]
>> > +- dlg,micbias2-lvl : Voltage (mV) for Mic Bias 2
>> > +       [<1600>, <2200>, <2500>, <3000>]
>>
>> Please append the units (-microvolt).
>
> Given that a user needs to read the bindings document to understand what is
> available, and what they're for, this seems a little unnecessary.

You may think so, but it is standard practice.

>>
>> > +- dlg,dmic-data-sel : DMIC channel select based on clock edge.
>> > +       ["lrise_rfall", "lfall_rrise"]
>> > +- dlg,dmic-samplephase : When to sample audio from DMIC.
>> > +       ["on_clkedge", "between_clkedge"]
>>
>> How about boolean for these two.
>
> Wanted these to be explicit, hence not choosing boolean. Would prefer to keep
> them as is.
>
>>
>> > +- dlg,dmic-clkrate : DMIC clock frequency (MHz).
>> > +       [<1500000>, <3000000>]
>>
>> So 1.5GHz or 3GHz?
>>
>> Add units (-hz).
>
> Agreed, the description of MHz is misleading so will update to Hz. Thanks.
> Again though, I don't see what the suffix gives you, and would prefer to leave
> the binding as is.

It tells someone reading the dts what the units are without having to
find the documentation and helps prevent people using properties with
differing units.

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
