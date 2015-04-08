From: Lori Hikichi <lhikichi-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 0/2] Cygnus Audio Driver
Date: Tue, 7 Apr 2015 19:28:40 -0700
Message-ID: <55249258.1020907@broadcom.com>
References: <1427771784-29950-1-git-send-email-sbranden@broadcom.com> <20150331064338.GE2869@sirena.org.uk> <551EEAF8.7050108@broadcom.com> <20150406095803.GD6023@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150406095803.GD6023-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, Dmitry Torokhov <dtor-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Anatol Pomazao <anatol-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, abrestic-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, bryeung-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, olofj-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, pwestin-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org
List-Id: alsa-devel@alsa-project.org



On 15-04-06 02:58 AM, Mark Brown wrote:
> On Fri, Apr 03, 2015 at 12:33:12PM -0700, Scott Branden wrote:
>> On 15-03-30 11:43 PM, Mark Brown wrote:
>>> On Mon, Mar 30, 2015 at 08:16:22PM -0700, Scott Branden wrote:
>
>>>> The audio PLL is embedded in the audio block and only used
>>>> by the audio block. The audio PLL registers are also in the middle of
>>>> the audio register map.
>
>>> When you say it's only used by the audio block do you mean to say that
>>> the audio block exposes no clock signals other than the bit and frame
>>> clocks?
>
>> The audio block exposes the MCLK in addition to the bit and frame clock.
>
> OK, then it's going to need to be a clock provider at some point - the
> clock will be going into external devices which are going to need to be
> able to interact with the clock (for example, to get the rate).
>
Currently, the ASoC machine driver is responsible for requesting a 
certain frequency of MCLK be generated from our driver and then also 
sending the frequency information along to the external device (codec).
This is done via the snd_soc_dai_set_sysclk.  That is the only clock 
interaction we have needed for the core part of the driver.  For 
enhanced features, we also have the need to make minor adjustments 
(tweaks) to the PLL.  The tweaks are used to make the PLLs output 
frequency match as closely as possible to a true reference frequency. 
As such, we would like to provide the finest adjustment resolution as 
possible. The clocking framework only seems to allow for a 1 Hz 
adjustment. This limitation and the fact that no other device seems to 
need to interact directly will the PLL are why we have not put it in the 
clocking framework.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
