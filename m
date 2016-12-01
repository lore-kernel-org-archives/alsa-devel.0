From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [alsa-devel] [PATCH 1/3 v1] ALSA: usb-audio: more tolerant
 packetsize
Date: Thu, 1 Dec 2016 12:50:39 +0100
Message-ID: <c503960d-7a94-c9ef-d98a-72945c2a44a9@ladisch.de>
References: <20161130075923.15205-1-jiada_wang@mentor.com>
 <20161130075923.15205-2-jiada_wang@mentor.com>
 <1cb0aa49-62d5-b2ac-a473-bbce3f491d59@ladisch.de>
 <s5hy40010w5.wl-tiwai@suse.de>
 <76fa143e-7092-0bc9-7d55-6a5605d4704a@ladisch.de>
 <s5heg1r28rp.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5heg1r28rp.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Jiada Wang <jiada_wang@mentor.com>, alsa-devel@alsa-project.org, apape@de.adit-jv.com, linux-kernel@vger.kernel.org, Mark_Craske@mentor.com
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> Clemens Ladisch wrote:
>> Takashi Iwai wrote:
>>> [...]
>>> In the commit mentioned above, we changed the logic to take +25%
>>> frequency as the basis, and it my *reduce* if ep->maxpacksize is lower
>>> than that.
>>>
>>> OTOH, if ep->maxpacksize is sane, we can rely on it rather than the
>>> implicit +25% frequency.  That said, maybe we can check
>>> ep->maxpacksize whether it fits within the expected range, then adapt
>>> it, or take +25% freq as fallback?
>>
>> You are describing how the current code behaves.  The +25% limit _is_
>> what the code takes as the expected range.
>
> Well, the question is what is the "sane" range.  +25% doesn't fit for
> some devices.

The USB audio specification _requires_ that there is as little jitter
as possible.

It's no surprise that some device violates the specification.  But
we don't know what the actual error is; whether we could adjust the
packet size for this particular device only, or increase the limit
for all devices, or use a completely different workaround.

> If maxpacksize fits without +100% as this patch suggests, can we rely
> on it instead?

The packet size affect the following computations, like the number of
packets per URB.  I don't know how bad the effects would be.


Regards,
Clemens
