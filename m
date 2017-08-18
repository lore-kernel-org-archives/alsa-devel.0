From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH RESEND1 00/12] ALSA: vsnd: Add Xen para-virtualized
 frontend driver
Date: Fri, 18 Aug 2017 16:17:17 +0900
Message-ID: <ad4f2201-bfab-415d-0120-308989653628@sakamocchi.jp>
References: <1502108577-8099-1-git-send-email-andr2000@gmail.com>
 <7e62a406-7dcd-b5c9-b2de-ea52e1d2afd0@sakamocchi.jp>
 <b9e34f0e-4a9a-9ccf-6165-04cd22a070ac@gmail.com>
 <CACvf2oU4puqSuNj2k5REpmFJdvWcTWY+AaNEJtknLP4XMPdbsg@mail.gmail.com>
 <e5d52c8a-09e0-2823-dcff-e595868c7dee@sakamocchi.jp>
 <2a2fd222-fc54-1709-bfc8-a530efc3f307@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2a2fd222-fc54-1709-bfc8-a530efc3f307@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Oleksandr Andrushchenko <andr2000@gmail.com>, Oleksandr Grytsov <al1img@gmail.com>, clemens@ladisch.de
Cc: alsa-devel@alsa-project.org, xen-devel@lists.xen.org, linux-kernel@vger.kernel.org, tiwai@suse.com, Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
List-Id: alsa-devel@alsa-project.org

On Aug 18 2017 14:56, Oleksandr Andrushchenko wrote:
> Taking into account the fact that the backend we have is a user-space 
> application
> running on top of ALSA/PulseAudio we cannot get HW pointers from actual
> hardware by any means (PulseAudio use-case is the most tough thing in 
> equation)

You mean that any alsa-lib or libpulse applications run on Dom0 as a
backend driver for the frontend driver on DomU?


Regards

Takashi Sakamoto
