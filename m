From: Oleksandr Andrushchenko <andr2000@gmail.com>
Subject: Re: [PATCH RESEND1 00/12] ALSA: vsnd: Add Xen para-virtualized
 frontend driver
Date: Fri, 18 Aug 2017 08:56:01 +0300
Message-ID: <2a2fd222-fc54-1709-bfc8-a530efc3f307@gmail.com>
References: <1502108577-8099-1-git-send-email-andr2000@gmail.com>
 <7e62a406-7dcd-b5c9-b2de-ea52e1d2afd0@sakamocchi.jp>
 <b9e34f0e-4a9a-9ccf-6165-04cd22a070ac@gmail.com>
 <CACvf2oU4puqSuNj2k5REpmFJdvWcTWY+AaNEJtknLP4XMPdbsg@mail.gmail.com>
 <e5d52c8a-09e0-2823-dcff-e595868c7dee@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <e5d52c8a-09e0-2823-dcff-e595868c7dee@sakamocchi.jp>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, Oleksandr Grytsov <al1img@gmail.com>, clemens@ladisch.de
Cc: alsa-devel@alsa-project.org, xen-devel@lists.xen.org, linux-kernel@vger.kernel.org, tiwai@suse.com, Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
List-Id: alsa-devel@alsa-project.org

Hello,

On 08/18/2017 08:43 AM, Takashi Sakamoto wrote:
> On Aug 17 2017 19:05, Oleksandr Grytsov wrote:
>> So, from the above we think that period elapsed event derived in the 
>> described
>> ways may not improve latency and will complicate the system. So, for 
>> that
>> reason we are thinking of the option 2) (Positions of actual data 
>> transmission
>> in any serial sound interfaces of actual hardwares.)
>
> Please declare the way to enable stuffs on DomU to get the positions 
> from actual hardware.
>
This is what we haven't investigated yet in detail as we were mostly 
focusing on
period elapsed approach, so we can report our findings to the community.

Taking into account the fact that the backend we have is a user-space 
application
running on top of ALSA/PulseAudio we cannot get HW pointers from actual
hardware by any means (PulseAudio use-case is the most tough thing in 
equation)

At the moment we are seeking for any advise from more experienced developers
in the field on possible ways to solve the problem of Dom0/DomU 
synchronization.
Hope, together we can identify such a way that would be accepted by the 
community.

If you have something on your mind could you please share your thoughts?
>
> Regards
>
> Takashi Sakamoto
Thank you,
Oleksandr Andrushchenko
