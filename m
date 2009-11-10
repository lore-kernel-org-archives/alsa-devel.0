From: Troy Kisky <troy.kisky@boundarydevices.com>
Subject: Re: [PATCH] ALSA: hda_intel: disable corb rirb when
 single_cmd active
Date: Tue, 10 Nov 2009 14:15:27 -0700
Message-ID: <4AF9D7EF.6000800@boundarydevices.com>
References: <1257276157-7164-1-git-send-email-troy.kisky@boundarydevices.com>	<s5hd43yzov7.wl%tiwai@suse.de>	<4AF1D9D0.9080007@boundarydevices.com>	<s5h7hu5cv01.wl%tiwai@suse.de>	<4AF32A8B.4050404@boundarydevices.com>	<s5h3a4s86j7.wl%tiwai@suse.de>	<s5hiqdo80xq.wl%tiwai@suse.de>	<4AF4C6E7.8010807@boundarydevices.com>	<s5hfx8qybfx.wl%tiwai@suse.de>	<4AF86F3F.9020709@boundarydevices.com>
	<s5hhbt2g7gp.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpauth00.csee.onr.siteprotect.com
	(smtpauth00.csee.onr.siteprotect.com [64.26.60.144])
	by alsa0.perex.cz (Postfix) with ESMTP id 6B96E103888
	for <alsa-devel@alsa-project.org>; Tue, 10 Nov 2009 22:15:34 +0100 (CET)
In-Reply-To: <s5hhbt2g7gp.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: pshou@realtek.com.tw, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Mon, 09 Nov 2009 12:36:31 -0700,
> Troy Kisky wrote:
>> Takashi Iwai wrote:
>>> Thanks for a quick test!  I'll merge it soon.
>>>
>>>> Thanks for spending your time on something you'd rather not.
>>> Well, I'm willing to fix any bugs, of course ;)  So I really
>>> appreciated your report and patch.
>>>
>>> But, more important bug still remains -- why single_cmd mode is
>>> activated.  Let's track it down.
>>>
>> I have a little more information on that. The RIRB engine is fine
>> but the CORB engine is stopping at seemingly random times. Usually
>> CORB has about 7 commands queued when it switches to single_cmd mode.
>> After the engine dies, even a rmmod/insmod sequence won't revive it.
>> It seems to require a power down/up. I have noticed a couple of things
>> that I thought might be related, but testing didn't show much difference.
>>
>> 1. The Poulsbo manual says that CORB READ Pointer Reset must be cleared
>> back to 0 and read back as 0 to verify that the clear completed correctly.
> 
> At which timing?

The manual was talking about the CORB read pointer reset sequence. It says
to set the bit, verify set, clear the bit, verify clear. Whereas the
normal hda spec says to just set it and forget it, which is what the code does.

> 
>> 2. azx_corb_send_cmd doesn't compare CORBWP with CORBRP to see if adding
>> an entry will result in an empty queue.
> 
> It's because azx_corb_send_cmd is asynchronous.  It doesn't wait.
> That's the purpose of CORB being a ring buffer...

Still, the circular buffer is a fixed size (256 entries in this case).
The code does not detect if you try to stuff 257 entries into the queue.
Actually, 255 entries is the max you should stuff. The next entry being
stuffed will make the read pointer equal the write pointer and the queue
will be empty. I'm not saying this is likely to ever happen. But if it did
happen, you would end up in single_cmd mode.

> 
>> Do you have a suggestion on a more thorough reset? I hate having to reboot
>> all the time.
> 
> Try to set codec->bus->sync_write = 1 somewhere in the initialization.
> This will make the driver to wait and synchronize for each verb
> response.

OK. I'll give a try.

Thanks
Troy
