From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v4 4/7] soundwire: Handle multiple master
 instances in a stream
Date: Mon, 2 Jul 2018 15:22:07 -0500
Message-ID: <a528936c-0685-726a-1606-9d9c53a696b1@linux.intel.com>
References: <1529924340-30065-1-git-send-email-shreyas.nc@intel.com>
 <1529924340-30065-5-git-send-email-shreyas.nc@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 69B022676FD
 for <alsa-devel@alsa-project.org>; Tue,  3 Jul 2018 00:12:14 +0200 (CEST)
In-Reply-To: <1529924340-30065-5-git-send-email-shreyas.nc@intel.com>
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
To: Shreyas NC <shreyas.nc@intel.com>, alsa-devel@alsa-project.org
Cc: patches.audio@intel.com, gregkh@linuxfoundation.org, vkoul@kernel.org, sanyog.r.kale@intel.com
List-Id: alsa-devel@alsa-project.org


>   /**
> @@ -918,13 +951,22 @@ static void sdw_release_master_stream(struct sdw_stream_runtime *stream)
>   int sdw_stream_remove_master(struct sdw_bus *bus,
>   		struct sdw_stream_runtime *stream)
>   {
> +	struct sdw_master_runtime *m_rt, *_m_rt;
> +
>   	mutex_lock(&bus->bus_lock);
>   
> -	sdw_release_master_stream(stream);
> -	sdw_master_port_release(bus, stream->m_rt);
> -	stream->state = SDW_STREAM_RELEASED;
> -	kfree(stream->m_rt);
> -	stream->m_rt = NULL;
> +	list_for_each_entry_safe(m_rt, _m_rt,
> +			&stream->master_list, stream_node) {
> +
> +		if (m_rt->bus != bus)
> +			continue;
> +
> +		sdw_master_port_release(bus, m_rt);
> +		sdw_release_master_stream(m_rt, stream);
> +	}
> +
> +	if (list_empty(&stream->master_list))
> +		stream->state = SDW_STREAM_RELEASED;
When a master is removed, there is an explicit test to make sure the 
stream state changes when there are no masters left in the list, but...

>   
>   	mutex_unlock(&bus->bus_lock);
>   
> @@ -1127,7 +1169,7 @@ int sdw_stream_add_master(struct sdw_bus *bus,
>   	stream->state = SDW_STREAM_CONFIGURED;
... it's not symmetrical for the add_master case. The stream state 
changes on the first added master. In addition the stream state changes 
both when a slave is added and a master is added.
Is this intentional or not - and are there side effects resulting from 
this inconsistency?
