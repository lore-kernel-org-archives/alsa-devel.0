From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: Ordering in soc_pcm_hw_params()
Date: Wed, 13 Aug 2014 19:47:48 +0200
Message-ID: <53EBA4C4.5000608@metafoo.de>
References: <CAKON4OzQF8sDigvcDFsJaJRVX9o4X1FiC2FEU8D6n=oaQkX+Uw@mail.gmail.com>	<53E9D383.5060103@metafoo.de>	<CAKON4Ow3HFL0Sv2AV7+-XS0PBHnP9WW_8FBgrV=cKp14LER9XA@mail.gmail.com>	<CAKON4OzrJSAD0RUL5TO6n8mxG0q9rRau0MWaAXvXVo+bSB8Ygg@mail.gmail.com>	<20140812115755.GO17528@sirena.org.uk>	<CAKON4OyOL2asou5NvL0crcAy=wYdguBYpc7w+x0xcUUf93FxUw@mail.gmail.com>	<20140812182029.GX17528@sirena.org.uk>	<CAKON4Oyi8x_P5kLQrW3EVsr0aw8-9VnfJXWEhKgJCDsQi9L6UA@mail.gmail.com>	<20140813163525.GY17528@sirena.org.uk>
 <CAKON4OzBKJbAzT6MVMT_jkuVFf6jYF5Pe=fFA2ZbhGSNkHbtgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-155.synserver.de (smtp-out-157.synserver.de
 [212.40.185.157])
 by alsa0.perex.cz (Postfix) with ESMTP id CEED9265572
 for <alsa-devel@alsa-project.org>; Wed, 13 Aug 2014 19:47:50 +0200 (CEST)
In-Reply-To: <CAKON4OzBKJbAzT6MVMT_jkuVFf6jYF5Pe=fFA2ZbhGSNkHbtgg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "jonsmirl@gmail.com" <jonsmirl@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Nicolin Chen <Guangyu.Chen@freescale.com>
List-Id: alsa-devel@alsa-project.org

On 08/13/2014 07:00 PM, jonsmirl@gmail.com wrote:
> On Wed, Aug 13, 2014 at 12:35 PM, Mark Brown <broonie@kernel.org> wrote:
>> On Wed, Aug 13, 2014 at 08:25:22AM -0400, jonsmirl@gmail.com wrote:
>>> On Tue, Aug 12, 2014 at 2:20 PM, Mark Brown <broonie@kernel.org> wrote:
>>
>>>>> 2) Should sysclk for the cpu-dai and codec-dai be set independently?
>>>>> In simple-card they can be set to conflicting values on the two nodes
>>>>> in the DTS. Should sysclk be a single property for the machine?
>>
>>>> No, clocks might be at different rates for different devices.  One
>>>> device might divide down the clock to the other.
>>
>>> What do you think about adding fields for min/max allowed sysclk to
>>> snd_soc_dai_driver? In my case the SOC can run the sysclk at 100Mhz,
>>> but the attached codec can only handle 27Mhz.
>>
>> If we're going to do constraints they should be done properly so need to
>> be able to represent specific numbers too.  It's probably a clock API
>> problem, independently implementing it seems redundant.  Doing simple
>> things in simple-card for the common cases makes sense while the clock
>> API isn't something we can rely on but equally we don't want to be doing
>> huge amounts, and of course simple-card is just a subset of what people
>> are doing.
>
> Right now I could make the set_sysclk implementations return -EINVAL
> if the clock is out of range. Then add some logic to simple-card to
> try again with a different FS multipler. Or at least I can print some
> error message to give a clue as to why the song won't play.

The driver should definitely reject sysclk rates it can not support. I think 
this idea is what will give you the best results, at least short term. It 
quite simple to implement yet effective at solving the problem and does not 
add new DT ABI that we need to support forever. It could later be replaced 
with a more sophisticated fs rate enumeration scheme.

- Lars
