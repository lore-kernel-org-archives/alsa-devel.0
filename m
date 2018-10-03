From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 2/7] ALSA: core: Add managed card creation
Date: Wed, 3 Oct 2018 13:05:33 +0900
Message-ID: <ccae39c3-87ec-2ca8-15fe-5abdb314925e@sakamocchi.jp>
References: <20180920155502.7534-1-tiwai@suse.de>
 <20180920155502.7534-3-tiwai@suse.de>
 <3e095236-3b06-c8b3-220b-6af99bc65c9e@sakamocchi.jp>
 <s5hd0t7uzqr.wl-tiwai@suse.de>
 <e42b6193-a0ac-dad8-b9fd-4920a6e157c5@sakamocchi.jp>
 <s5hh8i4qpkd.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 1311D2676A7
 for <alsa-devel@alsa-project.org>; Wed,  3 Oct 2018 06:05:41 +0200 (CEST)
In-Reply-To: <s5hh8i4qpkd.wl-tiwai@suse.de>
Content-Language: en-US
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

Thanks for you to be involved in this issue.

On Oct 3 2018 01:30, Takashi Iwai wrote:
>>> The snd_card_free() syncs with the release of the all active files,
>>> i.e. it waits until all accesses get released, then proceed to the
>>> further procedures to free resources, including the call of
>>> private_free.  Hence this call itself should be safe, as long as it's
>>> called at first.
>>
>> I overlooked that snd_card_free() calls 'wait_for_completion()'. Thanks
>> for your indication. As you said, no worries.
>>
>> Here I have another concern about timing for processes to return from
>> unbinding operation. For example:
>>
>> echo '0000:0a:00.1' > /sys/bus/pci/drivers/snd_hda_intel/unbind
>>
>> This process returns when the other processes close all of ALSA
>> character devices related to the sound card because wait for completion
>> is executed in context of the process. Well-programmed userspace
>> applications are expected to release the character devices when
>> received -ENODEV from ioctl(2) or EPOLLERR/EPOLLNVAL from poll(2) to
>> the character devices.
>>
>> I don't know exactly that it's acceptable to block a process which
>> performs unbinding, depending on behaviours of the other processes.
>> In a point of safe ABI, it's worth for us to consider or decide a
>> policy for the point.
> 
> Right, the behavior of unbind is currently sub-optimal.  But basically
> it's above this devres patch series; the unbind behavior itself
> doesn't change no matter whether the resource is released via devres
> or not.  So we can keep discussing about this, but maybe in another
> thread.

Indeed.

For this patch, I have another concern and will post it soon (for a
helper function to release memory object immediately).

> When we see unbind as a sort of hot-unplug action, it's understandable
> that unbind never returns an error.  And that's the current situation,
> and it implies that every driver needs to take care of all pending
> resources by itself.  Hence, you have only two choices: block and sync
> with the pending resources, or make everything in async.
>
> As of now, the most of drivers take the former approach -- at least
> for sound stuff -- just because of simplicity.  Admittedly, the latter
> approach would look better from the user-space POV.  However, it'll be
> far complicated in the actual implementation.

I note that all drivers in ALSA firewire stack are implemented according
to the 'async' scenario. Usage of reference counting of struct device
for units on IEEE 1394 bus is used to achieve it.

> Maybe another consideration would be to allow unbind action actually
> returning -EBUSY error.  This option would require the driver base
> code change, and above all, the consensus from other parties.

At present, 'unbind_store()' in 'drivers/base/bus.c'[1] can return
-ENODEV if error, or the length of given string if success. It's
possible for us to change this function to return -EBUSY when the target
device is still referred after a call of 'device_release_driver()'. But
this is wider issue in Linux DD and should be discussed in a right
place.

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/base/bus.c?h=v4.19-rc6#n177


Thanks

Takashi Sakamoto
