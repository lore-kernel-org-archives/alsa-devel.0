From: "Austin, Brian" <Brian.Austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/2] ASoC: Add support for CS42L56 CODEC
Date: Tue, 6 May 2014 01:46:10 +0000
Message-ID: <2EE0E51C-750B-41A1-BEF7-210DF8CB7365@cirrus.com>
References: <1399320549-16645-1-git-send-email-brian.austin@cirrus.com>,<20140506012422.GB22111@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140506012422.GB22111-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Handrigan, Paul" <Paul.Handrigan-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "pawel.moll-5wv7dgnIgG8@public.gmane.org" <pawel.moll-5wv7dgnIgG8@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org" <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, "galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: alsa-devel@alsa-project.org



> On May 5, 2014, at 20:24, "Mark Brown" <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> 
>> On Mon, May 05, 2014 at 03:09:08PM -0500, Brian Austin wrote:
>> This patch adds support for the Cirrus Logic Low Power Stereo I2C CODEC
> 
> Applied, thanks.  A couple of minor issues it'd be good to look at
> incrementally.
> 
>> +    SOC_ENUM("PCMA Swap", pcma_swap_enum),
>> +    SOC_ENUM("PCMB Swap", pcmb_swap_enum),
>> +    SOC_ENUM("ADCA Swap", adca_swap_enum),
>> +    SOC_ENUM("ADCB Swap", adcb_swap_enum),
> 
> Can these be moved to DAPM?
> 
Yes they can
>> +    regcache_cache_bypass(cs42l56->regmap, true);
> 
> You shouldn't need to do this, if no default is provided regmap should
> just go to hardware.
> 
That's good to know, thanks
>> +    dev_info(&i2c_client->dev, "Cirrus Logic CS42L56 ");
>> +    dev_info(&i2c_client->dev, "Alpha Rev %X Metal Rev %X\n",
>> +         alpha_rev, metal_rev);
> 
> It's better to just put things on one line and ignore the line length
> warnings from checkpatch - this makes the code more grepable.
Yes indeed. I will gladly rework that one.

Thanks,
Brian
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
