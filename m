From: Oleksandr Andrushchenko <andr2000@gmail.com>
Subject: Re: [alsa-devel] [PATCH v3 0/6] ALSA: xen-front: Add Xen
 para-virtualized frontend driver
Date: Mon, 14 May 2018 19:08:56 +0300
Message-ID: <096bee8c-69ad-b1ca-5eb6-370203d73c16@gmail.com>
References: <20180514062742.25879-1-andr2000@gmail.com>
 <s5hmux2s08m.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hmux2s08m.wl-tiwai@suse.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "Oleksandr_Andrushchenko@epam.com" <Oleksandr_Andrushchenko@epam.com>, xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, jgross@suse.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com, perex@perex.cz
List-Id: alsa-devel@alsa-project.org

On 05/14/2018 06:52 PM, Takashi Iwai wrote:
> On Mon, 14 May 2018 08:27:36 +0200,
> Oleksandr Andrushchenko wrote:
>> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>>
>> Please note: this patch series depends on [3].
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
>> Corresponding backend, implemented as a user-space application, can be
>> found at [2].
> Through a quick glance, all look OK for merge (assuming that they
> really work on your systems :)
Well, we have tested this at EPAM on Android/Linux, so this is it for now
>
> Of course, it'd be great if anyone else can review, test and give
> reviewed-by or tested-by tags.
I hope Juergen and Boris can review, at least Juergen had some comments
that I have addressed in v3
>    So I'll keep this floating for a
> couple of days and merge to for-next branch after that.
Oh, this is great news! Thank you
>
> thanks,
>
> Takashi
