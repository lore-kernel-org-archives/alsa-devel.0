From: Kevin Cernekee <cernekee-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 2/3] ASoC: tas571x: New driver for TI TAS571x power amplifiers
Date: Thu, 23 Apr 2015 17:47:49 -0700
Message-ID: <CAJzqFtYZ8=k7ETGyXYoDTpjNdPQ7oRrMxO+kG++3diFif6Ox1g@mail.gmail.com>
References: <1429134141-17924-1-git-send-email-cernekee@chromium.org>
 <1429134141-17924-2-git-send-email-cernekee@chromium.org> <20150418113632.GE26185@sirena.org.uk>
 <CAJzqFtYVd+jHesoNnG47ftoK9SWYUmXwDXpf2==s3Rv1ewpsYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAJzqFtYVd+jHesoNnG47ftoK9SWYUmXwDXpf2==s3Rv1ewpsYg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, dgreid-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Olof Johansson <olofj-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Sat, Apr 18, 2015 at 9:16 AM, Kevin Cernekee <cernekee-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org> wrote:
>>> +     case SND_SOC_BIAS_OFF:
>>> +             /* Note that this kills I2C accesses. */
>>> +             assert_pdn = 1;
>>
>> No, the GPIO set associated with it kills I2C access.  I'd also expect
>> to see the regmap being marked cache only before we do this and a resync
>> of the register map when we power back up (assuming that is actually a
>> power down).
>
> Hmm, not sure if this actually resets the registers back to power-on
> defaults, but I'll check.

Hi Mark,

I have reworked the driver to do the following:

 - set appropriate regmap default values on probe
 - enable idle_bias_off
 - use regcache_cache_only() to prevent accesses to I2C when in
SND_SOC_BIAS_OFF state (pdn asserted)
 - use regcache_sync() when transitioning from SND_SOC_BIAS_OFF ->
SND_SOC_BIAS_STANDBY

This is mostly working OK, but regcache_sync() assumes that the
hardware registers have been reset back to the default values.  The
"pdn" GPIO doesn't actually reset the state of the tas571x; it just
makes I2C inaccessible and inhibits audio output.  So if the factory
default for mute is 0, corner cases like this fail:

 - enter SND_SOC_BIAS_ON (e.g. play a wav file)
 - set mute to 1
 - enter SND_SOC_BIAS_OFF (e.g. playback ends)
 - set mute to 0
 - re-enter SND_SOC_BIAS_ON
 - regcache_sync() incorrectly assumes that the hardware register is
already 0, but in fact it needs to be refreshed from the cache

Aside from unnecessarily pulsing the reset GPIO when transitioning
back from SND_SOC_BIAS_OFF or overriding regcache_default_sync(), can
you think of a way to work around this?

Thanks.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
