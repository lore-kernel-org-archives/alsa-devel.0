From: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Subject: Re: Ordering in soc_pcm_hw_params()
Date: Wed, 13 Aug 2014 13:00:02 -0400
Message-ID: <CAKON4OzBKJbAzT6MVMT_jkuVFf6jYF5Pe=fFA2ZbhGSNkHbtgg@mail.gmail.com>
References: <CAKON4OzQF8sDigvcDFsJaJRVX9o4X1FiC2FEU8D6n=oaQkX+Uw@mail.gmail.com>
 <53E9D383.5060103@metafoo.de>
 <CAKON4Ow3HFL0Sv2AV7+-XS0PBHnP9WW_8FBgrV=cKp14LER9XA@mail.gmail.com>
 <CAKON4OzrJSAD0RUL5TO6n8mxG0q9rRau0MWaAXvXVo+bSB8Ygg@mail.gmail.com>
 <20140812115755.GO17528@sirena.org.uk>
 <CAKON4OyOL2asou5NvL0crcAy=wYdguBYpc7w+x0xcUUf93FxUw@mail.gmail.com>
 <20140812182029.GX17528@sirena.org.uk>
 <CAKON4Oyi8x_P5kLQrW3EVsr0aw8-9VnfJXWEhKgJCDsQi9L6UA@mail.gmail.com>
 <20140813163525.GY17528@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f48.google.com (mail-la0-f48.google.com
 [209.85.215.48])
 by alsa0.perex.cz (Postfix) with ESMTP id AF517261A2F
 for <alsa-devel@alsa-project.org>; Wed, 13 Aug 2014 19:00:05 +0200 (CEST)
Received: by mail-la0-f48.google.com with SMTP id gl10so19443lab.21
 for <alsa-devel@alsa-project.org>; Wed, 13 Aug 2014 10:00:03 -0700 (PDT)
In-Reply-To: <20140813163525.GY17528@sirena.org.uk>
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

On Wed, Aug 13, 2014 at 12:35 PM, Mark Brown <broonie@kernel.org> wrote:
> On Wed, Aug 13, 2014 at 08:25:22AM -0400, jonsmirl@gmail.com wrote:
>> On Tue, Aug 12, 2014 at 2:20 PM, Mark Brown <broonie@kernel.org> wrote:
>
>> >> 2) Should sysclk for the cpu-dai and codec-dai be set independently?
>> >> In simple-card they can be set to conflicting values on the two nodes
>> >> in the DTS. Should sysclk be a single property for the machine?
>
>> > No, clocks might be at different rates for different devices.  One
>> > device might divide down the clock to the other.
>
>> What do you think about adding fields for min/max allowed sysclk to
>> snd_soc_dai_driver? In my case the SOC can run the sysclk at 100Mhz,
>> but the attached codec can only handle 27Mhz.
>
> If we're going to do constraints they should be done properly so need to
> be able to represent specific numbers too.  It's probably a clock API
> problem, independently implementing it seems redundant.  Doing simple
> things in simple-card for the common cases makes sense while the clock
> API isn't something we can rely on but equally we don't want to be doing
> huge amounts, and of course simple-card is just a subset of what people
> are doing.

Right now I could make the set_sysclk implementations return -EINVAL
if the clock is out of range. Then add some logic to simple-card to
try again with a different FS multipler. Or at least I can print some
error message to give a clue as to why the song won't play.

What ASoC platforms haven't implemented the clock API? Using the clock
API, simple-card would have a phandle to the clock master. Then it
could set the proposed rate into it. Codec and CPU would have
clk_notifier implemented so that they could reject the proposed change
based on their constraints.  Simple could then adjust the FS multiple
until both devices are happy.

// from clock API
struct clk_notifier_data {
         struct clk *clk;
         unsigned long old_rate;
         unsigned long new_rate;
};



-- 
Jon Smirl
jonsmirl@gmail.com
