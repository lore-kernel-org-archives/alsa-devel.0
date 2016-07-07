From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 2/3] ALSA: control: add dimension validator
 for userspace element
Date: Thu, 7 Jul 2016 17:52:42 +0900
Message-ID: <577E185A.9070400@sakamocchi.jp>
References: <1467371413-16895-1-git-send-email-o-takashi@sakamocchi.jp>
 <1467371413-16895-3-git-send-email-o-takashi@sakamocchi.jp>
 <57766231.6060304@sakamocchi.jp> <s5hh9c8qxq3.wl-tiwai@suse.de>
 <577D029D.9090701@sakamocchi.jp> <s5h60sizy7w.wl-tiwai@suse.de>
 <577D1348.3040706@sakamocchi.jp> <s5h1t36zv6j.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id ACEDA2650FA
 for <alsa-devel@alsa-project.org>; Thu,  7 Jul 2016 10:52:52 +0200 (CEST)
In-Reply-To: <s5h1t36zv6j.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

On Jul 6 2016 23:40, Takashi Iwai wrote:
> On Wed, 06 Jul 2016 16:18:48 +0200,
> Takashi Sakamoto wrote:
>>
>> On Jul 6 2016 22:34, Takashi Iwai wrote:
>>> Yes, a validation of info->count is a good idea.
>>> And it can be even a simple WARN_ON().  It's a clear driver bug and
>>> it's better to be exposed as loudly as possible.
>>
>> OK.
>>
>> Then another question. The same function, snd_ctl_elem_info() uses a
>> combination of  at CONFIG_SND_DEBUG and snd_BUG_ON() to detect
>> info->access bug of each driver.
>>
>> http://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/tree/sound/core/control.c#n823
>>
>> I guess that this is an assertion that each driver must not touch
>> info->access in its implementations of 'snd_kcontrol_info_t'. On the
>> other hand, the detection is just enabled at CONFIG_SND_DEBUG.
>>
>> To me, it's strange, because ALSA control core changes its behaviour
>> depending on CONFIG_SND_DEBUG. If the option is off, buggy driver works.
>> Else, it brings kernel panic. This is quite confusing to both developers
>> of each driver and userspace applications.
>>
>> In ALSA kernel/userspace interfaces, info->access is described as read-only.
>> http://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/tree/include/uapi/sound/asound.h#n886
>>
>> Therefore, I think it better to set zero in advance of calling
>> 'snd_kcontrol_info_t' then check the return value with WARN_ON macro,
>> regardless of CONFIG_SND_DEBUG.
>>
>> Or should I apply snd_WARN_ON() or snd_BUG_ON() to validators of
>> info->type and info->count to keep code consistency?
>
> It's because we preferred the size optimization over the sanity check
> in the past.  A sanity check is a thing to be done only during the
> debug / development phase, and a production kernel we already have
> must be clean from such a stupid bug -- that's the idea behind it.
> That's why snd_BUG_ON() is enabled only with the debug option.
>
> (BTW, there is no snd_WARN_ON().  snd_BUG_ON() corresponds to
>   WARN_ON().)

Oh, it's too misleading to kernel newbies.
http://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/tree/include/sound/core.h#n351

Not intuitive at all. It's better to rename it to snd_WARN_ON()...

> This kind of concept was commonly seen in the earlier Linux kernels,
> as we had to care more about the memory footprint ("each byte
> matteres!"). Meanwhile, we have plenty of memory nowadays, and only
> few people really care about the kernel size.  Hence people prefer a
> standard macro (WARN_ON()) to an ALSA-specific one (snd_BUG_ON()) in
> general recently.  But, it doesn't necessarily mean that we *should*
> use / convert to WARN_ON().  It would still increase the kernel memory
> footprint.

The reduction of memory footprint is still interests to embedded 
developers. It's still better to care.

> If I were to implement something, I'd take WARN_ON() for now.  But
> keeping the same snd_BUG_ON() would be also good.  That said, I have
> no preference at all.  This is merely a sanity check, and each driver
> developer should test both with and without the debug option once,
> after all.

In my taste, enabling debug options is to retrieve more information 
about processing. It's worse practices to change bahaviours. (I can 
remember our discussion about tracepoints for snd-firewire-lib.)

Currently, I have no good idea to achieve both of small footprint and 
sanity check without the debug option. And what I'd like to achieve in 
this patchset is not to start discussion about it. In this time, I'll 
revise and post the second patch to improve handling of user-defined 
control element sets.


Regards

Takashi Sakamoto
