From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: Some questions about userspace control elements
Date: Thu, 05 Feb 2015 09:44:49 +0900
Message-ID: <54D2BD01.6020904@sakamocchi.jp>
References: <54CE10D2.7090903@sakamocchi.jp> <54CE675A.80004@ladisch.de>
 <54D2B075.4050005@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id B1A32260687
 for <alsa-devel@alsa-project.org>; Thu,  5 Feb 2015 01:44:53 +0100 (CET)
In-Reply-To: <54D2B075.4050005@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I want to add some supplement to my previous message.
(sorry to include some logic jump...)

On Feb 5 2015 08:51, Takashi Sakamoto wrote:
> The code is this one line.
>
> sound/core/control.c:1188
> {{{
> kctl.count = info->owner ? info->owner : 1;
> }}}
> http://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/tree/sound/core/control.c?id=6ccd93bdb989507717edb375d40534f1177822c5#n1188
>
> In this code, the value in struct snd_ctl_elem_info.owner is assigned to
> struct snd_kcontrol.count. The meaning of these two member is completely
> different but assigned.

When any userspace control element are added, the value of struct 
snd_ctl_elem_info.owner is zero because there's no API to set this 
member in userspace and snd_ctl_elem_info_alloca() or 
snd_ctl_elem_info_malloc() initialize allocated memory with zero.

Then, 1 is always assigned to the kctl.count.

> I guess that the reason is to limit the number of event generated when
> the control element set is operated. Actually, my sample code reports
> one event every time when operating the control element with 10 entries.
> But I believe this is the different behaviour as the kernel control
> elements do.

For example, 'add' event is generated in sound/core/contro.c:378. This 
event is generated several times as the number of count:
http://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/tree/sound/core/control.c?id=6ccd93bdb989507717edb375d40534f1177822c5#n376

Due to kctl.count is assigned to 1, the number of generated event for 
userspace control elements is one time.

> sound/core/control.c:257
> {{{
> kctl.count = ncontrol->count ? ncontrol->count : 1;
> }}}
> http://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/tree/sound/core/control.c?id=6ccd93bdb989507717edb375d40534f1177822c5#n257
>
> For me, the behaviour of userspace control element is a bit strange. The
> behaviour is legal as a control element?

On the other hand, in kernel control element, kctl.count is assigned to 
the value which each driver gives. Therefore, the number of generated 
events is the same as the number of element count.

In these reasons, the number of generated events is different between 
kernel/userspace control element.

Actually, there's a few kernel control elements in which the number of 
count is bigger than 1. So in most case, users cannot realize the 
differences to use ALSA control application such as alsamixer. The 
behaviour of userspace control elements looks like kernel control 
elements which major sound drivers give.

Please inform to me if my understanding is wrong.


Regards

Takashi Sakamoto
