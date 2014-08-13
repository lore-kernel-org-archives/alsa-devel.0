From: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Subject: Re: Ordering in soc_pcm_hw_params()
Date: Wed, 13 Aug 2014 08:25:22 -0400
Message-ID: <CAKON4Oyi8x_P5kLQrW3EVsr0aw8-9VnfJXWEhKgJCDsQi9L6UA@mail.gmail.com>
References: <CAKON4OzQF8sDigvcDFsJaJRVX9o4X1FiC2FEU8D6n=oaQkX+Uw@mail.gmail.com>
 <53E9D383.5060103@metafoo.de>
 <CAKON4Ow3HFL0Sv2AV7+-XS0PBHnP9WW_8FBgrV=cKp14LER9XA@mail.gmail.com>
 <CAKON4OzrJSAD0RUL5TO6n8mxG0q9rRau0MWaAXvXVo+bSB8Ygg@mail.gmail.com>
 <20140812115755.GO17528@sirena.org.uk>
 <CAKON4OyOL2asou5NvL0crcAy=wYdguBYpc7w+x0xcUUf93FxUw@mail.gmail.com>
 <20140812182029.GX17528@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f180.google.com (mail-lb0-f180.google.com
 [209.85.217.180])
 by alsa0.perex.cz (Postfix) with ESMTP id 565E82654F3
 for <alsa-devel@alsa-project.org>; Wed, 13 Aug 2014 14:25:23 +0200 (CEST)
Received: by mail-lb0-f180.google.com with SMTP id v6so8015589lbi.25
 for <alsa-devel@alsa-project.org>; Wed, 13 Aug 2014 05:25:22 -0700 (PDT)
In-Reply-To: <20140812182029.GX17528@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, Nicolin Chen <Guangyu.Chen@freescale.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 12, 2014 at 2:20 PM, Mark Brown <broonie@kernel.org> wrote:
> On Tue, Aug 12, 2014 at 08:45:22AM -0400, jonsmirl@gmail.com wrote:
>> On Tue, Aug 12, 2014 at 7:57 AM, Mark Brown <broonie@kernel.org> wrote:
>
>> > Yes, as has been said several times now it's the responsibility of the
>> > machine driver to coordinate clocking in the card so if you want to use
>
>> I hear this, but I'm conflicted about putting a generic capability
>> into the machine driver.
>
> It's a generic machine driver so having generic code in there seems
> reasonable.
>
>> 1) Are sysclk and mclk the same thing? Inside of simple-card they seem
>> to be but I can possibly see arguments that they aren't.
>
> Probably in the context of systems simple enough to use simple-card.
>
>> 2) Should sysclk for the cpu-dai and codec-dai be set independently?
>> In simple-card they can be set to conflicting values on the two nodes
>> in the DTS. Should sysclk be a single property for the machine?
>
> No, clocks might be at different rates for different devices.  One
> device might divide down the clock to the other.

What do you think about adding fields for min/max allowed sysclk to
snd_soc_dai_driver? In my case the SOC can run the sysclk at 100Mhz,
but the attached codec can only handle 27Mhz.

Then in simple-card when it is computing the 512fs clock it would use
the min/max sysclk numbers to clip its range. Alternatively, I could
add some range checking code the the set-sysclk implementation to
error out on out of range. Then do some searching around until no one
errors.

sgtl5000 can do 96Khz, but only at 256fs. I'm pumping 49Mhz into it
right now and it works, but that clearly violates the datasheet.

>
>> 3) If sysclk is defined by a phandle to a clock, how should clock
>> accuracy be handled? For example in my CPU the best clock that can be
>> made is about 0.01% less than what it should be. If you take that
>> frequency number and start doing integer division on it you won't get
>> the expect results because of truncation effects. Diving by 44100
>> gives 511.95 which truncates to 511 instead of 512.
>
> I'm not sure it's worth worrying about systems that can't generate
> accurate clocks at this point, but perhaps someone will think of
> something sensible to do.
>
>> 4) If the sysclk is going to change based on the music, should it just
>> flip between 22.5/24.5 or should it use the FS multiplier in the
>> simple DTS and always be set to FS*music? For example FS=512 so for
>> 44100 it is set to 22.5Mhz and 8000 it is set to 4Mhz.
>
> If a fixed multiplier is set I'd expect to see it observed; obviously a
> device may be constrained in what it can actually use though and a fixed
> multiplier might not be the best configuration.
>
>> 5) What should the syntax for this look like in simple?
>
> It really depends what the "this" is; try to think of something
> tasteful.
>
>> 6) Longer term set-sysclk could be replaced by using phandles for the
>> clock and then clk notifiers in the components to listen for it being
>> changed. That would remove this problem of having multiple sysclks in
>> the system and the DTS syntax for identifying them.
>
>> So in my case I expose a MCLK clk. sgtl5000 codec references that
>> clock with a phandle. As the cpu-dai looks at the music it changes the
>> rate on MCLK. Codec gets notified of that change (if it is listening)
>> and can act on it.
>
> OK, but that's not meaningfully different to just having the machine
> driver call set_sysclk() and only works if the best way to change the
> clock rate is to change the clocking inside the CPU which isn't going
> to be the case for all systems.  That's the hard part, we have to be
> able to scale up to handling it.



-- 
Jon Smirl
jonsmirl@gmail.com
