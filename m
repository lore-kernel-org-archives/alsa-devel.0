From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH RESEND1 00/12] ALSA: vsnd: Add Xen para-virtualized
 frontend driver
Date: Thu, 24 Aug 2017 13:38:24 +0900
Message-ID: <3fde10f8-4727-e37b-8001-ce2356fffb2b@sakamocchi.jp>
References: <1502108577-8099-1-git-send-email-andr2000@gmail.com>
 <7e62a406-7dcd-b5c9-b2de-ea52e1d2afd0@sakamocchi.jp>
 <b9e34f0e-4a9a-9ccf-6165-04cd22a070ac@gmail.com>
 <CACvf2oU4puqSuNj2k5REpmFJdvWcTWY+AaNEJtknLP4XMPdbsg@mail.gmail.com>
 <e5d52c8a-09e0-2823-dcff-e595868c7dee@sakamocchi.jp>
 <2a2fd222-fc54-1709-bfc8-a530efc3f307@gmail.com>
 <ad4f2201-bfab-415d-0120-308989653628@sakamocchi.jp>
 <b129960e-b38f-ea94-3e4a-3cd409f7a707@gmail.com>
 <3f8e535b-8607-6b15-6e17-da755a06cc1e@sakamocchi.jp>
 <CACvf2oUJtxVTuV0qu4z4kV=aSOH5O_8v=UjH_3tr4wCJdXuEjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACvf2oUJtxVTuV0qu4z4kV=aSOH5O_8v=UjH_3tr4wCJdXuEjw@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Oleksandr Grytsov <al1img@gmail.com>
Cc: Oleksandr Andrushchenko <andr2000@gmail.com>, clemens@ladisch.de, alsa-devel@alsa-project.org, xen-devel@lists.xen.org, linux-kernel@vger.kernel.org, tiwai@suse.com, Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
List-Id: alsa-devel@alsa-project.org

On Aug 23 2017 23:51, Oleksandr Grytsov wrote:
> Hi,
> 
> Thank you for detailed explanation.
> 
> We understand that emulated interrupt on the frontend side is completely not
> acceptable and definitely we need to provide some feedback mechanism from
> Dom0 to DomU.
> 
> In our case it is technically impossible to provide precise period interrupt
> (mostly because our backend is a user space application).
> The best we can implement it is provide number of frames (time, bytes etc.)
> consumed by real HW. This info will be outdated due to different delays but
> we can provide precise timestamps when this info was acquired.

Stuffs of ALSA PCM in kernel land is an abstraction layer for actual
hardware for data transmission. The stuffs get affects from a design of
actual hardware. Furthermore, sound subsystems on the other operating
systems such as Microsoft Windows are also designed with a consideration
about actual hardware. When you design any interfaces as an abstraction
for such software layer, it's better to understand actual hardware and
design of low-level software layer somehow.

Actually the 'sndif' has no good abstraction for actual hardware,
therefore an idea to implement frontend driver as an ALSA driver is not
reasonable at all. It's better to implement it as an application in
the other software layer, e.g. sinks/sources of PulseAudio in DomU via
Xenbus. This idea is nearer an original concept of Xen framework, I
guess. But I don't know we can write any applications of Xenbus in user
land of DomU or not.

Anyway, it's not a good idea to have an ALSA driver for the present 
'sndif', in my opinion.


Regards

Takashi Sakamoto
