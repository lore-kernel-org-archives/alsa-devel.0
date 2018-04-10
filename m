From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v2 02/13] soundwire: Add support for
 SoundWire stream management
Date: Tue, 10 Apr 2018 10:47:24 -0500
Message-ID: <29ccea0c-e89c-f9c2-7cde-465a60f14acc@linux.intel.com>
References: <1522946904-2089-1-git-send-email-vinod.koul@intel.com>
 <1522946904-2089-3-git-send-email-vinod.koul@intel.com>
 <bd17bb61-11cb-c1d5-d9cc-29cb9b01d928@linux.intel.com>
 <20180406045338.GE6014@localhost>
 <12d67055-d20b-5573-e342-35865b973ec8@linux.intel.com>
 <20180410044306.GP6014@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id A357F2672B2
 for <alsa-devel@alsa-project.org>; Tue, 10 Apr 2018 18:08:27 +0200 (CEST)
In-Reply-To: <20180410044306.GP6014@localhost>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: ALSA <alsa-devel@alsa-project.org>, tiwai@suse.de, Greg KH <gregkh@linuxfoundation.org>, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org


>>>>> + * @slave_rt_list: Slave runtime list
>>>>> + * @bus_node: sdw_bus m_rt_list node
>>>>
>>>> I think the intention was to progress in steps, but by omitting references
>>>> to the multi-master case in this series or comments explaining the next
>>>> steps the structure and code are not easy to follow.
>>>
>>> We cannot have any ref to multi-master as it is not in this series. That is how
>>> patches would be done, you add a step and then increment with another.
>>
>> The point is that the bus_node is only relevant for multi-master, so you
>> have structure fields are present, not currently used but will be.
>> It's perfectly ok to progress in steps, but you have to be consistent. If
>> you keep a structure that will only be used later, you need to tell this to
>> reviewers.
> 
> Sorry no it is not the case. bus_node keeps track of master_rt on a bus.
> This is used in non multi-link case Ex multiple streams over a bus.
> We need to redo bandwidth calculation etc on a bus when a new stream
> arrives or existing stream frees up, so a bus will always track
> the master_rt

I stand corrected, thanks.

> 
>>> Ofcourse if you have any question feel free to ask and we can clarify, but I
>>> do not think it would be correct to add comments/reference here for
>>> multi-master. These will be updated as required when we post multi-master.
>>>
>>>> There should be a clear explanation that
>>>> - a stream can be connected a least one Slave Device with one or more ports.
>>>
>>> explained in document patch
>>>
>>>> - a stream may be connected to zero or more Master Devices. In the former
>>>> case one of the Slave devices has provide TX ports.
>>>
>>> That's multi-link/device-device not under review here
>>
>> zero or more describes the single master case.
>>
>>>> - the slave runtime keeps track of all the masters the stream is connected
>>>> to
>>>
>>> not that is not a correct assumption
>>
>> yes this is wrong, I meant "the master runtime keeps tracks off all the
>> Slaves the stream is connected to"
>>>
>>>> - the master runtime keeps track of
>>>> 1. all the Slaves it is physically connected to which support a stream.
>>>
>>> Yes that is added here
>>>
>>>> 2. all bus instances (and related masters) that support this stream.
>>>
>>> That's again multi-link!
>>
>> the statement is still correct with a single instance :-)
>>
>>> Again we are not writing a spec but code and comments to explain the code.
>>> The above is not related to "this" series so we should not add it here. When
>>> we add device-device support, multi-master support these can be added
>>>
>>> We are adding blocks in a giant building, but you are only looking at the
>>> giant picture but not the block in discussion!
>>
>> no, you have keep mentions to multi-link that are questionable. Either you
>> remove them or you state it's reserved for future use.
> 
> I have clarified on bus_node above, can you check and tell me if there is
> anything else?

The code pattern for the bank switch was inspired by multi-link.

>>
>>>>> +/**
>>>>> + * sdw_alloc_stream: Allocate and return stream runtime
>>>>> + *
>>>>> + * @stream_name: SoundWire stream name
>>>>> + *
>>>>> + * Allocates a SoundWire stream runtime instance.
>>>>> + * sdw_alloc_stream should be called only once per stream
>>>>
>>>> You should explain who the caller might be, and probably check if a stream
>>>> with the same name was not already allocated.
>>>
>>> Checking name might be bit iffy as we would need to check all streams. The
>>> name is used for prints so if caller screws up name then it would be at his
>>> own peril to get confused between same stream names in logs :)
>>
>> You didn't answer to the question: who is supposed to call
>> sdw_alloc_steam()? the machine driver? The platform driver? the codec
>> driver? How do you garantee that it's called once
> 
> Sorry about that, it would by machine or platform but only once.
> We can't guarantee that as it is caller prerogative but code will not work if
> someone calls multiple times and they will debug.
> 
> Btw this assumption is explicitly added in documentation.

I don't get how this would work. To me the platform drivers and codec 
drivers expose DAIs, and the machine drivers connect them. The stream is 
an additional level that the machine driver should know. I just don't 
see how a platform driver would handle this?
>>>>> +int sdw_stream_add_master(struct sdw_bus *bus,
>>>>> +		struct sdw_stream_config *stream_config,
>>>>> +		struct sdw_stream_runtime *stream)
>>>>> +{
>>>>> +	struct sdw_master_runtime *m_rt = NULL;
>>>>> +	int ret;
>>>>> +
>>>>> +	if (stream->state != SDW_STREAM_ALLOCATED &&
>>>>> +			stream->state != SDW_STREAM_CONFIGURED) {
>>>>> +		dev_err(bus->dev,
>>>>> +			"Invalid stream state %d", stream->state);
>>>>> +		return -EINVAL;
>>>>> +	}
>>>>
>>>> Humm, this check looks like new code but I don't get it. Why would one add a
>>>> master in either of those two states? Why not ALLOCATED only?
>>>
>>> So slave or master can be added to a stream in any order. Only if slave is
>>> called first we need master_rt to be allocated too. In ideal world we would
>>> do allocation and then configuration, but due to user calling in any order
>>> we may do allocation and configuration of slave first followed by
>>> configuring the master.
>>
>> that makes no sense. You have a state diagram that defines a state
>> transition which precludes this order between allocation and configuration.
> 
> Okay so we are going to track if master and slaves runtimes are configured
> by adding a flag in each of them. Once all the components are configured the
> stream stated will be updated. Does that sound ok?

How do you detect that all components are configured? We have a 
distributed allocation/configuration with multiple actors, I don't what 
triggers the transition to a new state.
see more below.

> 
>>>> +Configuration state of stream. Operations performed before entering in
>>>> +this state:
>>>> +
>>>> +  (1) The resources allocated for stream information in
>>>> SDW_STREAM_ALLOCATED
>>>> +      state are updated here. This includes stream parameters, Master(s)
>>>> +      and Slave(s) runtime information associated with current stream.
>>>> +
>>>> +  (2) All the Master(s) and Slave(s) associated with current stream provide
>>>> +      the port information to Bus which includes port numbers allocated by
>>>> +      Master(s) and Slave(s) for current stream and their channel mask.
>>>>
>>>> so how can Master ports be configured if it is added to a stream *after* the
>>>> CONFIGURED state?
>>>
>>> Yes you have a valid point wrt documentation, will update it.
>>
>> It's not just the documentation, I wonder if it actually works. You would
>> want to make sure all masters and slaves are allocated before configuring
>> them, otherwise the error handling flow is just awful to deal with. You
>> could end-up in a situation where all Slaves are configured but the master
>> allocation fails.
> 
> Ok

If the ALLOCATED and CONFIGURED states are clearly separated out, then 
what if the flag you mentioned used for?

>>>>> +
>>>>> +	m_rt = sdw_alloc_master_rt(bus, stream_config, stream);
>>>>> +	if (!m_rt) {
>>>>> +		dev_err(bus->dev,
>>>>> +				"Master runtime config failed for stream:%s",
>>>>> +				stream->name);
>>>>> +		ret = -ENOMEM;
>>>>> +		goto error;
>>>>> +	}
>>>>> +
>>>>> +	ret = sdw_config_stream(bus->dev, stream, stream_config, false);
>>>>> +	if (ret)
>>>>> +		goto stream_error;
>>>>> +
>>>>> +	if (!list_empty(&m_rt->slave_rt_list) &&
>>>>> +			stream->state == SDW_STREAM_ALLOCATED)
>>>>> +		stream->state = SDW_STREAM_CONFIGURED;
>>>>
>>>> this looks also like new code, what is the idea about this configuration
>>>> business?
>>>> To me this is inconsistent with the documentation which says
>>>> sdw_stream_add_master is called in ALLOCATED state. Under what circumstances
>>>> would this routing be called from two different states?
>>>
>>> Yes it "may" be due to sequencing in callers control.
>>>
>>>> This may be ok but the intent is clear as mud.
>>>
>>> Yes that is a bit unfortunate :(
>>
>> You'll need to really rework this, i don't get why this major change comes
>> in a v2 without the associated collateral explaining the rationale for this
>> change.
> 
> Btw this change was not introduced in v2, it was there in v1 too

It wasn't there in the initial patches shared with me in February. There 
were too many missing parts in v1 that I stopped the review.
