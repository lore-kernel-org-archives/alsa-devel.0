From: Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>
Subject: [RFC] ALSA: vsnd: Add Xen para-virtualized frontend driver
Date: Mon, 30 Oct 2017 08:33:46 +0200
Message-ID: <77dc886e-f3e6-ecef-ed73-c92e966d02f9@epam.com>
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
 <8542f293-f2d0-9ba3-7082-967b32fcec17@ladisch.de>
 <CACvf2oUYM5_KWKsv1Q8=fkqzgMHieYQ76GyiwPTh8UsB+K9iFg@mail.gmail.com>
 <d29615e8-0fc2-68b8-d158-90378dc5ebeb@gmail.com>
 <5421f97e-cd7a-dd22-7557-b0fc25899c1b@gmail.com>
 <232329e2-893f-d40a-3543-062098338bc2@gmail.com>
 <e56a09e9-da66-b748-4e82-4b96a18cef32@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <e56a09e9-da66-b748-4e82-4b96a18cef32@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, xen-devel@lists.xen.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Oleksandr Andrushchenko <andr2000@gmail.com>, Oleksandr Grytsov <al1img@gmail.com>, Clemens Ladisch <clemens@ladisch.de>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
List-Id: alsa-devel@alsa-project.org

Hi, all!

This is an attempt to summarize previous discussions on Xen para-virtual
sound driver.

A first attempt has been made to upstream the driver [1] which brought 
number
of fundamental questions, one of the biggest ones was that the frontend 
driver
has no means to synchronize its period elapsed event with the host driver,
but uses software emulation on the guest side [2] with a timer.
In order to address this a change to the existing Xen para-virtual sound
protocol [3] was proposed to fill this gap [4] and remove emulation:
1. Introduced a new event channel from back to front
2. New event with number of bytes played/captured (XENSND_EVT_CUR_POS,
to be used for sending snd_pcm_period_elapsed at frontend
(in Linux implementation, sent in bytes, not frames to make the protocol
generic and consistent)
3. New request for playback/capture control (XENSND_OP_TRIGGER) with
start/pause/stop/resume sub-ops.

Along with these changes other comments on the driver were addressed,
e.g. split into smaller chunks, moved the driver from misc to xen etc. [5].

Hope, this helps to get the full picture of what was discussed and makes it
possible to move forward: if the approach seems ok, then I'll start
upstreaming the changes to the sndif protocol and then will send the 
updated
version of the driver for the further review.

Thank you,
Oleksandr


[1] https://lkml.org/lkml/2017/8/7/363
[2] https://lkml.org/lkml/2017/8/9/1167
[3] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/xen/interface/io/sndif.h
[4] https://lkml.org/lkml/2017/9/19/121
[5] https://github.com/andr2000/linux/tree/snd_upstream_v1/sound/xen
