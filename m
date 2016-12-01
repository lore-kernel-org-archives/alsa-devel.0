From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [alsa-devel] [PATCH 1/3 v1] ALSA: usb-audio: more tolerant
 packetsize
Date: Thu, 1 Dec 2016 12:16:47 +0100
Message-ID: <76fa143e-7092-0bc9-7d55-6a5605d4704a@ladisch.de>
References: <20161130075923.15205-1-jiada_wang@mentor.com>
 <20161130075923.15205-2-jiada_wang@mentor.com>
 <1cb0aa49-62d5-b2ac-a473-bbce3f491d59@ladisch.de>
 <s5hy40010w5.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hy40010w5.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Jiada Wang <jiada_wang@mentor.com>, alsa-devel@alsa-project.org, apape@de.adit-jv.com, linux-kernel@vger.kernel.org, Mark_Craske@mentor.com
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> Clemens Ladisch wrote:
>> Jiada Wang wrote:
>>> since commit 57e6dae1087bbaa6b33d3dd8a8e90b63888939a3 the expected packetsize is always limited to
>>> nominal + 25%. It was discovered, that some devices
>>
>> Which devices?
>>
>>> have a much higher jitter in used packetsizes than 25%
>>
>> How high?  (Please note that the USB specification restricts the jitter
>> to at most one frame in consecutive packets.)
>>
>>> which would result in BABBLE condition and dropping of packets.
>>> A better solution is so assume the jitter to be the nominal packetsize
>>
>> This solution is better for this one particular device, but how does it
>> affect normal devices, or the Scarlett 2i4 on EHCI affected?
>
> Actually, which value does this affected device in ep->maxpacksize?
> In the commit mentioned above, we changed the logic to take +25%
> frequency as the basis, and it my *reduce* if ep->maxpacksize is lower
> than that.
>
> OTOH, if ep->maxpacksize is sane, we can rely on it rather than the
> implicit +25% frequency.  That said, maybe we can check
> ep->maxpacksize whether it fits within the expected range, then adapt
> it, or take +25% freq as fallback?

You are describing how the current code behaves.  The +25% limit _is_
what the code takes as the expected range.


I'm wondering if that unknown device just declares a wrong interval value.


Regards,
Clemens
