From: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v5 1/2] ASoC: qcom: document apq8016 sbc machine driver
 bindings
Date: Tue, 09 Jun 2015 18:08:24 +0100
Message-ID: <55771D88.4050603@linaro.org>
References: <1433854702-23654-1-git-send-email-srinivas.kandagatla@linaro.org> <1433854769-23807-1-git-send-email-srinivas.kandagatla@linaro.org> <20150609165718.GH14071@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150609165718.GH14071-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Patrick Lai <plai-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Banajit Goswami <bgoswami-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kwestfie-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org



On 09/06/15 17:57, Mark Brown wrote:
> On Tue, Jun 09, 2015 at 01:59:29PM +0100, Srinivas Kandagatla wrote:
>
>> >+Optional CPU/CODEC subnodes properties:
>> >+- external	: flag to indicate if the I2S is connected to external codec
>> >+Example:
> Missing blank line between the property and the "Example:".  I'm still
I will fix it in next version.
> not sure I understand why we need a boolean property indicating if an
> external CODEC is in use - what is the consequence of setting this
> property?
As of today, the consequence of setting this flag is to setup correct 
dai_link names.
Also there are some limitations on which MI2S can be configured to 
external or internal codecs, this flag can be used in future to validate 
such configurations, if required.

--srini
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
