From: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Subject: Re: Ordering in soc_pcm_hw_params()
Date: Wed, 13 Aug 2014 13:38:50 -0400
Message-ID: <CAKON4OxP30+5sXYwVB_yv0nF0_8LQ-V7K_AYAS3XN4ByG4hqFA@mail.gmail.com>
References: <CAKON4OzQF8sDigvcDFsJaJRVX9o4X1FiC2FEU8D6n=oaQkX+Uw@mail.gmail.com>
 <53E9D383.5060103@metafoo.de>
 <CAKON4Ow3HFL0Sv2AV7+-XS0PBHnP9WW_8FBgrV=cKp14LER9XA@mail.gmail.com>
 <CAKON4OzrJSAD0RUL5TO6n8mxG0q9rRau0MWaAXvXVo+bSB8Ygg@mail.gmail.com>
 <20140812115755.GO17528@sirena.org.uk>
 <CAKON4OyOL2asou5NvL0crcAy=wYdguBYpc7w+x0xcUUf93FxUw@mail.gmail.com>
 <20140812182029.GX17528@sirena.org.uk>
 <CAKON4Oyi8x_P5kLQrW3EVsr0aw8-9VnfJXWEhKgJCDsQi9L6UA@mail.gmail.com>
 <20140813163525.GY17528@sirena.org.uk>
 <CAKON4OzBKJbAzT6MVMT_jkuVFf6jYF5Pe=fFA2ZbhGSNkHbtgg@mail.gmail.com>
 <20140813172422.GD17528@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f46.google.com (mail-la0-f46.google.com
 [209.85.215.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 66B3C26553C
 for <alsa-devel@alsa-project.org>; Wed, 13 Aug 2014 19:38:51 +0200 (CEST)
Received: by mail-la0-f46.google.com with SMTP id b8so62854lan.5
 for <alsa-devel@alsa-project.org>; Wed, 13 Aug 2014 10:38:50 -0700 (PDT)
In-Reply-To: <20140813172422.GD17528@sirena.org.uk>
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

On Wed, Aug 13, 2014 at 1:24 PM, Mark Brown <broonie@kernel.org> wrote:
> On Wed, Aug 13, 2014 at 01:00:02PM -0400, jonsmirl@gmail.com wrote:
>
>> Right now I could make the set_sysclk implementations return -EINVAL
>> if the clock is out of range. Then add some logic to simple-card to
>> try again with a different FS multipler. Or at least I can print some
>> error message to give a clue as to why the song won't play.
>
> Well, error checking would be good.
>
>> What ASoC platforms haven't implemented the clock API? Using the clock
>
> There's still some ARM platforms that don't implement the common clock
> API yet (or make it optional), Blackfin, MIPS, some PowerPC, SH and x86
> doesn't enable it for most platforms and when I've tried sending patches
> the maintainers didn't bother replying.  Life would be a lot easier if
> the common clock API were available by default but the infrastructure
> for asm-generic leaves something to be desired too.
>
>> API, simple-card would have a phandle to the clock master. Then it
>> could set the proposed rate into it. Codec and CPU would have
>> clk_notifier implemented so that they could reject the proposed change
>> based on their constraints.  Simple could then adjust the FS multiple
>> until both devices are happy.
>
> Even for fairly simple cards the solution is often more complex than
> this - the master clock might not be directly connected to one or both
> of the devices and there may be programmablility for the dividers
> between them.  It therefore seems more likely to be useful to set the
> rate we actually want rather than some parent rate, that at least gives
> the best information to the code trying to do the resolution.

Simple already supports the case of having the clocks connected to two
different places.

I'm trying to get the case where there is one clock using a semi-fixed
FS rate, but that FS rate is subject to the high/low contraints of the
cpu/codec.

In simple I can set  "simple-audio-card,mclk-fs = 512" but depending
on what music is being played it may violate the clock constraints on
the hardware. In my case the CPU happily generated 49Mhz and fed it
into a chip only capable of 27Mhz. But this codec needs the 512 fs
for low frame rate music.  I think the floor on the clock is 4Mhz.

Another solution would be something like "simple-audio-card,sysclk =
<22579200, 24576000>"  That would make both of these chips happy.

-- 
Jon Smirl
jonsmirl@gmail.com
