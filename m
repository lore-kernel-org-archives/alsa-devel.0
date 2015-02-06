From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Some questions about userspace control elements
Date: Fri, 06 Feb 2015 10:38:48 +0100
Message-ID: <54D48BA8.6060104@ladisch.de>
References: <54CE10D2.7090903@sakamocchi.jp> <54CE675A.80004@ladisch.de>
 <54D2B075.4050005@sakamocchi.jp> <54D2BD01.6020904@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id BA34B2604FA
 for <alsa-devel@alsa-project.org>; Fri,  6 Feb 2015 10:38:49 +0100 (CET)
In-Reply-To: <54D2BD01.6020904@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Takashi Sakamoto wrote:
> On Feb 5 2015 08:51, Takashi Sakamoto wrote:
>> sound/core/control.c:1188
>> {{{
>> kctl.count = info->owner ? info->owner : 1;
>> }}}
>>
>> In this code, the value in struct snd_ctl_elem_info.owner is assigned to
>> struct snd_kcontrol.count. The meaning of these two member is completely
>> different but assigned.

There is hardware that has many identical controls.  To save memory,
ALSA treats controls with .count > 1 as if there were multiple controls.

This optimization is not visible in the userspace API.

The owner field is used because there is no other field to set the
count.

> When any userspace control element are added, the value of struct
> snd_ctl_elem_info.owner is zero because there's no API to set this
> member in userspace

So far, setting this field has not been needed.  An API could be added.

>> I guess that the reason is to limit the number of event generated when
>> the control element set is operated.

If a driver needs twenty identical controls, it could create one control
with count=20, or twenty controls with count=1.  In both cases, twenty
events are sent.


Regards,
Clemens
