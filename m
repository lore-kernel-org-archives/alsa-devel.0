From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH v4] ALSA: fireworks: accessing to user space outside
 spinlock
Date: Wed, 31 Aug 2016 23:29:08 +0900
Message-ID: <78e03957-f36a-0d10-9f9e-a03f73164114@sakamocchi.jp>
References: <1472651922-12100-1-git-send-email-o-takashi@sakamocchi.jp>
 <1472651922-12100-2-git-send-email-o-takashi@sakamocchi.jp>
 <s5hoa49f2cw.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <s5hoa49f2cw.wl-tiwai@suse.de>
Sender: stable-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: clemens@ladisch.de, alsa-devel@alsa-project.org, ffado-devel@lists.sf.net, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Aug 31 2016 23:18, Takashi Iwai wrote:
> On Wed, 31 Aug 2016 15:58:42 +0200,
> Takashi Sakamoto wrote:
>>
>> In hwdep interface of fireworks driver, accessing to user space is in a
>> critical section with disabled local interrupt. Depending on architecture,
>> accessing to user space can cause page fault exception. Then local
>> processor stores machine status and handles the synchronous event. A
>> handler corresponding to the event can call task scheduler to wait for
>> preparing pages. In a case of usage of single core processor, the state to
>> disable local interrupt is worse because it don't handle usual interrupts
>> from hardware.
>>
>> This commit fixes this bug, performing the accessing outside spinlock. This
>> commit also gives up counting the number of queued response messages to
>> simplify ring-buffer management.
>>
>> Reported-by: Vaishali Thakkar <vaishali.thakkar@oracle.com>
>> Cc: stable@vger.kernel.org
>> Fixes: 555e8a8f7f14('ALSA: fireworks: Add command/response functionality into hwdep interface')
>> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> 
> Applied, thanks.
> 
> Though, now I think whether it could be more easily fixed just by
> replacing spinlock with a mutex.  But this patch is good and simple
> enough, so I take it.

Copying to ring-buffer is done in software IRQ context, with referring
to pull/push pointers, therefore we should use lock primitives without
calling task scheduler.

In the other aim to handle several tasks in process context, I've also
investigated usage of mutex, but cannot avoid using copy_to_user() in
held mutex. In this case, neither usage of spinlock nor mutex has
differences.


Thanks

Takashi Sakamoto
