From: Nicolas Herochao <nicolas@herochao.de>
Subject: Re: [PATCH] ALSA: usb-audio: update quirk for B&W PX to remove
 microphone
Date: Fri, 5 Oct 2018 00:31:47 +0200
Message-ID: <f1db1306-7156-7d0e-7b71-b8b1b43e840f@herochao.de>
References: <20181004144205.18153-1-nicolas@herochao.de>
 <s5h7eixl9d9.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5h7eixl9d9.wl-tiwai@suse.de>
Content-Language: en-US-large
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hey, Thanks for the quick response

Am 04.10.18 um 22:55 CEST schrieb Takashi Iwai:

> On Thu, 04 Oct 2018 16:42:05 +0200,
> Nicolas Huaman wrote:
>> A quirk in snd-usb-audio was added to automate setting sample rate to
>> 4800k and remove the previously exposed nonfunctional microphone for
>> the Bowers & Wilkins PX:
>> commit 240a8af929c7c57dcde28682725b29cf8474e8e5
>> https://lore.kernel.org/patchwork/patch/919689/
>>
>> However the headphones where updated shortly after that to remove the
>> unintentional microphone functionality. I guess because of this the
>> headphones now crash when connecting them via USB while the quirk is
>> active. Dmesg:
>>
>> snd-usb-audio: probe of 2-3:1.0 failed with error -22
>> usb 2-3: 2:1: cannot get min/max values for control 2 (id 2)
>>
>> This patch removes the microfone and allows the headphones to connect
>> and work out of the box. It is based on the current mainline kernel
>>   and successfully applied an tested on my machine (4.18.10.arch1-1).
>>
>> Signed-off-by: Nicolas Huaman <nicolas@herochao.de>
> Thanks, that looks much better now, and I can apply it.
>
> But just to be sure: is any quirk required after the firmware update
> on this device at all?  What happens if you remove the whole quirk?

Yes, the sample-rate problem is still present. I initially tried 
disabling the quirk, but then I needed to set the default sample rate of 
pulse to 48k again for the headphones to play sound, which is why I 
wanted to find out how to fix it completely.

This problem doesn't appear on windows (I think windows defaults to 
48k?). Perhaps that's the reason why it wasn't patched in a firmware 
update up until now.

> If this modified quirk is still mandatory, I'll happily apply the
> patch.
>
>
> thanks,
>
> Takashi

The headphones I got already had the fixed firmware version, but even 
older headphones can be updated using Android, IOS or Windows.

My Fix corrects detection for headphones with all Firmware after 
February 2018, so I think this quirk probably presents the best solution 
for now, especially since the nonfunctional microphone of older Firmware 
appeared on all platforms.

Thank you for your time, the help and feedback!

Best Regards,

Nicolas
