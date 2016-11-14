From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [RFC 02/14] SoundWire: Add SoundWire stream documentation
Date: Mon, 14 Nov 2016 15:31:59 +0000
Message-ID: <20161114153159.GM1575@localhost.localdomain>
References: <1477053673-16021-1-git-send-email-hardik.t.shah@intel.com>
 <1477053673-16021-3-git-send-email-hardik.t.shah@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1477053673-16021-3-git-send-email-hardik.t.shah@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hardik Shah <hardik.t.shah@intel.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, pierre-louis.bossart@linux.intel.com, broonie@kernel.org, lgirdwood@gmail.com, plai@codeaurora.org, patches.audio@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 21, 2016 at 06:11:00PM +0530, Hardik Shah wrote:
> This patch adds stream documentation describing SoundWire stream and
> stream states.
> 
> Signed-off-by: Hardik Shah <hardik.t.shah@intel.com>
> Signed-off-by: Sanyog Kale <sanyog.r.kale@intel.com>
> Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  Documentation/sound/alsa/sdw/stream.txt |  346 +++++++++++++++++++++++++++++++
>  1 file changed, 346 insertions(+)
>  create mode 100644 Documentation/sound/alsa/sdw/stream.txt
> 
> diff --git a/Documentation/sound/alsa/sdw/stream.txt b/Documentation/sound/alsa/sdw/stream.txt
> new file mode 100644
> index 0000000..a1a2ed0
> --- /dev/null
> +++ b/Documentation/sound/alsa/sdw/stream.txt
> @@ -0,0 +1,346 @@
<snip>
> +
> +SoundWire stream states
> +=======================
> +Below figure shows the SoundWire stream states and possible state
> +transition diagram.
> +
> +|--------------|     |-------------|     |--------------|     |--------------|
> +|     ALLOC    |---->|    CONFIG   |---->|   PREPARE    |---->|    ENABLE    |
> +|     STATE    |     |    STATE    |     |    STATE     |     |    STATE     |
> +|--------------|     |-------------|     |--------------|     |--------------|
> +                                                ^                       |
> +                                                |                       |
> +                                                |                       |
> +                                                |                       |
> +                                                |                       \/
> +    |--------------|                     |--------------|     |--------------|
> +    |    RELEASE   |<--------------------|   DEPREPARE  |<----|    DISABLE   |
> +    |     STATE    |                     |    STATE     |     |    STATE     |
> +    |--------------|                     |--------------|     |--------------|
> +

One minor comment, this looks very similar to the clock
frameworks state model, but the clock framework calls it
unprepare would there be some milage in aligning to?

> +
> +SoundWire Stream State Operations
> +==================================
> +Below section explains the operations done by the bus driver on
> +Master(s) and Slave(s) as part of stream state transitions.
> +
> +SDW_STATE_STRM_ALLOC: Allocation state for stream. This is the entry
> +state of the stream. Operations performed before entering in this
> +state:
> +1. An unique stream tag is assigned to stream. This stream tag is used

A unique

> +as a reference for all the operations performed on stream.
> +
> +2. The resources required for holding stream runtime information are
> +allocated and initialized. This holds all stream related information
> +such as stream type (PCM/PDM) and parameters, Master and Slave interface
> +associated with the stream, reference counting, stream state etc.
> +
> +After all above operations are successful, stream state is set to
> +SDW_STATE_STRM_ALLOC.
> +
> +
> +SDW_STATE_STRM_CONFIG: Configuration state of stream. Operations
> +performed before entering in this state:
> +1. The resources allocated for stream information in
> +SDW_STATE_STRM_ALLOC state are updated. This includes stream parameters,
> +Masters and Slaves runtime information associated with the stream.
> +
> +2. All the Masters and Slaves associated with the stream updates the
> +port configuration to bus driver. This includes port numbers allocated
> +by Master(s) and Slave(s) for this stream.
> +
> +After all above operations are successful, stream state is set to
> +SDW_STATE_STRM_CONFIG.
> +
> +
> +SDW_STATE_STRM_PREPARE: Prepare state of stream. Operations performed
> +before entering in this state:
> +1. Bus parameters such as bandwidth, frame shape, clock frequency, SSP
> +interval are computed based on current stream as well as already active
> +streams on bus. Re-computation is required to accommodate current stream
> +on the bus.
> +
> +2. Transport parameters of all Master and Slave ports are computed for
> +the current as well as already active stream based on above calculated
> +frame shape and clock frequency.
> +
> +3. Computed bus and transport parameters are programmed in Master and
> +Slave registers. The banked registers programming is done on the
> +alternate bank (bank currently unused). Port channels are enabled for
> +the already active streams on the alternate bank (bank currently
> +unused). This is done in order to not to disrupt already active
> +stream(s).
> +
> +4. Once all the new values are programmed, bus initiates switch to
> +alternate  bank. Once switch is successful, the port channels enabled on
> +previous bank for already active streams are disabled.
> +
> +5. Ports of Master and Slave for current stream are prepared.
> +
> +After all above operations are successful, stream state is set to
> +SDW_STATE_STRM_PREPARE.
> +
> +
> +SDW_STATE_STRM_ENABLE: Enable state of stream. Operations performed
> +before entering in this state:
> +1. All the values computed in SDW_STATE_STRM_PREPARE state are
> +programmed in alternate bank (bank currently unused). It includes
> +programming of already active streams as well.
> +
> +2. All the Master and Slave port channels for the current stream are
> +enabled on alternate bank (bank currently unused).
> +

This could probably use a little more explaination to show how it
differs from step 3/4 in PREPARE, as it looks like all the
computed values where applied there. I imagine this is just my lack
of understanding rather than an actual issue but even looking at
the code I am having a little difficulty tying up these two.

sdw_prepare_op
- sdw_compute_params (prepare step 1/2)
- sdw_program_params (prepare step 3)
- sdw_update_bus_params (prepare step 4)

sdw_enable_op
- sdw_program_params (enable step 1)
- sdw_update_bus_params (enable step 2)

It looks like the params are still basically the same as they
were when we called sdw_program_params in prepare.

> +3. Once all the new values are programmed, bus initiates switch to
> +alternate bank. Once the switch is successful, the port channels enabled
> +on previous bank for already active streams are disabled.
> +
> +After all above operations are successful, stream state is set to
> +SDW_STATE_STRM_ENABLE.
> +
> +

Thanks,
Charles
