From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [RFC] ALSA: vsnd: Add Xen para-virtualized frontend driver
Date: Thu, 2 Nov 2017 18:44:05 +0900
Message-ID: <b229c2d1-7628-d6dd-73f1-94a4a4106f52@sakamocchi.jp>
References: <1502108577-8099-1-git-send-email-andr2000@gmail.com>
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
 <77dc886e-f3e6-ecef-ed73-c92e966d02f9@epam.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <77dc886e-f3e6-ecef-ed73-c92e966d02f9@epam.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, xen-devel@lists.xen.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Oleksandr Andrushchenko <andr2000@gmail.com>, Oleksandr Grytsov <al1img@gmail.com>, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On Oct 30 2017 15:33, Oleksandr Andrushchenko wrote:
> This is an attempt to summarize previous discussions on Xen para-virtual
> sound driver.
> 
> A first attempt has been made to upstream the driver [1] which brought 
> number
> of fundamental questions, one of the biggest ones was that the frontend 
> driver
> has no means to synchronize its period elapsed event with the host driver,
> but uses software emulation on the guest side [2] with a timer.
> In order to address this a change to the existing Xen para-virtual sound
> protocol [3] was proposed to fill this gap [4] and remove emulation:
> 1. Introduced a new event channel from back to front
> 2. New event with number of bytes played/captured (XENSND_EVT_CUR_POS,
> to be used for sending snd_pcm_period_elapsed at frontend
> (in Linux implementation, sent in bytes, not frames to make the protocol
> generic and consistent)
> 3. New request for playback/capture control (XENSND_OP_TRIGGER) with
> start/pause/stop/resume sub-ops.
> 
> Along with these changes other comments on the driver were addressed,
> e.g. split into smaller chunks, moved the driver from misc to xen etc. [5].
> 
> Hope, this helps to get the full picture of what was discussed and makes it
> possible to move forward: if the approach seems ok, then I'll start
> upstreaming the changes to the sndif protocol and then will send the 
> updated
> version of the driver for the further review.

This message has below line in its header.

 > In-Reply-To: <e56a09e9-da66-b748-4e82-4b96a18cef32@gmail.com>

This field is defined in RFC822[1], and recent mail clients use this 
header field to associate the message to a message which the field 
indicates. This results in a series of messages, so-called 'message 
thread'. Iwai-san would like you to start a new message thread for your 
topic. Would you please post this message again without the header field?

Generally, receiving no reactions means that readers/reviewers don't get 
enough information for your idea yet. (Of course, there's a probability 
that your work attracts no one...) In this case, submitting more 
resources is better, rather than requesting comments to them. For 
instance, you can point links to backend/frontend implementation as 
para-virtualization drivers which use the new feature of interface, if 
you did work for it. Indicating procedure to use a series of your work 
is better for test, if possible.

[1] https://www.ietf.org/rfc/rfc0822.txt

Regards

Takashi Sakamoto
