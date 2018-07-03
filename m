From: "Nc, Shreyas" <shreyas.nc@intel.com>
Subject: Re: [PATCH v4 4/7] soundwire: Handle multiple master
 instances in a stream
Date: Tue, 3 Jul 2018 16:03:10 +0000
Message-ID: <78E8B3DDF116FF4CB089A311DDEB1B345204E483@BGSMSX103.gar.corp.intel.com>
References: <1529924340-30065-1-git-send-email-shreyas.nc@intel.com>
 <1529924340-30065-5-git-send-email-shreyas.nc@intel.com>
 <a528936c-0685-726a-1606-9d9c53a696b1@linux.intel.com>
 <20180703011302.GH15119@snc-desk>
 <2fe08662-ad3e-7730-c053-37b729b0a45e@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 2078F26735C
 for <alsa-devel@alsa-project.org>; Tue,  3 Jul 2018 18:03:19 +0200 (CEST)
In-Reply-To: <2fe08662-ad3e-7730-c053-37b729b0a45e@linux.intel.com>
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
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Patches Audio <patches.audio@intel.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "vkoul@kernel.org" <vkoul@kernel.org>, "Kale,
 Sanyog R" <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

> >>> +	struct sdw_master_runtime *m_rt, *_m_rt;
> >>> +
> >>>   	mutex_lock(&bus->bus_lock);
> >>> -	sdw_release_master_stream(stream);
> >>> -	sdw_master_port_release(bus, stream->m_rt);
> >>> -	stream->state = SDW_STREAM_RELEASED;
> >>> -	kfree(stream->m_rt);
> >>> -	stream->m_rt = NULL;
> >>> +	list_for_each_entry_safe(m_rt, _m_rt,
> >>> +			&stream->master_list, stream_node) {
> >>> +
> >>> +		if (m_rt->bus != bus)
> >>> +			continue;
> >>> +
> >>> +		sdw_master_port_release(bus, m_rt);
> >>> +		sdw_release_master_stream(m_rt, stream);
> >>> +	}
> >>> +
> >>> +	if (list_empty(&stream->master_list))
> >>> +		stream->state = SDW_STREAM_RELEASED;
> >> When a master is removed, there is an explicit test to make sure the
> >> stream state changes when there are no masters left in the list, but...
> >>
> >>>   	mutex_unlock(&bus->bus_lock);
> >>> @@ -1127,7 +1169,7 @@ int sdw_stream_add_master(struct sdw_bus
> *bus,
> >>>   	stream->state = SDW_STREAM_CONFIGURED;
> >> ... it's not symmetrical for the add_master case. The stream state
> >> changes on the first added master. In addition the stream state
> >> changes both when a slave is added and a master is added.
> >> Is this intentional or not - and are there side effects resulting
> >> from this inconsistency?
> >>
> >
> > For remove_master, we already know the number of Masters in the stream
> > and hence we change the state to RELEASED only when there are no
> > Masters left in stream.
> >
> > But, in the add_master case, we have no idea on how many master
> > instances are part of the stream and hence how many times add_master
> would be called.
> > So, we change the stream state to CONFIGURED when the first Master is
> added.
> > I can add a comment if that helps :)
> 
> I get the point, but you currently change the state for the first slave that's
> added, so there is an inconsistency here (even before we add the multi-master
> support).

When we add a slave, we check if there is an existing m_rt for that bus instance
and if It does not exist we create a m_rt for that master instance, add the slave
runtime and change the state to CONFIGURED. So technically we still change
the state after adding the first m_rt.

> If I wanted to split hair I'd also note it's almost like the state is CONFIGURING
> rather than CONFIGURED if you don't really control when all configurations are
> complete at the bus level and depend on external transitions (e.g. DAPM/ALSA
> initiated) to go in PREPARED mode.
> 
> >
> > Yes, it is added intentionally (or rather because we could not think
> > of any other suitable way) and we dont see any side effects. Anything
> > that you could think of?
> 
> We should check what happens if the stream is removed before being enabled,
> or all cases of testing stream->state.

While releasing the stream we unconditionally clean up things without checking
stream state. So, we should be fine that way. But, I can check these :)

--Shreyas
