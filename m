From: Akshay Bhat <akshay.bhat@timesys.com>
Subject: Re: [PATCH] ALSA: usb-audio: Add sample rate inquiry quirk for B850V3
 CP2114
Date: Mon, 29 Aug 2016 10:45:58 -0400
Message-ID: <213c88ea-f178-cd04-35a7-cb1263c993b1@timesys.com>
References: <1471025327-3529-1-git-send-email-akshay.bhat@timesys.com>
 <CACrMeVBgQS4je7ny_r83Xi-7yX-AzR2YVT_gHyp5U7m2LpFoyA@mail.gmail.com>
 <s5hfupn4q9z.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hfupn4q9z.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: perex@perex.cz, Ken Lin <ken.lin@advantech.com.tw>, alsa-devel@alsa-project.org, guillaume@eulerian.com, denk@post.com, vdronov@redhat.com, linux-kernel@vger.kernel.org, gtmkramer@xs4all.nl
List-Id: alsa-devel@alsa-project.org



On 08/29/2016 10:13 AM, Takashi Iwai wrote:
> On Mon, 29 Aug 2016 16:10:03 +0200,
> Akshay Bhat wrote:
>>
>> Hi,
>>
>> On Fri, Aug 12, 2016 at 2:08 PM, Akshay Bhat <akshay.bhat@timesys.com> wrote:
>>> From: Ken Lin <ken.lin@advantech.com.tw>
>>>
>>> Avoid getting sample rate on B850V3 CP2114 as it is unsupported and
>>> causes noisy "current rate is different from the runtime rate" messages
>>> when playback starts.
>>>
>>> Signed-off-by: Ken Lin <ken.lin@advantech.com.tw>
>>> Signed-off-by: Akshay Bhat <akshay.bhat@timesys.com>
>>> ---
>>
>> Any feedback on the patch? If not can it be applied? Thanks.
>
> It's already included in 4.8-rc4.  I thought I replied it, but it
> seems to be forgotten, as this was received during my vacation,
> sorry.
>
>
> Takashi
>

Thank you Takashi. I don't see it as part of 4.8-rc4 yet (unless I am 
looking at the wrong tree).

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/sound/usb/quirks.c?id=refs/tags/v4.8-rc4#n1127
