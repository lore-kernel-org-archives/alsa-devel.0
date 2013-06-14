From: Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: Re: [PATCH 3/4] drm/i915: Add display audio routing
	APIs for ALSA
Date: Fri, 14 Jun 2013 21:18:25 +0200
Message-ID: <CAKMK7uE5PCNEqB8EtYjAZF-MVHCXpPzJ8CsXjOfLR=LA7q7Pig@mail.gmail.com>
References: <1371223229-8236-1-git-send-email-xingchao.wang@linux.intel.com>
	<1371223229-8236-4-git-send-email-xingchao.wang@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <1371223229-8236-4-git-send-email-xingchao.wang@linux.intel.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
Errors-To: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
To: Wang Xingchao <xingchao.wang@linux.intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, intel-gfx <intel-gfx@lists.freedesktop.org>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 14, 2013 at 5:20 PM, Wang Xingchao
<xingchao.wang@linux.intel.com> wrote:
> ALSA audio driver need know current audio routing infomation.
> i.e. Route map between codec pins(DDI ports) and Transcoders(Pipe).
>
> Also the new API let audio driver disable unused audio pin's output.
> This fixed the bug when three pins *ALL* have monitors connected, playing
> audio on one pin would cause audio output to all minitors.
>
> Signed-off-by: Wang Xingchao <xingchao.wang@linux.intel.com>


So I've started to have a real look at audio on haswell and audio on
i915 in general, and I'm seriously confused. Random observations, but
I fear this isn't the real story by far yet:

- On haswell we now have a hooping 3 places that set up these audio
routing register: haswell_write_eld (called from the connector enable
callbacks), intel_enable/disable_ddi and now the new hooks you're
adding here. That's 2 places too many. If we really need all three
places those need to be refactored so that the bit-frobbing logic is
all in one place. But I seriously doubt that we need them all.

- I've quickly read through the haswell audio modeset sequence. On a
glance I could see no reason why we need to have 3 different places to
set up the gfx side of the audio support, since it's much simpler
apparently:

Enable sequence: 1. gfx side sets up registers 2. gfx side sets the
audio enable bit, which generates the interrup 3. audio side completes
the setup on its side.

Disable sequence is just the inverse. So I don't think we need 3
different places for this.

- Both on ibx/cpt and also on haswell here we seem to rely on BIOS
preset values way too often. Or at least I didn't figure out where
these registes get initialized (pretty sure nowhere in i915.ko). We
have countless bugs where the BIOS tried to be fancy and set up
something we don't actually support. So please, if there's no really
good reason why we need to do things differently, have explicit
register setups. If there's something we need to preserve from the
BIOS, it needs to be done explicitly and must have a comment.

- No global state or stuffing random things into dev_priv/crtc any
more. Our modeset infrastructure has a transactional state machine
now: First we compute state parameters in the various compute_config
functions and store all that into a struct intel_crtc_config
pipe_config. Then the modeset functions apply that state. Finally at
the end the hw state is cross-checked with the sw state. We need this
to properly support atomic modeset and fastboot. Yes, this means that
recent additions for haswell audio support like crtc->eld_vld need to
go away and be moved into pipe_config.

- Changing the OUTPUT_ENABLE bits will result in interrupts on the
audio side. But these functions here are only called from the audio
side, so we have a really complicated feedback loop. Given that your
patches need much better explanation of what's going on (preferably
with time/state diagrams). Also I think I need a more detailed
explanation of what exactly is broken currently on Haswell audio and
how these patches fix this.

Cheers, Daniel
--
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
