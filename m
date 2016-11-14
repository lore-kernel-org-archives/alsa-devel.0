From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [RFC 02/14] SoundWire: Add SoundWire stream documentation
Date: Mon, 14 Nov 2016 17:04:44 +0000
Message-ID: <20161114170444.GP1575@localhost.localdomain>
References: <1477053673-16021-1-git-send-email-hardik.t.shah@intel.com>
 <1477053673-16021-3-git-send-email-hardik.t.shah@intel.com>
 <20161114153159.GM1575@localhost.localdomain>
 <b0d67cc6-f7fb-ea61-29b3-02a7f7c0aac3@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <b0d67cc6-f7fb-ea61-29b3-02a7f7c0aac3@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Hardik Shah <hardik.t.shah@intel.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, lgirdwood@gmail.com, plai@codeaurora.org, patches.audio@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 14, 2016 at 10:50:10AM -0600, Pierre-Louis Bossart wrote:
> 
> >>+SoundWire stream states
> >>+=======================
> >>+Below figure shows the SoundWire stream states and possible state
> >>+transition diagram.
> >>+
> >>+|--------------|     |-------------|     |--------------|     |--------------|
> >>+|     ALLOC    |---->|    CONFIG   |---->|   PREPARE    |---->|    ENABLE    |
> >>+|     STATE    |     |    STATE    |     |    STATE     |     |    STATE     |
> >>+|--------------|     |-------------|     |--------------|     |--------------|
> >>+                                                ^                       |
> >>+                                                |                       |
> >>+                                                |                       |
> >>+                                                |                       |
> >>+                                                |                       \/
> >>+    |--------------|                     |--------------|     |--------------|
> >>+    |    RELEASE   |<--------------------|   DEPREPARE  |<----|    DISABLE   |
> >>+    |     STATE    |                     |    STATE     |     |    STATE     |
> >>+    |--------------|                     |--------------|     |--------------|
> >>+
> >
> >One minor comment, this looks very similar to the clock
> >frameworks state model, but the clock framework calls it
> >unprepare would there be some milage in aligning to?
> 
> The SoundWire spec uses de-prepare, e.g. "De-prepare_Finished"
> I'd rather stick to the wording between a spec and the implementation of
> said spec, rather than introduce a term/concept from an unrelated framework.
> >

Cool we should leave that as is then :-)

> >>+4. Once all the new values are programmed, bus initiates switch to
> >>+alternate  bank. Once switch is successful, the port channels enabled on
> >>+previous bank for already active streams are disabled.
> 
> This last sentence makes no sense in this context, probably a copy/paste
> that shouldn't be there. The previously active streams remain active in this
> prepare step.
> 
> >>+
> >>+5. Ports of Master and Slave for current stream are prepared.
> >>+
> >>+After all above operations are successful, stream state is set to
> >>+SDW_STATE_STRM_PREPARE.
> >>+
> >>+
> >>+SDW_STATE_STRM_ENABLE: Enable state of stream. Operations performed
> >>+before entering in this state:
> >>+1. All the values computed in SDW_STATE_STRM_PREPARE state are
> >>+programmed in alternate bank (bank currently unused). It includes
> >>+programming of already active streams as well.
> >>+
> >>+2. All the Master and Slave port channels for the current stream are
> >>+enabled on alternate bank (bank currently unused).
> >>+
> >
> >This could probably use a little more explaination to show how it
> >differs from step 3/4 in PREPARE, as it looks like all the
> >computed values where applied there. I imagine this is just my lack
> >of understanding rather than an actual issue but even looking at
> >the code I am having a little difficulty tying up these two.
> 
> Yes, see above there was an extra sentence that isn't right.
> 
> >
> >sdw_prepare_op
> >- sdw_compute_params (prepare step 1/2)
> >- sdw_program_params (prepare step 3)
> >- sdw_update_bus_params (prepare step 4)
> >
> >sdw_enable_op
> >- sdw_program_params (enable step 1)
> >- sdw_update_bus_params (enable step 2)
> >
> >It looks like the params are still basically the same as they
> >were when we called sdw_program_params in prepare.
> 
> The parameters are the same except for the channel-enable flags which are
> only programmed and activated via a bank switch in the enable step.

Ah ok that is what is getting pushed out there, thanks for
explaining.

Thanks,
Charles
