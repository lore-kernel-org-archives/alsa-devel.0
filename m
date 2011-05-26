From: Stephen Warren <swarren@nvidia.com>
Subject: Re: HDA HDMI pin to converter mapping
Date: Thu, 26 May 2011 10:45:01 -0700
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF0498A486FC@HQMAIL01.nvidia.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF0498A484DD@HQMAIL01.nvidia.com>
	<s5h39k22bmu.wl%tiwai@suse.de> <4DDE22DA.7070905@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate04.nvidia.com (hqemgate04.nvidia.com [216.228.121.35])
	by alsa0.perex.cz (Postfix) with ESMTP id EEB8D10384A
	for <alsa-devel@alsa-project.org>;
	Thu, 26 May 2011 19:45:12 +0200 (CEST)
In-Reply-To: <4DDE22DA.7070905@canonical.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>, Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Nitin@alsa-project.org, Wei Ni <wni@nvidia.com>, "pl bossart (bossart.nospam@gmail.com)" <bossart.nospam@gmail.com>, "Wu Fengguang  (wfg@linux.intel.com)" <wfg@linux.intel.com>, Daga <ndaga@nvidia.com>
List-Id: alsa-devel@alsa-project.org

David Henningsson wrote at Thursday, May 26, 2011 3:52 AM:
> On 2011-05-26 08:56, Takashi Iwai wrote:
> > At Wed, 25 May 2011 11:29:35 -0700, Stephen Warren wrote:
> >>
> >> Most cards supported by patch_hdmi.c have the property of a 1:1 mapping
> >> or connection between converter widgets and pin widgets. Hence,
> >> patch_hdmi.c sets up a PCM for each converter, and occasionally performs
> >> some operations on the pin widget as required.
> >>
> >> However, some new cards don't have this 1:1 mapping. In particular, the
> >> new GeForce GT 520 and many future NVIDIA cards, and at least the Intel
> >> Ibex Peak (in my wife's laptop), have more pin widgets than converters,
> >> and each pin widget has a mux to select which converter to take the
> >> audio from.
> >>
> >> For pretty pictures, see the 4th (and 3rd) diagrams at:
> >>
> >> ftp://download.nvidia.com/XFree86/gpu-hdmi-audio-document/gpu-hdmi-audio.html#_examples
> >
> > Wow, nice to see such a good document.
> 
> Indeed!
> 
> >> I'd like to discuss how best to handle such cards.
> >>
> >> I'd expect to see a PCM device created for each pin widget. This would
> >> create a 1:1 mapping between PCM devices and attached monitors and hence
> >> ELD data (with the possible exception of DisplayPort 1.2 daisy- chaining;
> >> I have no idea yet how that plays into this).
> >>
> >> Does this seem like a reasonable approach to everyone?
> >
> > Sounds reasonable and logical to me.
> > It won't break the older chips, and it will work with new chips.
> 
> It makes PulseAudio's life harder, if that is to take into account; in

(I'll use the phrase "unsupported" below to mean the codecs with fewer
converters than pins. This is slightly false since they are supported
to some extent, but bear with the simple terminology:-)

Certainly, we should take this into account. But, I don't think it actually
changes anything for PulseAudio; see my comments below.

> the startup phase, PulseAudio usually only tries one of the pcm streams
> (which is bad here, it'll effectively rule out all ports but the first),
> if we change to all of the pcm streams, the latter two will fail since
> the former ones are already opened.

PulseAudio already needs to deal with this.

The supported NVIDIA HDA controllers have 4 codecs, each having 1
converter and 1 pin. Hence, there are 4 PCMs, 1 per codec. PCMs can't
be unified/shared/... across codecs. However, our HDA controllers only
support 2 streams, because our GPUs only support two active displays
at once. Hence, any attempt to open all 4 PCMs at the same time
(rather than in serial) will fail on the 3rd PCM.

So, the one-PCM-per-pin model for the new unsupported codecs doesn't
introduce any new issue here.

> So we're effectively breaking some of the older chips by changing the
> PCM device from hw:X to hw:X,1 for a specific pin...?

I don't believe the PCM device names would change for existing supported
codecs.

Specifically, the PCM names are:

hw:${card},${codec_index}                    (1 converter)

hw:${card},${codec_index}.${converter_index} (n converters)

Since for existing supported codecs, the number of codecs and
converters doesn't change in HW, the device names won't change.

Yes, we'll change ${converter_index} to ${pin_index} in the above
names, but again, since that's going to be 0 in both cases for
existing codecs, there will be no change.

For the unsupported codecs, yes, we'll start to see ${pin_index} be
non-zero, and end up with names like hw:0,3.0, hw:0,3.1, and hw:0,3.2.
However, even if we made a PCM-per-converter work for those codecs,
rather than switching to a PCM-per-pin like I proposed, we'd still end
up with those new names, simply due to the existence of multiple
converters within the codec.

In fact, if there are any codecs that have a 1:1 mapping between
converters and pins, yet lump everything into a single codec, we already
have those names. I don't know enough about other vendors' codecs to 
know if this setup existing in practice or not.

So, PulseAudio needs to support hw:x,P.z with z!=0 anyway.

> OTOH, the bigger change here is what's inevitable; that PulseAudio at
> some point must start to take into account that the current capabilities
> of a PCM can change during its lifetime. (And that goes regardless of
> whether have one pcm per pin or converter.) And so the upcoming question
> is, can PulseAudio detect that the PCM capabilities have changed
> somehow, and then reprobe it?

Sure, but that happens irrespective.

Right now, the PCM capabilities can change when you plug in a different
monitor at run-time. I think the Jack detection you added, and the
ability to expose the ELD as a binary kcontrol (or similar) that
Pierre-Louis mentioned, should help here.

For the unsupported codecs, I think the PCM-per-pin makes this situation
far more manageable; there will be a single ELD per PCM, rather than
one converter driving N pins, each of which has an ELD, and hence
applications would have to just pick one (which?) or merge the
capabilities, which would be complex and probably a usability nightmare.

> >> The current situation is that we only create a PCM for each converter
> >> that is mux'd to a pin by default HW initialization. On both the GeForce
> >> 520 and Ibex Peak, this means that only 1 PCM gets created, since all
> >> pin widgets' muxes point at the first converter by default. This:
> >>
> >> a) Doesn't allow usage of both converters at once, since there's only 1
> >> PCM object.
> 
> So, create a second PCM object for the second converter...?

I don't think that'd work very well; one converter driving N pins would
run in to the problems in the last paragraph I mentioned above.

If we did do one-PCM-per-converter, we'd probably need to expose the muxes
in the pins as kcontrols and allow user-space to select which PCM routes
to which pin. That would more directly represent the HW capabilities, but
would be more complex for user-space to manage. We'd need to expose the
ELD information for a pin rather than a PCM too, so we'd need some concept
of a pin at the ALSA API level (or a defacto naming standard for the ELD
kcontrols used to retrieve the data).

> >> b) Ends up with up to 4 (in NVIDIA's case) pin widgets (and hence ELD
> >> information) logically associated with the PCM object. Hence, it'll be
> >> confusing for application to know what features they can really use on
> >> the PCM. In fact, ALSA actually only enforces the ELD of the first pin
> >> associated with the converter, and ignores the rest.
> 
> Looks like they should be combined; restricted to whatever formats they
> both support in case both have valid ELD's?
> 
> >> The basic mechanics of a-PCM-per-pin would require hdmi_pcm_open to look
> >> at the list of converters, find one not in use by a stream, and then
> >> dynamically associate the converter with the stream, or fail the open if
> >> a converter was not available. We'd also need a custom close or cleanup
> >> function to "unassign" the converter from the PCM, and set
> >> hda_pcm_stream.nid to an invalid value.
> 
> Would it be more difficult for hdmi_pcm_open to open the associated
> converter and dynamically assign a pin?

Implementing that would probably be just as easy. The difficult part is
knowing which pin the user wanted to "assign" the converter to. That's the
part that having an explicit PCM-per-pin solves.

Thanks for taking the time to think the proposal; it's always good to get
feedback.

--
nvpublic
