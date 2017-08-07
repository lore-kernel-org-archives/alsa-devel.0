From: Oleksandr Andrushchenko <andr2000@gmail.com>
Subject: Re: [PATCH RESEND 00/11] ALSA: vsnd: Add Xen para-virtualized
 frontend driver
Date: Mon, 7 Aug 2017 15:18:32 +0300
Message-ID: <813def1d-4052-0f21-418f-811b5294a539@gmail.com>
References: <1502106645-6731-1-git-send-email-andr2000@gmail.com>
 <ccaa1c31-f733-c582-38b9-7e9eca25a0c2@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ccaa1c31-f733-c582-38b9-7e9eca25a0c2@sakamocchi.jp>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, alsa-devel@alsa-project.org, xen-devel@lists.xen.org, linux-kernel@vger.kernel.org
Cc: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org

On 08/07/2017 03:09 PM, Takashi Sakamoto wrote:
> Hi,
>
> On Aug 7 2017 20:50, Oleksandr Andrushchenko wrote:
>> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>>
>> This patch series adds support for Xen [1] para-virtualized
>> sound frontend driver. It implements the protocol from
>> include/xen/interface/io/sndif.h with the following limitations:
>> - mute/unmute is not supported
>> - get/set volume is not supported
>> Volume control is not supported for the reason that most of the
>> use-cases (at the moment) are based on scenarious where
>> unprivileged OS (e.g. Android, AGL etc) use software mixers.
>>
>> Both capture and playback are supported.
>>
>> Thank you,
>> Oleksandr
>>
>> Resending because of rebase onto [2]
>>
>> [1] https://xenproject.org/
>> [2] 
>> https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git/log/?h=for-next
>>
>> Oleksandr Andrushchenko (11):
>>    ALSA: vsnd: Implement driver's probe/remove
>>    ALSA: vsnd: Implement Xen bus state handling
>>    ALSA: vsnd: Read sound driver configuration from Xen store
>>    ALSA: vsnd: Implement Xen event channel handling
>>    ALSA: vsnd: Implement handling of shared buffers
>>    ALSA: vsnd: Introduce ALSA virtual sound driver
>>    ALSA: vsnd: Initialize virtul sound card
>>    ALSA: vsnd: Add timer for period interrupt emulation
>>    ALSA: vsnd: Implement ALSA PCM operations
>>    ALSA: vsnd: Implement communication with backend
>>    ALSA: vsnd: Introduce Kconfig option to enable Xen PV sound
>>
>>   sound/drivers/Kconfig     |   12 +
>>   sound/drivers/Makefile    |    2 +
>>   sound/drivers/xen-front.c | 2029 
>> +++++++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 2043 insertions(+)
>
> This patchset is not proper yet.
>
really sorry for the mess :(
> Your first patch includes code difference under line 26, thus it 
> expects existence of a file 'sound/drivers/xen-front.c' in tree. 
> However, the file is not introduced in any upstream yet; at least, 
> Linus's tree and Iwai-san's tree.
I missed the very first patch in the series, this is why, my bad
>
> You still work on your local branch, not for us.
>
sorry
>
> Regards
>
> Takashi Sakamoto
