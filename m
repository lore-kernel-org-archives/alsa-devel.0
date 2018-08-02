From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 01/10] ASoC: dt-bindings: add dt bindings for wcd9335
 audio codec
Date: Thu, 2 Aug 2018 08:07:33 -0600
Message-ID: <CAL_JsqJKXfnCggFK3QC4Q2+-ZCGKdASJ87e=s6AUq4kYA-GWjg@mail.gmail.com>
References: <20180727121806.18209-1-srinivas.kandagatla@linaro.org>
 <20180727121806.18209-2-srinivas.kandagatla@linaro.org> <20180731204315.GA5265@rob-hp-laptop>
 <53a4e82c-7270-fdbd-a2ea-efbfc2d747a2@linaro.org> <CAL_JsqKcxB2NZR94BP9-Qc8AAFsySPoADm2UA_ZV8V7JdP8-wQ@mail.gmail.com>
 <4c821ce9-6268-150f-2ab0-358f5b312ec0@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4c821ce9-6268-150f-2ab0-358f5b312ec0@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Banajit Goswami <bgoswami@codeaurora.org>, devicetree@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Vinod <vkoul@kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 2, 2018 at 1:33 AM Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
>
> Thanks for review,
>
> On 01/08/18 23:20, Rob Herring wrote:
> >>>> +- qcom,ifd:
> >>>> +    Usage: required
> >>>> +    Value type: <phandle>
> >>>> +    Definition: SLIM interface device
> >>> Wouldn't this be the parent?
> >>>
> >> No, Interface device is just like other slim device and is part of
> >> SLIMbus Component and has a unique address. Every SLIMbus component has
> >> one interface device.
> > I still don't understand what this means. If this is SLIMbus specific,
> > then maybe it should be named that way? Or it is QCom specific?
>
> It is SLIMbus specific, I will rename this to "slim,ifd" in next version
> which makes it clear!

'slim' is not a vendor. So 'slim-ifc-dev' perhaps. Unless IFD is a
well known acronym for someone familiar with SLIMbus.

Rob
