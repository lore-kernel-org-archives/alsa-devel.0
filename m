From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: Re: [RFC-PATCH 0/2] ASoC: simple_card: support for hw-params rules
Date: Wed, 25 May 2016 17:44:25 +0200
Message-ID: <6F927660-767F-4675-9D61-553B8C6CDD94@martin.sperl.org>
References: <1463747445-14167-1-git-send-email-kernel@martin.sperl.org> <20160523171854.GJ4976@leverpostej>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160523171854.GJ4976@leverpostej>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org


> On 23.05.2016, at 19:18, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org> wrote:
> 
> On Fri, May 20, 2016 at 12:30:43PM +0000, kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org wrote:
>> From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
>> 
>> Simple_card does require under some circumstances the ability
>> to configure certain hw_parameters based on clocks, bits, channels.
>> 
>> This patchset adds a generic way to configure these kind of things
>> via the device tree easily. This patchset implements this
>> for simple_card, but other drivers can just as easily make use of
>> this.
> 
> I'm not familiar with the class of hardware here.
> 
> What exactly needs to be configured, under which situations?

Well one example - here specifically is to set up bclk rates that
the I2S hw itself is transferring for specific combinations.

Some of these rules depend on:
* the i2s driver hw itself - the i2s bcm2835 can only handle 32 bit
  transfers - so the block size needs to be set as a multiple of 2.
  in this case: sample-bits * channels.
* HW limits - e.g 24 bit/sample need to get transferred as 32 bit
  for the rpi-pcm5102a combination
* Clock selection dependent - the choice of the block size
  may be also 40 or 80 bit so that a integer divider clock
  can get selected as a preference.
  E.g 32 bit/sample * 2 channels * 48kHz gives a divider of 25/4
  using the main oscillator at 19.2MHz, which introduces some
  (possibly) audible  noise due to jitter.
  while 40bit/sample * 2 channels * 48kHz gives an integer divider
  of 20.

So controlling those helps using the hw setup properly.

> 
> How varied is this in practice?
I heard about some other devices besides the HifiBerry DAC that
also would like to control the blockrate the same way.

I remember having seen some other possible things we want to
control on the driver side during hw-params invocation, but
I can not remember what these were on top of my head (GPIO,
external clock selection if I remember correctly)

> 
> Why does this make more sense than having individual drivers?
Because then the driver would have to know a lot more
about the combination of board and codec.

Also the idea proposed by Mark was to use simple-card
instead of a dedicated driver which does not allow for
these kind of controls.

The idea was also to make it generic enough that it could
get even become part of the framework.

> 
>> For now we have the following matchers and actions:
>> * matchers:
>>  * match_sample_bits
>>  * match_rate
>>  * match_channels
>> * actions:
>>  * set_fixed_bclk_size
>> 
>> As a note: the available matching rules and action rules right now
>> are hard-coded, but this could in principle get extended to be more
>> dynamic via kallsyms_lookup_name that would lookup the requested
>> symbol and assume it is a struct asoc_generic_hw_params_method,
>> on which it could apply several sanity-checks before using
>> the pointers for real.
> 
> I'm hoping that's a joke. ;)
Just food for thought, because otherwise there would be dependencies
on compiled codecs (or a long #ifdef list)

As an alternative we could also add a method tables to the codec
structure, so that codecs could expose additional methods, that could
then get used.

Martin

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
