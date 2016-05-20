From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: Re: [PATCH 2/2] ASoC: Add support for HifiBerry DAC
Date: Fri, 20 May 2016 14:28:31 +0200
Message-ID: <16CFA3C9-5C40-4771-B73E-540F2A7FABE1@martin.sperl.org>
References: <1463130853-25096-1-git-send-email-kernel@martin.sperl.org> <1463130853-25096-3-git-send-email-kernel@martin.sperl.org> <20160513105409.GB22038@sirena.org.uk> <C139252A-23AC-4C37-A5E5-E0D7AF1DCC89@martin.sperl.org> <20160513132113.GP22038@sirena.org.uk>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160513132113.GP22038-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Matthias Reichl <hias-vtPv7MOkFPkAvxtiuMwx3w@public.gmane.org>, Florian Meier <florian.meier-oZ8rN/sblLk@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


> On 13.05.2016, at 15:21, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> 
> On Fri, May 13, 2016 at 02:20:57PM +0200, Martin Sperl wrote:
>> Could look like this:
>> bclk-ratios = 
>>  /* for 96kHz at 16bit/channel use bclk-ratio 40 */
>>  <96000 16 40>, 
>>  /* for 48kHz at 32bit/channel use bclk-ratio 80 */
>>  <48000 16 80>,
>>  /* for any (other) sample frequency at 16 bit use bclk-ratio 32 */
>>  <0 16 32>,
>>  /* for any (other) sample frequency at 32 bit use bclk-ratio 64 */
>>  <0 32 64>;
> 
>> but there could also be other approaches as well,
>> how this could get described in the device tree.
> 
> You may well end up with something like that, yeah.

I am submitting a patch for this now...
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
