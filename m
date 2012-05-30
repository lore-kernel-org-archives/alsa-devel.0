From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: Internal Mics and Speakers not visible in
	PulseAudio
Date: Wed, 30 May 2012 16:45:46 +0200
Message-ID: <4FC6329A.1040008@canonical.com>
References: <4FC616B8.3090608@canonical.com>
	<CAN8cciYgk5L5PWQkzcd3XF_7eZvzTpzC_eUifCG=hOFymJsx7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112])
	by alsa0.perex.cz (Postfix) with ESMTP id 0DDEA104348
	for <alsa-devel@alsa-project.org>;
	Wed, 30 May 2012 16:45:45 +0200 (CEST)
In-Reply-To: <CAN8cciYgk5L5PWQkzcd3XF_7eZvzTpzC_eUifCG=hOFymJsx7Q@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, General PulseAudio Discussion <pulseaudio-discuss@lists.freedesktop.org>
List-Id: alsa-devel@alsa-project.org

On 05/30/2012 03:04 PM, Raymond Yau wrote:
> 2012/5/30 David Henningsson<david.henningsson@canonical.com>:
>> Posted to both alsa-devel and pulseaudio-discuss lists, as this is a cross
>> issue.
>>
>> PulseAudio tries to figure out what equipment is present on the machine
>> using the mixer. If it finds e g "Headphone Playback Volume", "Headphone
>> Playback Switch", or "Headphone Jack", it assumes that a headphone is
>> present and creates a headphone port. If it finds no ports, it creates a
>> fallback "Analog Output" port.
>>
>> Now assume that we have a laptop with speakers and a headphone jack, but
>> with only a "Master Playback Volume", and a "Headphone Jack" for the jack
>> detection.
>> PulseAudio will take the "Headphone Jack", and create a headphone port. Now,
>> if this port is currently unconnected/unavailable, it will not show up at
>> all [1]. As a result, the internal speakers - for which no port was created
>> - will be essentially unusable.
>>
>> Now, I thought this was a problem with a pair of machines only, that we
>> could easily quirk on the PulseAudio side. But after looking through Ubuntu
>> bugs and posting a blog post [2] about the issue, I have now collected 21
>> different machines affected, mostly on the input side. Several Realtek chips
>> are affected on the dmic side, and some older STAC92xx chips have problems
>> in both directions.
>> So it becomes evident to me, that this is something that needs to be fixed
>> pretty fast.
>>
>> So, to move forward, we need to expose these speakers and internal mics to
>> userspace. A very simple (untested) patch is attached. This would make
>> "Internal Mic Jack" and "Speaker Jack" show up. Note that the actual status
>> can be overridden/ignored on the PulseAudio side - the importance here is
>> the sign that there are internal mics and speakers, so that the PulseAudio
>> ports get created.
>>
>> I could develop it a little to make sure we don't actually do any jack
>> detection for these pins but always return them as being true/present.
>> That is, if you approve the idea? I admit that the "Internal Mic Jack" is
>> somewhat misleading/hacky as the internal mic is not connected to any
>> physical jack, but it seems like the simplest way of resolving the problem
>> currently.
>>
>>
>>
> I am afraid this does not work with desktop computer which has front
> mic , internal mic, Line in ,CD (or stereo mix with those via hda
> codecs)
>
> With ubuntu 12.04 and unity ,  if I enable hda jack detect with my
> ad198x on my desktop, sound  preference does not allow me to select
> front mic since I am still using ac97 front panel (with no jack detect
> circuit)

In that case your BIOS should detect that you're using an ac'97 front 
panel and set the "no prescence detect" bit in the default pin config.

The codec driver should then not create any jack at all, and PulseAudio 
would pick up 'Input Source' -> 'Front Mic' as a reason to have create a 
'Front Mic' port.

But maybe there is some sense in wanting to create a different state for 
when it's undetectable (present = yes/no/unknown) in the interface 
between the kernel and userspace?

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
