From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: Some questions about userspace control elements
Date: Sat, 07 Feb 2015 10:58:19 +0900
Message-ID: <54D5713B.2000406@sakamocchi.jp>
References: <54CE10D2.7090903@sakamocchi.jp>
 <54CE675A.80004@ladisch.de>	<54D2B075.4050005@sakamocchi.jp>
 <54D2BD01.6020904@sakamocchi.jp> <54D48BA8.6060104@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 54DB42652E1
 for <alsa-devel@alsa-project.org>; Sat,  7 Feb 2015 02:58:24 +0100 (CET)
In-Reply-To: <54D48BA8.6060104@ladisch.de>
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

Hi Clemens,

On Feb 6 2015 18:38, Clemens Ladisch wrote:
> Takashi Sakamoto wrote:
>> On Feb 5 2015 08:51, Takashi Sakamoto wrote:
>>> sound/core/control.c:1188
>>> {{{
>>> kctl.count = info->owner ? info->owner : 1;
>>> }}}
>>>
>>> In this code, the value in struct snd_ctl_elem_info.owner is assigned to
>>> struct snd_kcontrol.count. The meaning of these two member is completely
>>> different but assigned.
> 
> There is hardware that has many identhtical controls.  To save memory,
> ALSA treats controls with .count > 1 as if there were multiple controls.
>
> This optimization is not visible in the userspace API.

In my understanding, it's due to the granularity of operation. If we
assume a PCI device has one register to express several control elements
as bitfield. One read or write operation can handle these controls. Such
control elements can be expressed in one ALSA control substance.

> The owner field is used because there is no other field to set the
> count.

No. In SNDRV_CTL_IOCTL_ELEM_ADD ioctl, struct snd_ctl_elem_info.count
has the number of elements in this control, there it's an abuse of
member unrelated to the count.

>> When any userspace control element are added, the value of struct
>> snd_ctl_elem_info.owner is zero because there's no API to set this
>> member in userspace
> 
> So far, setting this field has not been needed.  An API could be added.

I cannot find the advantage to add such API in userspace. The value of
owner field SHOULD be set just by lock/unlock API.

>>> I guess that the reason is to limit the number of event generated when
>>> the control element set is operated.
> 
> If a driver needs twenty identical controls, it could create one control
> with count=20, or twenty controls with count=1.  In both cases, twenty
> events are sent.

But this is not applied to userspace controls because a control with 20
elements can generate one events instead of 20.

This is ugly because it demands userspace applications to distinguish
kernel/userspace application in event handling.


Thanks

Takashi Sakamoto
