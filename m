From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [RFC PATCH 1/2] regmap: add configurable lock
	class key for lockdep
Date: Mon, 29 Jun 2015 14:59:57 +0200
Message-ID: <5591414D.6080802@metafoo.de>
References: <1435224904-35517-1-git-send-email-drinkcat@chromium.org>	<558C0067.2000401@linux.intel.com>	<558C1824.8020204@metafoo.de>	<20150625153325.GR14071@sirena.org.uk>	<558C229D.4090409@metafoo.de>	<20150625160817.GT14071@sirena.org.uk>	<CANMq1KA2C1ZYUd_s_R5DWn-Hy_XZZQ_aaR47VLpPsNvcvxEQ9w@mail.gmail.com>
 <CANMq1KBcWw9jsGkrK0dYzOWGZAZYmHdo6gvvpQwt_ftq+avqVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-251.synserver.de (smtp-out-251.synserver.de
 [212.40.185.251])
 by alsa0.perex.cz (Postfix) with ESMTP id 5F227260559
 for <alsa-devel@alsa-project.org>; Mon, 29 Jun 2015 15:00:06 +0200 (CEST)
In-Reply-To: <CANMq1KBcWw9jsGkrK0dYzOWGZAZYmHdo6gvvpQwt_ftq+avqVg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolas Boichat <drinkcat@chromium.org>, Mark Brown <broonie@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Anatol Pomozov <anatol.pomozov@gmail.com>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Takashi Iwai <tiwai@suse.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Antti Palosaari <crope@iki.fi>, Bard Liao <bardliao@realtek.com>, Arjan van de Ven <arjan@linux.intel.com>, Ingo Molnar <mingo@redhat.com>
List-Id: alsa-devel@alsa-project.org

On 06/29/2015 02:51 PM, Nicolas Boichat wrote:
> On Fri, Jun 26, 2015 at 11:16 AM, Nicolas Boichat <drinkcat@chromium.org> wrote:
>>
>> On Fri, Jun 26, 2015 at 12:08 AM, Mark Brown <broonie@kernel.org> wrote:
>> [...]
>>>>> As far as I can tell we're likely to end up needing a key per regmap or
>>>>> something similar.
>>>
>>>> Since the number of lockdep classes itself is also limited we should avoid
>>>> creating extra lockdep classes when we can. I think the approach which
>>>> having the option of specifying a lockdep class in the regmap config will be
>>>> ok. The only case it can't handle if we nest instances with the same config,
>>>> but I don't really see valid use scases for that at the moment.
>>>
>>> Oh, ffs.  This just keeps getting better.  I hadn't been aware of that
>>> limitation.  We still have the problem that this needs to be something
>>> users can understand rather than something that's just "define something
>>> here in one of your drivers if you're running into problems with
>>> spurious warnings" here.  That's always been the biggest problem here
>>> (once we got past the "what is this supposed to do in the first place?"
>>> issues).
>>
>> I found that V4L2 uses separate lockdep classes for each of their
>> v4l2_ctrl. This was introduced in 6cd247ef22e "[media] v4l2-ctrls:
>> eliminate lockdep false alarms for struct v4l2_ctrl_handler.lock"
>> (https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=6cd247ef22e),
>> so we could possibly take that approach.
>>
>> On my system, I have:
>> # cat /proc/lockdep_stats
>>   lock-classes:                         1241 [max: 8191]
>>   direct dependencies:                  7364 [max: 32768]
>>   indirect dependencies:               27686
>>   all direct dependencies:            158097
>>   dependency chains:                   10011 [max: 65536]
>>   dependency chain hlocks:             38887 [max: 327680]
>>   in-hardirq chains:                      92
>>   in-softirq chains:                     372
>>   in-process chains:                    9547
>>   stack-trace entries:                107703 [max: 524288]
>>
>> So, at least on that platform, there is some room to grow...
>>
>> I'm just afraid that implementing this may require creating a bunch of
>> macros to wrap all regmap_init_[i2c/spi/...] functions, as the lockdep
>> classes need to be statically allocated... Unless we find a different
>> solution than what V4L2 does.
>
> Following up on this. Lars-Peter's comments also highlights that we
> have no good way to figure out which regmap requires a separate maps,
> no clear hierarchy we can know about in advance, so we should put each
> regmap in its own class.
>
> The main issue is that the keys need to be allocated statically. We
> have 2 options to do this:
>
> 1. mutex_init and v4l2_ctrl_handler_init solve this issue by being a
> preprocessor macro that first allocates a static lock_class_key, then
> calls the real init function.
> This is not so practical in the case of regmap, as we have 14
> different init functions ([devm_]regmap_init[_bus_type]), that would
> each require a wrapper.
>
> 2. Bus registration takes a different approach
> (https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=be871b7e5):
> struct bus_type (statically allocated for each bus) has a lock_key
> member: "struct lock_class_key lock_key;".
> In the context of regmaps, that would mean adding a "lock_key" member
> to regmap_config. I did a quick implementation of this idea, and it
> seems to work, without modification to the rt5677 driver. The only
> issue with this is that regmap_config cannot be const anymore: we'd
> need to remove the const specifier in all drivers that use regmaps.

Yeah, I though about that as well, but the problem is the regmap_config is 
only valid during regmap_init() and can for example be placed on the stack. 
In which case it won't work anymore.

>
> Both alternatives would mean that all regmaps created from 1. the same
> line of code, or 2. the same regmap_config, would share the same
> class. That may not be an issue, however (do we have an example of
> different regmaps created from the same line/config that need to call
> each other?), and the custom mutex workaround is still available....
>
> Any preference between a bunch of macros, and adding a non-const
> member to regmap_config? Or maybe someone has a better idea?

Maybe we are just over-thinking this and should just add one key to each 
regmap instance. That solves the issue without requiring the any user 
interaction. The only downside is that it might impact the performance of 
lockdep and uses quite a few lock classes. Its probably manageable right now 
but could grow into a problem as regmap adoption further progresses. But 
maybe we can leave the hard work of figuring a better solution to our future 
selves.

- Lars
