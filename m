From: "Wang, Xingchao" <xingchao.wang@intel.com>
Subject: Re: [PATCH 3/4] drm/i915: Add display audio routing
	APIs for ALSA
Date: Mon, 17 Jun 2013 12:52:41 +0000
Message-ID: <46B810F6945F7C4788E11DCE57EC4890118306EA@SHSMSX104.ccr.corp.intel.com>
References: <1371223229-8236-1-git-send-email-xingchao.wang@linux.intel.com>
	<1371223229-8236-4-git-send-email-xingchao.wang@linux.intel.com>
	<CAKMK7uE5PCNEqB8EtYjAZF-MVHCXpPzJ8CsXjOfLR=LA7q7Pig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <CAKMK7uE5PCNEqB8EtYjAZF-MVHCXpPzJ8CsXjOfLR=LA7q7Pig@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
Errors-To: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
To: Daniel Vetter <daniel.vetter@ffwll.ch>, Wang Xingchao <xingchao.wang@linux.intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, intel-gfx <intel-gfx@lists.freedesktop.org>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Hi Daniel,

> -----Original Message-----
> From: Daniel Vetter [mailto:daniel.vetter@ffwll.ch]
> Sent: Saturday, June 15, 2013 3:18 AM
> To: Wang Xingchao
> Cc: Takashi Iwai; alsa-devel@alsa-project.org; intel-gfx; David Henningsson;
> Wang, Xingchao
> Subject: Re: [PATCH 3/4] drm/i915: Add display audio routing APIs for ALSA
> 
> On Fri, Jun 14, 2013 at 5:20 PM, Wang Xingchao
> <xingchao.wang@linux.intel.com> wrote:
> > ALSA audio driver need know current audio routing infomation.
> > i.e. Route map between codec pins(DDI ports) and Transcoders(Pipe).
> >
> > Also the new API let audio driver disable unused audio pin's output.
> > This fixed the bug when three pins *ALL* have monitors connected,
> > playing audio on one pin would cause audio output to all minitors.
> >
> > Signed-off-by: Wang Xingchao <xingchao.wang@linux.intel.com>
> 
> 
> So I've started to have a real look at audio on haswell and audio on
> i915 in general, and I'm seriously confused. Random observations, but I fear
> this isn't the real story by far yet:
> 
> - On haswell we now have a hooping 3 places that set up these audio routing
> register: haswell_write_eld (called from the connector enable callbacks),
> intel_enable/disable_ddi and now the new hooks you're adding here. That's 2
> places too many. If we really need all three places those need to be refactored
> so that the bit-frobbing logic is all in one place. But I seriously doubt that we
> need them all.
> 

Yeah I agree to put audio stuff in One place. Let me give you some background about the issue this
Patch fixed. 
Basically audio side need such API in gfx side to enable/disable audio, that's three PIPE based audio enable bits.
The issue comes when two monitors connected on DDI port B and port C, like:
DDI B(pin 0) --> DP monitor
DDI C(pin 1) --> HDMI minitor

In haswell the pins default choose converter 0(hardware level) as data source, so it's like:

Converter 0 --> pin 0 + pin 1 + pin2

And when play audio on pin 0, pin 1 could get audio data too. Meanwhile pin 1 has HDMi minitor connected, you can hear audio.
To fix this issue, I tried several solutions:
1) Disable pin 1/2 when play audio on pin 0, or disable pin 0/2 when play audio on pin 1
2) mute pin 1/2 when play audio on pin 0, or mute pin 0/2 when play audio on pin 1
3) configure pin 1/2 to choose other converters when play audio on pin 0.
4) disable audio output enable in gfx side, this is implemented in current patchset.

I prefer 1) or 2) it's very simple, but it doesnot work on Haswell. It's the issue I'm trying to fix:
Pin 0 must be output-eanbe/unmute when playing audio on pin 1.
Seems pin 1 has dependency on pin 0, and I have to disable audio output in gfx side.

I don't think it's bad if we implement such API in gfx side, the question is you point out, to make it clean and simple.
If Dp1.2 is needed in future, audio side need the pipe->DDI port connections map too. We can reuse power-well module
to export such information.

To implement solution 4) above, audio side handle request to disable audio output in gfx side:
- if only pin 0 is busy playing audio and using valid pipe, disable audio output for pin 1/2.
 It's the same logic when only pin1 or pin 2 is busy playing audio.
- if both pin0 and pin 1 are busy playing audio, only disable pin 2.
- if all pins are playing audio, do nothing.

In above case when both Pin 0 and pin 1 are connected with Dp and HDMI monitor, if only playing audio on pin 0, disable pin 1's audio output in gfx side
Would cause eld info refresh in audio driver side, but that doesnot matter as when you need playing audio on pin 1, the audio output enable bit would be set again.

The patch could fix the issue when playing audio on one pin, audio would route to another pin too. In such case, we can drop the second patch in fact.
          
> - I've quickly read through the haswell audio modeset sequence. On a glance I
> could see no reason why we need to have 3 different places to set up the gfx
> side of the audio support, since it's much simpler
> apparently:
> 
> Enable sequence: 1. gfx side sets up registers 2. gfx side sets the audio enable
> bit, which generates the interrup 3. audio side completes the setup on its side.
> 
> Disable sequence is just the inverse. So I don't think we need 3 different places
> for this.
> 
> - Both on ibx/cpt and also on haswell here we seem to rely on BIOS preset
> values way too often. Or at least I didn't figure out where these registes get
> initialized (pretty sure nowhere in i915.ko). We have countless bugs where the
> BIOS tried to be fancy and set up something we don't actually support. So
> please, if there's no really good reason why we need to do things differently,
> have explicit register setups. If there's something we need to preserve from
> the BIOS, it needs to be done explicitly and must have a comment.
> 
> - No global state or stuffing random things into dev_priv/crtc any more. Our
> modeset infrastructure has a transactional state machine
> now: First we compute state parameters in the various compute_config
> functions and store all that into a struct intel_crtc_config pipe_config. Then the
> modeset functions apply that state. Finally at the end the hw state is
> cross-checked with the sw state. We need this to properly support atomic
> modeset and fastboot. Yes, this means that recent additions for haswell audio
> support like crtc->eld_vld need to go away and be moved into pipe_config.
> 
> - Changing the OUTPUT_ENABLE bits will result in interrupts on the audio side.
> But these functions here are only called from the audio side, so we have a really
> complicated feedback loop. Given that your patches need much better
> explanation of what's going on (preferably with time/state diagrams). Also I
> think I need a more detailed explanation of what exactly is broken currently on
> Haswell audio and how these patches fix this.

Hope above explanation is helpful for you, if it's not enough, I would draw some graph case by case to let you know. :)

Thanks
--xingchao
> 
> Cheers, Daniel
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> +41 (0) 79 365 57 48 - http://blog.ffwll.ch
