From: Dylan Reid <dgreid-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH] ASoC: simple-card: Add mic and hp detect gpios.
Date: Thu, 2 Oct 2014 09:57:59 -0700
Message-ID: <CAEUnVG5+ep=zz95ss-T+k9Vi5BiybmdeRuksN33OA0LBKR=xtQ@mail.gmail.com>
References: <1412198720-2326-1-git-send-email-dgreid@chromium.org> <542D7C73.20801@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <542D7C73.20801-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Cc: "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Sonny Rao <sonnyrao-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, jay.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 2, 2014 at 9:25 AM, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org> wrote:
> On 10/01/2014 11:25 PM, Dylan Reid wrote:
>>
>> diff --git a/Documentation/devicetree/bindings/sound/simple-card.txt
>> b/Documentation/devicetree/bindings/sound/simple-card.txt
>> index c2e9841..72d94b7 100644
>> --- a/Documentation/devicetree/bindings/sound/simple-card.txt
>> +++ b/Documentation/devicetree/bindings/sound/simple-card.txt
>> @@ -17,6 +17,10 @@ Optional properties:
>>                                           source.
>>   - simple-audio-card,mclk-fs             : Multiplication factor between
>> stream rate and codec
>>                                           mclk.
>> +- simple-audio-card,hp_det_gpio                : Reference to GPIO that
>> signals when
>> +                                         headphones are attached.
>> +- simple-audio-card,mic_det_gpio       : Reference to GPIO that signals
>> when
>
>
> The code has this correct, the "_"s should be "-"s.

Indeed, my fault.  Sorry about that.  I will post a patch once the
first one propagates.

>
> - Lars
>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
