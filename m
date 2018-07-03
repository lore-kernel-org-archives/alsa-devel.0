From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v4 4/7] soundwire: Handle multiple master
 instances in a stream
Date: Tue, 3 Jul 2018 10:03:53 -0500
Message-ID: <2fe08662-ad3e-7730-c053-37b729b0a45e@linux.intel.com>
References: <1529924340-30065-1-git-send-email-shreyas.nc@intel.com>
 <1529924340-30065-5-git-send-email-shreyas.nc@intel.com>
 <a528936c-0685-726a-1606-9d9c53a696b1@linux.intel.com>
 <20180703011302.GH15119@snc-desk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 5CA352673CB
 for <alsa-devel@alsa-project.org>; Tue,  3 Jul 2018 17:03:56 +0200 (CEST)
In-Reply-To: <20180703011302.GH15119@snc-desk>
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
To: Shreyas NC <shreyas.nc@intel.com>
Cc: patches.audio@intel.com, gregkh@linuxfoundation.org, alsa-devel@alsa-project.org, vkoul@kernel.org, sanyog.r.kale@intel.com
List-Id: alsa-devel@alsa-project.org

On 7/2/18 8:13 PM, Shreyas NC wrote:
> On Mon, Jul 02, 2018 at 03:22:07PM -0500, Pierre-Louis Bossart wrote:
>>
>>>   /**
>>> @@ -918,13 +951,22 @@ static void sdw_release_master_stream(struct sdw_stream_runtime *stream)
>>>   int sdw_stream_remove_master(struct sdw_bus *bus,
>>>   		struct sdw_stream_runtime *stream)
>>>   {
>>> +	struct sdw_master_runtime *m_rt, *_m_rt;
>>> +
>>>   	mutex_lock(&bus->bus_lock);
>>> -	sdw_release_master_stream(stream);
>>> -	sdw_master_port_release(bus, stream->m_rt);
>>> -	stream->state = SDW_STREAM_RELEASED;
>>> -	kfree(stream->m_rt);
>>> -	stream->m_rt = NULL;
>>> +	list_for_each_entry_safe(m_rt, _m_rt,
>>> +			&stream->master_list, stream_node) {
>>> +
>>> +		if (m_rt->bus != bus)
>>> +			continue;
>>> +
>>> +		sdw_master_port_release(bus, m_rt);
>>> +		sdw_release_master_stream(m_rt, stream);
>>> +	}
>>> +
>>> +	if (list_empty(&stream->master_list))
>>> +		stream->state = SDW_STREAM_RELEASED;
>> When a master is removed, there is an explicit test to make sure the stream
>> state changes when there are no masters left in the list, but...
>>
>>>   	mutex_unlock(&bus->bus_lock);
>>> @@ -1127,7 +1169,7 @@ int sdw_stream_add_master(struct sdw_bus *bus,
>>>   	stream->state = SDW_STREAM_CONFIGURED;
>> ... it's not symmetrical for the add_master case. The stream state changes
>> on the first added master. In addition the stream state changes both when a
>> slave is added and a master is added.
>> Is this intentional or not - and are there side effects resulting from this
>> inconsistency?
>>
> 
> For remove_master, we already know the number of Masters in the stream and
> hence we change the state to RELEASED only when there are no Masters
> left in stream.
> 
> But, in the add_master case, we have no idea on how many master instances
> are part of the stream and hence how many times add_master would be called.
> So, we change the stream state to CONFIGURED when the first Master is added.
> I can add a comment if that helps :)

I get the point, but you currently change the state for the first slave 
that's added, so there is an inconsistency here (even before we add the 
multi-master support).
If I wanted to split hair I'd also note it's almost like the state is 
CONFIGURING rather than CONFIGURED if you don't really control when all 
configurations are complete at the bus level and depend on external 
transitions (e.g. DAPM/ALSA initiated) to go in PREPARED mode.

> 
> Yes, it is added intentionally (or rather because we could not think of any
> other suitable way) and we dont see any side effects. Anything
> that you could think of?

We should check what happens if the stream is removed before being 
enabled, or all cases of testing stream->state.

> 
> IIRC, we had this discussion when the stream series was posted. But I am
> unable to find those mails :(

I've seen SoundWire patches for the last 2 years and don't have the 
memory of all decisions and directions either...

> 
> Thanks for the review!
> 
> --Shreyas
> 
