From: Oleksandr Andrushchenko <andr2000@gmail.com>
Subject: Re: [PATCH 00/11] ALSA: vsnd: Add Xen para-virtualized frontend
 driver
Date: Mon, 7 Aug 2017 14:33:53 +0300
Message-ID: <f2155ad9-013e-f034-4358-f140c6a75e85@gmail.com>
References: <1502091796-14413-1-git-send-email-andr2000@gmail.com>
 <df5a5f1a-67df-9e8b-3b43-fbe77c212eeb@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <df5a5f1a-67df-9e8b-3b43-fbe77c212eeb@sakamocchi.jp>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, alsa-devel@alsa-project.org, xen-devel@lists.xen.org, linux-kernel@vger.kernel.org
Cc: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org

Hi,

On 08/07/2017 02:28 PM, Takashi Sakamoto wrote:
> Hi,
>
> On Aug 7 2017 16:43, Oleksandr Andrushchenko wrote:
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
>> [1] https://xenproject.org/
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
> As a quick glance of your first patch, it's apparently based on your 
> local working branch. 
sorry about that, I based the changes on v4.13-rc3 kernel sources
> I'd like you to post patchset again, which were rebased on current 
> upstream[1], so that code reviewers can do their work.
sure, will do that now
>
> [1] 'for-next' branch in Iwai-san's tree
> https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git/log/?h=for-next 
>
>
>
> Regards
>
> Takashi Sakamoto
