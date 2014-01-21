From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: Need your advice: Add a new communication inteface
 between HD-Audio and Gfx drivers for hotplug notification/ELD update
Date: Tue, 21 Jan 2014 14:10:44 +0100
Message-ID: <CAKMK7uFYNfVhXsEmikDZCaFGM8k7g7VMcGqGM4U+1bA_9MX1zQ@mail.gmail.com>
References: <F46914AEC2663F4A9BB62374E5EEF8F82B231778@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <F46914AEC2663F4A9BB62374E5EEF8F82B231778@SHSMSX101.ccr.corp.intel.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: intel-gfx-bounces@lists.freedesktop.org
Errors-To: intel-gfx-bounces@lists.freedesktop.org
To: "Lin, Mengdong" <mengdong.lin@intel.com>
Cc: "Takashi Iwai (tiwai@suse.de)" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Barnes, Jesse" <jesse.barnes@intel.com>, "Zanoni,
	Paulo R" <paulo.r.zanoni@intel.com>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 21, 2014 at 1:35 PM, Lin, Mengdong <mengdong.lin@intel.com> wro=
te:
> Dear audio and gfx stakeholders,
>
>
>
> We hope to add a new interface between audio and gfx driver, for gfx driv=
er
> to notify audio about HDMI/DP hot-plug and ELD update.
>
> Would you please share some comments on the proposal below?
>
>
>
> Background of this issue: On Intel Haswell/Broadwell platforms, there is a
> HW restriction that after the display HD-Audio controller is in D3,
>
> it cannot be waken up by HDMI/DP hot-plug. Consequently, although the gfx
> driver can still detect the HDMI/DP hot-plug,
>
> audio driver has no idea about this and cannot notify user space whether =
the
> external HDMI/DP monitor is available for audio playback,
>
> because the audio controller cannot wake up to D0 and receive HW unsolici=
ted
> event about hot-plug from the audio codec.
>
> This limitation will affect user space to decide whether we can output au=
dio
> over HDMI/DP.
>
>
>
> To solve the above limitation, Takashi suggested to add a new communicati=
on
> interface between audio and gfx driver: create a common object
>
> containing the ops registered by both graphics and audio drivers, then
> communicate through it, something like vga_switcheroo.
>
>
>
> Is it okay to create this kernel object in i915 driver?
>
>
>
> I915 can export an API like =93display_register_audio_client=94 for audio=
 driver
> to register a client and hot-plug notification ops.
>
>
>
> I915 can also call some API like =93display_register_gfx_client=94 itself=
 and
> register ops for audio driver to query monitor presence and ELD info on a
> specific port.
>
> It would be faster for audio driver than quering ELD by command/response
> over the HD-A bus, thus avoid delay in i915 mode set.
>
> This will also avoid waking up the audio devices unnecessarily if the user
> space does not really want to use HDMI/DP for audio playback.
>
>
>
> Whenever i195 enables/disables audio on a port in modeset, it can call so=
me
> API like =93display_set_audio_state()=94 on this kernel object and trigger
> notifications to the audio driver.
>
>
>
> When the audio driver is probed (in the delayed probe stage), it can requ=
est
> i915 API symbol to register the audio client for this communication kernel
> object.
>
> Since the 1st i915 mode set may happen before audio driver registers the
> ops, we=92ll let audio driver check ELD once after registering the audio
> client ops.
>
> And for the platforms which uses this communication interface, we can
> disable unsolicited event for HDMI/DP hot-plug in the audio driver.
>
>
>
> We hope to hear your feedback and start to work out more details.

Yeah, I've discussed this at KS with Takashi and we've agreed that
some common object to facilitate driver interactions. A few things
though:
- This should be common infrastructure useable by all alsa and drm
drivers, not just i915 and snd-hda. Especially on embedded platforms
this issue is fairly rampant ...
- While at it it should also encompass power management handling of
the shared hw imo so that we can get rid of the hsw specific hacks for
the power well code. Or at least we need to rework the power well code
to reuse this new infrastructure, I don't really want to maintain a
few copies of the lazy symbol_get logic this kind of stuff requires.
- I think the biggest problem is figuring out who should register
these device nodes. I think it makes the most sense if we do this in
the gfx driver, but that requires some trickery on the alsa side
(probably with using -EPROBE_DEFER or something like that.
- I agree that passing ELD and all the other information through this
new structure makes lot more sense than the current mess we have with
passing the ELD through some hardware buffer.
- Finally I think we should assign some identifier to this link which
will get exposed both on the drm side and in alsa, so that userspace
can figure out which display connects to which output. With that media
player could do the Right Thing and automatically place the audio
stream on the right pin in alsa.

Adding dri-devel since that's where we imo need to have this discussion.

Cheers, Daniel
-- =

Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
