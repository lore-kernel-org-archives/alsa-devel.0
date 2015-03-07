From: "Maciej S. Szmigiero" <mail-APzI5cXaD1zVlRWJc41N0YvC60bnQu0Y@public.gmane.org>
Subject: Re: [PATCH][ASoC]Add DT bindings for generic ASoC AC97 CODEC driver
Date: Sat, 07 Mar 2015 14:58:53 +0100
Message-ID: <54FB041D.8010102@maciej.szmigiero.name>
References: <54F9F81E.8080105@maciej.szmigiero.name> <20150307105201.GB28806@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150307105201.GB28806-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Brian Austin <brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Thanks for looking into the patch.

W dniu 07.03.2015 11:52, Mark Brown pisze:
> On Fri, Mar 06, 2015 at 07:55:26PM +0100, Maciej S. Szmigiero wrote:
> 
>> Add and document DT bindings for generic ASoC AC97 CODEC driver,
>> make it selectable in config.
> 
> AC'97 shouldn't need DT bindings for the CODEC, it's an enumerable bus.

What this driver did / does is essentially to allow attaching AC'97 bus
to ASoC AC'97 controllers which don't do it on its own (from what I can
see only board files do it).

> 
>> +  - playback-rates : A list of supported playback rates.
>> +
>> +  - capture-rates : A list of supported capture rates.
> 
> Why would we need these properties - the sample rate support is defined
> by the standard, and any extensions can be enumerated from the device.

This driver originally constrained rates to 8000, 11025, 22050, 44100,
48000.

An alternative would be to remove this constraint at all from this
driver and leave such constraining for controller and AC'97 bus code.

But since this driver was originally limited to these rates I think it
would be safer to do it only when instantiated via OF.

Best regards,
Maciej Szmigiero

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
