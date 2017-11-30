From: Tamaki Nishino <otamachan@gmail.com>
Subject: Re: [PATCH] ALSA: usb-audio: Fix the enable parameter
	behavior
Date: Thu, 30 Nov 2017 19:08:51 +0900
Message-ID: <CABwGrsbdD2wzJQoQMHkCGhw+0BVkc4fy9_ZnCkzaM7-9Joay2w@mail.gmail.com>
References: <1511994376-1803-1-git-send-email-otamachan@gmail.com>
 <s5h374wi1aa.wl-tiwai@suse.de>
Reply-To: otamachan@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vk0-f45.google.com (mail-vk0-f45.google.com
 [209.85.213.45])
 by alsa0.perex.cz (Postfix) with ESMTP id C5BDC266A74
 for <alsa-devel@alsa-project.org>; Thu, 30 Nov 2017 11:08:53 +0100 (CET)
Received: by mail-vk0-f45.google.com with SMTP id u84so3051123vke.10
 for <alsa-devel@alsa-project.org>; Thu, 30 Nov 2017 02:08:53 -0800 (PST)
In-Reply-To: <s5h374wi1aa.wl-tiwai@suse.de>
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

Hi Takashi,
Thanks for your feedback.

I'm sorry but I didn't know the origin of the enable option.
So is it acceptable like
---
Change the semantics of the enable option for snd-usb-audio

This patch changes the semantics of the enable option for snd-usb-audio
in order to allow users to disable a device specified by either or both of the
vendor id and the product id.
---

I would appreciate for your any feedback in advance.

Best regards,

Tamaki

On Thu, Nov 30, 2017 at 6:06 PM, Takashi Iwai <tiwai@suse.de> wrote:
> On Wed, 29 Nov 2017 23:26:16 +0100,
> Tamaki Nishino wrote:
>>
>> The enable parameter doesn't seem to work as expected. Even when the
>> enable parameter is set to false in /etc/modprobe.d/alsa-base.conf like
>> "options snd-usb-audio index=-2 vid=0x1415 pid=0x1d27 enable=0",
>> the specified device is not disabled.
>>
>> This patch fixes the enable parameter behavior to disable the device
>> correctly.
>
> Heh, strictly speaking, this is no "fix".  The behavior of the current
> enable option is "correct", per se; it disables the first-defined
> slot, and in the case of USB-audio, the probe continues to the next
> slot as it's a hot-plug device.
>
> OTOH, it's just badly designed, and the option is present just for
> compatibility with other modules -- e.g. YaST has put enable option
> always when configuring manually.
>
> So, I find it OK to change the semantics of this option, as it's
> practically useless, and the breakage is very unlikely.
> But please make it clear that the patch is rather to improve the
> usability, not about the correctness.
>
>
> thanks,
>
> Takashi
