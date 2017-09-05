From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [alsa-devel] [PATCH RESEND1 00/12] ALSA: vsnd: Add Xen
 para-virtualized frontend driver
Date: Tue, 5 Sep 2017 09:24:04 +0200
Message-ID: <8542f293-f2d0-9ba3-7082-967b32fcec17@ladisch.de>
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
 <3fde10f8-4727-e37b-8001-ce2356fffb2b@sakamocchi.jp>
 <162b7251-4040-c61f-1fcd-c32f65bd3c67@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <162b7251-4040-c61f-1fcd-c32f65bd3c67@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Oleksandr Andrushchenko <andr2000@gmail.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Oleksandr Grytsov <al1img@gmail.com>
Cc: alsa-devel@alsa-project.org, Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>, tiwai@suse.com, linux-kernel@vger.kernel.org, xen-devel@lists.xen.org
List-Id: alsa-devel@alsa-project.org

Oleksandr Andrushchenko wrote:
>>> We understand that emulated interrupt on the frontend side is completely not
>>> acceptable

Allow me to expand on that:  Proper synchronization requires that the
exact position is communicated, not estimated.  Just because the nominal
rate of the stream is known does not imply that you know the actual rate.
Forget for the moment that there even is a nominal rate; assume that it
works like, e.g., a storage controller, and that you can know that a DMA
buffer was consumed by the device only after it has told you.

It's possible and likely that there is a latency when reporting the
stream position, but that is still better than guessing what the DMA
is doing.  (You would never just try to guess when writing data to
disk, would you?)

>>> and definitely we need to provide some feedback mechanism from
>>> Dom0 to DomU.
>>>
>>> In our case it is technically impossible to provide precise period interrupt
>>> (mostly because our backend is a user space application).

As far as I can see, all audio APIs (ALSA, PulseAudio, etc.) have poll()
or callbacks or similar mechanisms to inform you when new data can be
written, and always allow to query the current position.

> [...]
> ok, so the main concern here is that we cannot properly synchronize Dom0-DomU.
> If we put this apart for a second are there any other concerns on having ALSA
> frontend driver? If not, can we have the driver with timer implementation upstreamed
> as experimental until we have some acceptable synchronization solution?
> This will allow broader audience to try and feel the solution and probably contribute?

I doubt that the driver architecture will stay completely the same, so I
do not think that this experimental driver would demonstrate how the
solution would feel.

As the first step, I would suggest creating a driver with proper
synchronization, even if it has high latency.  Reducing the latency
would then be 'just' an optimization.


Regards,
Clemens
