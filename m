From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [RFC 02/14] SoundWire: Add SoundWire stream documentation
Date: Mon, 14 Nov 2016 10:50:10 -0600
Message-ID: <b0d67cc6-f7fb-ea61-29b3-02a7f7c0aac3@linux.intel.com>
References: <1477053673-16021-1-git-send-email-hardik.t.shah@intel.com>
 <1477053673-16021-3-git-send-email-hardik.t.shah@intel.com>
 <20161114153159.GM1575@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161114153159.GM1575@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Hardik Shah <hardik.t.shah@intel.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, lgirdwood@gmail.com, plai@codeaurora.org, patches.audio@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org


>> +SoundWire stream states
>> +=======================
>> +Below figure shows the SoundWire stream states and possible state
>> +transition diagram.
>> +
>> +|--------------|     |-------------|     |--------------|     |--------------|
>> +|     ALLOC    |---->|    CONFIG   |---->|   PREPARE    |---->|    ENABLE    |
>> +|     STATE    |     |    STATE    |     |    STATE     |     |    STATE     |
>> +|--------------|     |-------------|     |--------------|     |--------------|
>> +                                                ^                       |
>> +                                                |                       |
>> +                                                |                       |
>> +                                                |                       |
>> +                                                |                       \/
>> +    |--------------|                     |--------------|     |--------------|
>> +    |    RELEASE   |<--------------------|   DEPREPARE  |<----|    DISABLE   |
>> +    |     STATE    |                     |    STATE     |     |    STATE     |
>> +    |--------------|                     |--------------|     |--------------|
>> +
>
> One minor comment, this looks very similar to the clock
> frameworks state model, but the clock framework calls it
> unprepare would there be some milage in aligning to?

The SoundWire spec uses de-prepare, e.g. "De-prepare_Finished"
I'd rather stick to the wording between a spec and the implementation of 
said spec, rather than introduce a term/concept from an unrelated framework.
>
>> +
>> +SoundWire Stream State Operations
>> +==================================
>> +Below section explains the operations done by the bus driver on
>> +Master(s) and Slave(s) as part of stream state transitions.
>> +
>> +SDW_STATE_STRM_ALLOC: Allocation state for stream. This is the entry
>> +state of the stream. Operations performed before entering in this
>> +state:
>> +1. An unique stream tag is assigned to stream. This stream tag is used
>
> A unique

ok

>
>> +as a reference for all the operations performed on stream.
>> +
>> +2. The resources required for holding stream runtime information are
>> +allocated and initialized. This holds all stream related information
>> +such as stream type (PCM/PDM) and parameters, Master and Slave interface
>> +associated with the stream, reference counting, stream state etc.
>> +
>> +After all above operations are successful, stream state is set to
>> +SDW_STATE_STRM_ALLOC.
>> +
>> +
>> +SDW_STATE_STRM_CONFIG: Configuration state of stream. Operations
>> +performed before entering in this state:
>> +1. The resources allocated for stream information in
>> +SDW_STATE_STRM_ALLOC state are updated. This includes stream parameters,
>> +Masters and Slaves runtime information associated with the stream.
>> +
>> +2. All the Masters and Slaves associated with the stream updates the
>> +port configuration to bus driver. This includes port numbers allocated
>> +by Master(s) and Slave(s) for this stream.
>> +
>> +After all above operations are successful, stream state is set to
>> +SDW_STATE_STRM_CONFIG.
>> +
>> +
>> +SDW_STATE_STRM_PREPARE: Prepare state of stream. Operations performed
>> +before entering in this state:
>> +1. Bus parameters such as bandwidth, frame shape, clock frequency, SSP
>> +interval are computed based on current stream as well as already active
>> +streams on bus. Re-computation is required to accommodate current stream
>> +on the bus.
>> +
>> +2. Transport parameters of all Master and Slave ports are computed for
>> +the current as well as already active stream based on above calculated
>> +frame shape and clock frequency.
>> +
>> +3. Computed bus and transport parameters are programmed in Master and
>> +Slave registers. The banked registers programming is done on the
>> +alternate bank (bank currently unused). Port channels are enabled for
>> +the already active streams on the alternate bank (bank currently
>> +unused). This is done in order to not to disrupt already active
>> +stream(s).
>> +
>> +4. Once all the new values are programmed, bus initiates switch to
>> +alternate  bank. Once switch is successful, the port channels enabled on
>> +previous bank for already active streams are disabled.

This last sentence makes no sense in this context, probably a copy/paste 
that shouldn't be there. The previously active streams remain active in 
this prepare step.

>> +
>> +5. Ports of Master and Slave for current stream are prepared.
>> +
>> +After all above operations are successful, stream state is set to
>> +SDW_STATE_STRM_PREPARE.
>> +
>> +
>> +SDW_STATE_STRM_ENABLE: Enable state of stream. Operations performed
>> +before entering in this state:
>> +1. All the values computed in SDW_STATE_STRM_PREPARE state are
>> +programmed in alternate bank (bank currently unused). It includes
>> +programming of already active streams as well.
>> +
>> +2. All the Master and Slave port channels for the current stream are
>> +enabled on alternate bank (bank currently unused).
>> +
>
> This could probably use a little more explaination to show how it
> differs from step 3/4 in PREPARE, as it looks like all the
> computed values where applied there. I imagine this is just my lack
> of understanding rather than an actual issue but even looking at
> the code I am having a little difficulty tying up these two.

Yes, see above there was an extra sentence that isn't right.

>
> sdw_prepare_op
> - sdw_compute_params (prepare step 1/2)
> - sdw_program_params (prepare step 3)
> - sdw_update_bus_params (prepare step 4)
>
> sdw_enable_op
> - sdw_program_params (enable step 1)
> - sdw_update_bus_params (enable step 2)
>
> It looks like the params are still basically the same as they
> were when we called sdw_program_params in prepare.

The parameters are the same except for the channel-enable flags which 
are only programmed and activated via a bank switch in the enable step.
