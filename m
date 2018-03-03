From: Hui Wang <hui.wang@canonical.com>
Subject: Re: [alsa-devel] [PATCH] ALSA: hda - Fix a wrong FIXUP for alc289 on
 Dell machines
Date: Sat, 3 Mar 2018 20:38:54 +0800
Message-ID: <07f431b1-5523-f525-421b-0ecbaf93409b@canonical.com>
References: <1519967136-8955-1-git-send-email-hui.wang@canonical.com>
 <s5hy3jahmym.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <s5hy3jahmym.wl-tiwai@suse.de>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, kailang@realtek.com, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 2018年03月02日 16:59, Takashi Iwai wrote:
> On Fri, 02 Mar 2018 06:05:36 +0100,
> Hui Wang wrote:
>> With the alc289, the Pin 0x1b is Headphone-Mic, so we should assign
>> ALC269_FIXUP_DELL4_MIC_NO_PRESENCE rather than
>> ALC225_FIXUP_DELL1_MIC_NO_PRESENCE to it. And this change is suggested
>> by Kailang of Realtek and is verified on the machine.
>>
>> (This fixes the commit 3f2f7c55)
> Please use "Fixes:" tag to indicate that.
Got it, will use "Fixes:" in future.

Thanks,
Hui.
>
>> Cc: Kailang Yang <kailang@realtek.com>
>> Cc: <stable@vger.kernel.org>
>> Signed-off-by: Hui Wang <hui.wang@canonical.com>
> Applied now, thanks.
>
>
> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
