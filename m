From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: HDA HDMI pin to converter mapping
Date: Fri, 27 May 2011 10:45:26 +0200
Message-ID: <4DDF64A6.2060403@canonical.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF0498A484DD@HQMAIL01.nvidia.com>
	<s5h39k22bmu.wl%tiwai@suse.de> <4DDE22DA.7070905@canonical.com>
	<74CDBE0F657A3D45AFBB94109FB122FF0498A486FC@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 4B02A24388
	for <alsa-devel@alsa-project.org>;
	Fri, 27 May 2011 10:45:31 +0200 (CEST)
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF0498A486FC@HQMAIL01.nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@nvidia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Wei Ni <wni@nvidia.com>, "pl bossart (bossart.nospam@gmail.com)" <bossart.nospam@gmail.com>, "Wu Fengguang (wfg@linux.intel.com)" <wfg@linux.intel.com>, Nitin Daga <ndaga@nvidia.com>
List-Id: alsa-devel@alsa-project.org

On 2011-05-26 19:45, Stephen Warren wrote:
> David Henningsson wrote at Thursday, May 26, 2011 3:52 AM:
>> On 2011-05-26 08:56, Takashi Iwai wrote:
>>> At Wed, 25 May 2011 11:29:35 -0700, Stephen Warren wrote:
>>>>
>>>> Most cards supported by patch_hdmi.c have the property of a 1:1 mapping
>>>> or connection between converter widgets and pin widgets. Hence,
>>>> patch_hdmi.c sets up a PCM for each converter, and occasionally performs
>>>> some operations on the pin widget as required.
>>>>
>>>> However, some new cards don't have this 1:1 mapping. In particular, the
>>>> new GeForce GT 520 and many future NVIDIA cards, and at least the Intel
>>>> Ibex Peak (in my wife's laptop), have more pin widgets than converters,
>>>> and each pin widget has a mux to select which converter to take the
>>>> audio from.
>>>>
>>>> For pretty pictures, see the 4th (and 3rd) diagrams at:
>>>>
>>>> ftp://download.nvidia.com/XFree86/gpu-hdmi-audio-document/gpu-hdmi-audio.html#_examples
>>>
>>> Wow, nice to see such a good document.
>>
>> Indeed!
>>
>>>> I'd like to discuss how best to handle such cards.
>>>>
>>>> I'd expect to see a PCM device created for each pin widget. This would
>>>> create a 1:1 mapping between PCM devices and attached monitors and hence
>>>> ELD data (with the possible exception of DisplayPort 1.2 daisy- chaining;
>>>> I have no idea yet how that plays into this).
>>>>
>>>> Does this seem like a reasonable approach to everyone?
>>>
>>> Sounds reasonable and logical to me.
>>> It won't break the older chips, and it will work with new chips.
>>
>> It makes PulseAudio's life harder, if that is to take into account; in
>
> (I'll use the phrase "unsupported" below to mean the codecs with fewer
> converters than pins. This is slightly false since they are supported
> to some extent, but bear with the simple terminology:-)
>
> Certainly, we should take this into account. But, I don't think it actually
> changes anything for PulseAudio; see my comments below.
>
>> the startup phase, PulseAudio usually only tries one of the pcm streams
>> (which is bad here, it'll effectively rule out all ports but the first),
>> if we change to all of the pcm streams, the latter two will fail since
>> the former ones are already opened.
>
> PulseAudio already needs to deal with this.

I stand corrected; I must have thought wrong somehow.

So from a conceptual view, I don't really like the one-pcm-per-pin idea, 
because it makes HDMI hda and analogue hda more different. (Or are we 
considering one-pcm-per-pin for the other codecs as well?) We risc 
fragmenting the driver further, where we should instead try to unify it.

But from a pragmatic view, for this particular problem, it seems your 
solution might be the simplest way forward.

> The supported NVIDIA HDA controllers have 4 codecs, each having 1
> converter and 1 pin. Hence, there are 4 PCMs, 1 per codec. PCMs can't
> be unified/shared/... across codecs. However, our HDA controllers only
> support 2 streams, because our GPUs only support two active displays
> at once. Hence, any attempt to open all 4 PCMs at the same time
> (rather than in serial) will fail on the 3rd PCM.
>
> So, the one-PCM-per-pin model for the new unsupported codecs doesn't
> introduce any new issue here.
>
>> So we're effectively breaking some of the older chips by changing the
>> PCM device from hw:X to hw:X,1 for a specific pin...?
>
> I don't believe the PCM device names would change for existing supported
> codecs.

If you have one converter and three pins connected to it (I think some 
intels have this?), then addressing the second and third pin would be a 
change.

> For the unsupported codecs, yes, we'll start to see ${pin_index} be
> non-zero, and end up with names like hw:0,3.0, hw:0,3.1, and hw:0,3.2.
> However, even if we made a PCM-per-converter work for those codecs,
> rather than switching to a PCM-per-pin like I proposed, we'd still end
> up with those new names, simply due to the existence of multiple
> converters within the codec.

*If* you want to use the second converter at all, which will only be in 
the relative rare case of you wanting to use two converters in parallel.

> In fact, if there are any codecs that have a 1:1 mapping between
> converters and pins, yet lump everything into a single codec, we already
> have those names. I don't know enough about other vendors' codecs to
> know if this setup existing in practice or not.
>
> So, PulseAudio needs to support hw:x,P.z with z!=0 anyway.

But you're right about this (with your correction about it's hw:x,y in 
both cases), so maybe it doesn't matter...

> Implementing that would probably be just as easy. The difficult part is
> knowing which pin the user wanted to "assign" the converter to. That's the
> part that having an explicit PCM-per-pin solves.

In the pcm-per-converter, one would just take the first one that 
supports audio. For the simplest and thus most common case (only one 
hdmi monitor connected) then pcm-per-converter would be simpler (just 
access the ,0 device, no need to figure out which device to use), for 
the more complex cases, maybe pcm-per-pin is simpler.

> Thanks for taking the time to think the proposal; it's always good to get
> feedback.

Thanks for taking the time to write it. :-)

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
