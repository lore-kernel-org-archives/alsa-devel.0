From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: HDA HDMI pin to converter mapping
Date: Thu, 26 May 2011 14:17:28 +0200
Message-ID: <4DDE44D8.5020604@canonical.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF0498A484DD@HQMAIL01.nvidia.com>	<s5h39k22bmu.wl%tiwai@suse.de>
	<4DDE22DA.7070905@canonical.com> <s5hipsxloxd.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 1B26910381D
	for <alsa-devel@alsa-project.org>;
	Thu, 26 May 2011 14:17:30 +0200 (CEST)
In-Reply-To: <s5hipsxloxd.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Stephen Warren <swarren@nvidia.com>, Wei Ni <wni@nvidia.com>, "pl bossart (bossart.nospam@gmail.com)" <bossart.nospam@gmail.com>, "Wu Fengguang (wfg@linux.intel.com)" <wfg@linux.intel.com>, Nitin Daga <ndaga@nvidia.com>
List-Id: alsa-devel@alsa-project.org

On 2011-05-26 12:46, Takashi Iwai wrote:
> At Thu, 26 May 2011 11:52:26 +0200,
> David Henningsson wrote:
>>
>> On 2011-05-26 08:56, Takashi Iwai wrote:
>>> At Wed, 25 May 2011 11:29:35 -0700,
>>> Stephen Warren wrote:
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
>>>> ELD data (with the possible exception of DisplayPort 1.2 daisy-chaining;
>>>> I have no idea yet how that plays into this).
>>>>
>>>> Does this seem like a reasonable approach to everyone?
>>>
>>> Sounds reasonable and logical to me.
>>> It won't break the older chips, and it will work with new chips.
>>
>> It makes PulseAudio's life harder, if that is to take into account; in
>> the startup phase, PulseAudio usually only tries one of the pcm streams
>> (which is bad here, it'll effectively rule out all ports but the first),
>> if we change to all of the pcm streams, the latter two will fail since
>> the former ones are already opened.
>
> The problem (of missing HDMI outputs) is already seen in the recent
> Intel and Nvidia HDMI codecs.  They already provide multiple streams,
> and snd-hda-intel also provides multiple streams, too.
> So, we need a certain fix anyway.
>
>> So we're effectively breaking some of the older chips by changing the
>> PCM device from hw:X to hw:X,1 for a specific pin...?
>>
>> OTOH, the bigger change here is what's inevitable; that PulseAudio at
>> some point must start to take into account that the current capabilities
>> of a PCM can change during its lifetime. (And that goes regardless of
>> whether have one pcm per pin or converter.) And so the upcoming question
>> is, can PulseAudio detect that the PCM capabilities have changed
>> somehow, and then reprobe it?
>
> The pin configuration won't change at runtime (unless
> reconfiguration), so the configuration is static even if we bind the
> HDMI PCM stream to a pin.

But capabilities will still change, e g if one plugs in a receiver that 
can do 8 channels, then unplug it and then plug in something that can 
only do 2 channels. That still changes the hw_params of the PCM, which 
is what PA tries to detect at startup, and never reprobes.

> (I don't mean against PA changes for dynamic configuration, of course)
>
> But maybe a question is when multiple streams are present but there
> are less converters than pins.  In that case, you can't open all
> streams simultaneously, but the driver won't expose that
> information.
>
> The conflict between PCM streams is always a headache.  A sane way to
> expose the conflicts and relations is required...

Yeah, and it seems like every change we could do would break something, 
somewhere...

I think maybe one problem could be that ALSA lacks the concept of a pin. 
Some object that you could connect jacks to (the /dev/input/event 
stuff), connect ELD data to, and one or more converters to.

>>>> The current situation is that we only create a PCM for each converter
>>>> that is mux'd to a pin by default HW initialization. On both the GeForce
>>>> 520 and Ibex Peak, this means that only 1 PCM gets created, since all
>>>> pin widgets' muxes point at the first converter by default. This:
>>>>
>>>> a) Doesn't allow usage of both converters at once, since there's only 1
>>>> PCM object.
>>
>> So, create a second PCM object for the second converter...?
>
> Well, it's another option -- i.e. creating PCM streams per converter,
> and provide also mux control if multiple sinks can be selected.
> This avoids the problem of less-converters-than-pins, but introduces
> another conflict / race, i.e. assigning a pin from multiple
> converters.

It is also the current way of doing things on the analogue side - should 
we have one-pcm-per-pin, would you see that happening on the analogue 
side as well, e g one pcm for headphone and another for speakers?

HDMI is different in the way that it changes the capabilities on the PCM 
device, so I'm not saying we should, just wondering.

Something to also keep in mind is that AFAICT it is perfectly possible 
to make a codec which has both HDMI outs and analogue outs. I don't 
think anyone has done such a codec yet, but it wouldn't surprise me if 
that would happen.

>>>> b) Ends up with up to 4 (in NVIDIA's case) pin widgets (and hence ELD
>>>> information) logically associated with the PCM object. Hence, it'll be
>>>> confusing for application to know what features they can really use on
>>>> the PCM. In fact, ALSA actually only enforces the ELD of the first pin
>>>> associated with the converter, and ignores the rest.
>>
>> Looks like they should be combined; restricted to whatever formats they
>> both support in case both have valid ELD's?
>>
>>>> The basic mechanics of a-PCM-per-pin would require hdmi_pcm_open to look
>>>> at the list of converters, find one not in use by a stream, and then
>>>> dynamically associate the converter with the stream, or fail the open if
>>>> a converter was not available. We'd also need a custom close or cleanup
>>>> function to "unassign" the converter from the PCM, and set
>>>> hda_pcm_stream.nid to an invalid value.
>>
>> Would it be more difficult for hdmi_pcm_open to open the associated
>> converter and dynamically assign a pin?
>>
>> That said, I think it's great that you brought it up Stephen, and I
>> understand this doesn't help you associate PCMs with X screens - and I'm
>> not sure I have a better proposal for you (and I don't want to block
>> development either), just wanted to add my view to the discussion.
>
>
> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>


-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
