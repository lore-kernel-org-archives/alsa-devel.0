From: Lori Hikichi <lhikichi-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 0/2] Cygnus Audio Driver
Date: Fri, 10 Apr 2015 20:06:28 -0700
Message-ID: <55288FB4.2010906@broadcom.com>
References: <1427771784-29950-1-git-send-email-sbranden@broadcom.com> <20150331064338.GE2869@sirena.org.uk> <551EEAF8.7050108@broadcom.com> <20150406095803.GD6023@sirena.org.uk> <55249258.1020907@broadcom.com> <20150408185420.GH6023@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150408185420.GH6023-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, Dmitry Torokhov <dtor-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Anatol Pomazao <anatol-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, abrestic-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, bryeung-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, olofj-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, pwestin-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org
List-Id: alsa-devel@alsa-project.org



On 15-04-08 11:54 AM, Mark Brown wrote:
> On Tue, Apr 07, 2015 at 07:28:40PM -0700, Lori Hikichi wrote:
>> On 15-04-06 02:58 AM, Mark Brown wrote:
> 
>>> OK, then it's going to need to be a clock provider at some point - the
>>> clock will be going into external devices which are going to need to be
>>> able to interact with the clock (for example, to get the rate).
> 
>> Currently, the ASoC machine driver is responsible for requesting a certain
>> frequency of MCLK be generated from our driver and then also sending the
>> frequency information along to the external device (codec).
>> This is done via the snd_soc_dai_set_sysclk.  That is the only clock
>> interaction we have needed for the core part of the driver.  For enhanced
> 
> I have some passing familiarity with ASoC...  if you look at newer
> drivers, especially those for DT systems, you'll see that we're
> transitioning CODEC drivers to use the clock API for their clocks since
> this makes integrating with both generic ASoC things like simple card
> and non-ASoC clocks.
> 
>> features, we also have the need to make minor adjustments (tweaks) to the
>> PLL.  The tweaks are used to make the PLLs output frequency match as closely
>> as possible to a true reference frequency. As such, we would like to provide
>> the finest adjustment resolution as possible. The clocking framework only
>> seems to allow for a 1 Hz adjustment. This limitation and the fact that no
>> other device seems to need to interact directly will the PLL are why we have
>> not put it in the clocking framework.
> 
> That's going to be an issue no matter where you put the control - the
> ASoC specific clocking APIs don't have any control here either.  I don't
> know if we want to add the functionality for doing very fine grained
> adjustments into the clock API or not (the use cases seem limited though
> I'm sure they exist), though I do think we should have that discussion
> if only to confirm, but that's a separate thing to how we expose any
> userspace control - the clock API is a kernel internal thing.
> 
Seems like there are some benefits to integrating with the clocking framework.
I will have to consider what kernel APIs we want to expose as well.  I believe
we may have another kernel driver wanting to control this tweaking.  Do you feel
it is ok to have to PLL code reside in this driver for now, and then we can patch
later after we get this clocking control sorted out.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
