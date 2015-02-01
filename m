From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Some questions about userspace control elements
Date: Sun, 01 Feb 2015 18:50:18 +0100
Message-ID: <54CE675A.80004@ladisch.de>
References: <54CE10D2.7090903@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 7F5D6260411
 for <alsa-devel@alsa-project.org>; Sun,  1 Feb 2015 18:50:25 +0100 (CET)
In-Reply-To: <54CE10D2.7090903@sakamocchi.jp>
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
> 1.The 'numid' is unique number for each element or not?
> I want to use it to indicate each element, if possible. But there're
> more members in snd_ctl_elem_id structure.

The other members help with searching elements.  But numid itself must
be unique.

> 2.The 'numid' can be notified in SND_CTL_EVENT_MASK_ADD event?
> As long as I test, it's always zero when userspace applications add any
> elements. Is it an expected behaviour? Or a bug?

This looks like a bug in the kernel code.

All the other members of the id structure should be correct; as
a workaround, try calling snd_ctl_elem_info().

> 3.The way to change permissions of each control element.
> Is it possible after adding the elements? If possible, how to notify it
> in the other processes?

At the moment, this is not possible for userspace controls.

What bit(s) do you want to change?

> 4.Any elements added by a process are not removed at closing snd_ctl_t.
> They're remained after closing the process' snd_ctl_t. Is it an expected
> behaviour? Or a bug?

This is by design.  These controls are intended to be a property of the
device itself, and to be somewhat permanent.

> 5.Processes can delete elements which the other processes added.
> Is it an expected behaviour? Or a bug?

For permanent controls, it would not be possible to remember which
process created them originally.

> 6.The operation to replace elements generates separate events.
> ADD/REMOVE events occurs sequencially. Userspace application cannot
> distinguish replacement from adding/removing, therefore cannot process
> appropriate action. Is it an expected behaviour? Or a bug?

Replacement is just a shortcut for removing/adding.  So far, changing
the properties of userspace controls has not been necessary.


Regards,
Clemens
