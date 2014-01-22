From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: Need your advice: Add a new communication inteface
 between HD-Audio and Gfx drivers for hotplug notification/ELD update
Date: Wed, 22 Jan 2014 12:48:04 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F82B23315E@SHSMSX101.ccr.corp.intel.com>
References: <F46914AEC2663F4A9BB62374E5EEF8F82B231778@SHSMSX101.ccr.corp.intel.com>
	<CAKMK7uFYNfVhXsEmikDZCaFGM8k7g7VMcGqGM4U+1bA_9MX1zQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <CAKMK7uFYNfVhXsEmikDZCaFGM8k7g7VMcGqGM4U+1bA_9MX1zQ@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: intel-gfx-bounces@lists.freedesktop.org
Errors-To: intel-gfx-bounces@lists.freedesktop.org
To: Daniel Vetter <daniel@ffwll.ch>, "Takashi Iwai (tiwai@suse.de)" <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Barnes,
	Jesse" <jesse.barnes@intel.com>, "Zanoni,
	Paulo R" <paulo.r.zanoni@intel.com>, dri-devel <dri-devel@lists.freedesktop.org>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: daniel.vetter@ffwll.ch [mailto:daniel.vetter@ffwll.ch] On Behalf Of
> Daniel Vetter
> Sent: Tuesday, January 21, 2014 9:11 PM
> To: Lin, Mengdong
> Cc: Takashi Iwai (tiwai@suse.de); Barnes, Jesse; Zanoni, Paulo R;
> alsa-devel@alsa-project.org; intel-gfx@lists.freedesktop.org
> Subject: Re: Need your advice: Add a new communication inteface
> between HD-Audio and Gfx drivers for hotplug notification/ELD update
> 
> On Tue, Jan 21, 2014 at 1:35 PM, Lin, Mengdong <mengdong.lin@intel.com>
> wrote:
> > Dear audio and gfx stakeholders,
> >
> >
> >
> > We hope to add a new interface between audio and gfx driver, for gfx
> > driver to notify audio about HDMI/DP hot-plug and ELD update.
> >
> > Would you please share some comments on the proposal below?
> >
> >
> >
> > Background of this issue: On Intel Haswell/Broadwell platforms, there
> > is a HW restriction that after the display HD-Audio controller is in
> > D3,
> >
> > it cannot be waken up by HDMI/DP hot-plug. Consequently, although the
> > gfx driver can still detect the HDMI/DP hot-plug,
> >
> > audio driver has no idea about this and cannot notify user space
> > whether the external HDMI/DP monitor is available for audio playback,
> >
> > because the audio controller cannot wake up to D0 and receive HW
> > unsolicited event about hot-plug from the audio codec.
> >
> > This limitation will affect user space to decide whether we can output
> > audio over HDMI/DP.
> >
> >
> >
> > To solve the above limitation, Takashi suggested to add a new
> > communication interface between audio and gfx driver: create a
> common
> > object
> >
> > containing the ops registered by both graphics and audio drivers, then
> > communicate through it, something like vga_switcheroo.
> >
> >
> >
> > Is it okay to create this kernel object in i915 driver?
> >
> >
> >
> > I915 can export an API like "display_register_audio_client" for audio
> > driver to register a client and hot-plug notification ops.
> >
> >
> >
> > I915 can also call some API like "display_register_gfx_client" itself
> > and register ops for audio driver to query monitor presence and ELD
> > info on a specific port.
> >
> > It would be faster for audio driver than quering ELD by
> > command/response over the HD-A bus, thus avoid delay in i915 mode
> set.
> >
> > This will also avoid waking up the audio devices unnecessarily if the
> > user space does not really want to use HDMI/DP for audio playback.
> >
> >
> >
> > Whenever i195 enables/disables audio on a port in modeset, it can call
> > some API like "display_set_audio_state()" on this kernel object and
> > trigger notifications to the audio driver.
> >
> >
> >
> > When the audio driver is probed (in the delayed probe stage), it can
> > request
> > i915 API symbol to register the audio client for this communication
> > kernel object.
> >
> > Since the 1st i915 mode set may happen before audio driver registers
> > the ops, we'll let audio driver check ELD once after registering the
> > audio client ops.
> >
> > And for the platforms which uses this communication interface, we can
> > disable unsolicited event for HDMI/DP hot-plug in the audio driver.
> >
> >
> >
> > We hope to hear your feedback and start to work out more details.

Thanks for your advice, Daniel!

> Yeah, I've discussed this at KS with Takashi and we've agreed that some
> common object to facilitate driver interactions. A few things
> though:
> - This should be common infrastructure useable by all alsa and drm
> drivers, not just i915 and snd-hda. Especially on embedded platforms this
> issue is fairly rampant ...

Agree. Where to put this common object? 
Is it okay to put it under /driver/gpu/drm, similar to vga_switchroo?
Shall we divide clients into audio and gfx categories, and define different ops for them? Since different info/request flow in different direction between audio and gfx.

> - While at it it should also encompass power management handling of the
> shared hw imo so that we can get rid of the hsw specific hacks for the
> power well code. Or at least we need to rework the power well code to
> reuse this new infrastructure, I don't really want to maintain a few copies
> of the lazy symbol_get logic this kind of stuff requires.

Sounds good.

> - I think the biggest problem is figuring out who should register these
> device nodes. I think it makes the most sense if we do this in the gfx driver,
> but that requires some trickery on the alsa side (probably with using
> -EPROBE_DEFER or something like that.

Can the new infrastructure allow audio driver to query whether gfx driver is ready?
Maybe audio can wait until gfx is ready. For HD-Audio driver, the most time consuming part is delayed after the probe stage, and actually we can wait in the delayed phase.

> - I agree that passing ELD and all the other information through this new
> structure makes lot more sense than the current mess we have with
> passing the ELD through some hardware buffer.

> - Finally I think we should assign some identifier to this link which will get
> exposed both on the drm side and in alsa, so that userspace can figure
> out which display connects to which output. With that media player could
> do the Right Thing and automatically place the audio stream on the right
> pin in alsa.

Is there something that blocks media player from doing the right thing now?
For HD-Audio, the eld entries under /proc/asound/cardx expose the ELD info and can help user space to check if a monitor is usable on a pin. Current limitation is these eld entries cannot update if the audio controller is in D3, so we need the new infrastructure to notify audio driver to update them. But I'm not sure about embedded audio, maybe Takashi would like to share more info.

> Adding dri-devel since that's where we imo need to have this discussion.
> 
> Cheers, Daniel

Thanks
Mengdong
