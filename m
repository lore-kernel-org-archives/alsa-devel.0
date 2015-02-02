From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: Some questions about userspace control elements
Date: Mon, 02 Feb 2015 23:14:39 +0900
Message-ID: <54CF864F.8060208@sakamocchi.jp>
References: <54CE10D2.7090903@sakamocchi.jp> <54CE675A.80004@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id D0DC8260614
 for <alsa-devel@alsa-project.org>; Mon,  2 Feb 2015 15:14:45 +0100 (CET)
In-Reply-To: <54CE675A.80004@ladisch.de>
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

Thanks for your answer. I want to discuss about the design of ALSA
userspace controls with you, while today I've read some related kernel
codes and realized they're more buggy than I expected...perhaps. I'd
like to start discussion after fixing them.


Thanks

Takashi Sakamoto

On Feb 2 2015 02:50, Clemens Ladisch wrote:
> Takashi Sakamoto wrote:
>> 1.The 'numid' is unique number for each element or not?
>> I want to use it to indicate each element, if possible. But there're
>> more members in snd_ctl_elem_id structure.
> 
> The other members help with searching elements.  But numid itself must
> be unique.
> 
>> 2.The 'numid' can be notified in SND_CTL_EVENT_MASK_ADD event?
>> As long as I test, it's always zero when userspace applications add any
>> elements. Is it an expected behaviour? Or a bug?
> 
> This looks like a bug in the kernel code.
> 
> All the other members of the id structure should be correct; as
> a workaround, try calling snd_ctl_elem_info().
> 
>> 3.The way to change permissions of each control element.
>> Is it possible after adding the elements? If possible, how to notify it
>> in the other processes?
> 
> At the moment, this is not possible for userspace controls.
> 
> What bit(s) do you want to change?
> 
>> 4.Any elements added by a process are not removed at closing snd_ctl_t.
>> They're remained after closing the process' snd_ctl_t. Is it an expected
>> behaviour? Or a bug?
> 
> This is by design.  These controls are intended to be a property of the
> device itself, and to be somewhat permanent.
> 
>> 5.Processes can delete elements which the other processes added.
>> Is it an expected behaviour? Or a bug?
> 
> For permanent controls, it would not be possible to remember which
> process created them originally.
> 
>> 6.The operation to replace elements generates separate events.
>> ADD/REMOVE events occurs sequencially. Userspace application cannot
>> distinguish replacement from adding/removing, therefore cannot process
>> appropriate action. Is it an expected behaviour? Or a bug?
> 
> Replacement is just a shortcut for removing/adding.  So far, changing
> the properties of userspace controls has not been necessary.
> 
> 
> Regards,
> Clemens
