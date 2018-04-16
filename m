From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v3 03/13] soundwire: Add support for port
 management
Date: Mon, 16 Apr 2018 18:30:58 -0500
Message-ID: <d0b1f66b-a530-62cf-91fb-e205b379e405@linux.intel.com>
References: <1523892221-16169-1-git-send-email-vinod.koul@intel.com>
 <1523892221-16169-4-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 21C952673D4
 for <alsa-devel@alsa-project.org>; Tue, 17 Apr 2018 01:31:01 +0200 (CEST)
In-Reply-To: <1523892221-16169-4-git-send-email-vinod.koul@intel.com>
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
To: Vinod Koul <vinod.koul@intel.com>, Greg KH <gregkh@linuxfoundation.org>
Cc: ALSA <alsa-devel@alsa-project.org>, tiwai@suse.de, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org



On 04/16/2018 10:23 AM, Vinod Koul wrote:
> From: Sanyog Kale <sanyog.r.kale@intel.com>
>
> Add Soundwire port data structures and APIS for initialization
> and release of ports.
>
> Signed-off-by: Sanyog Kale <sanyog.r.kale@intel.com>
> Signed-off-by: Shreyas NC <shreyas.nc@intel.com>
> Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> ---
>   drivers/soundwire/bus.h       |  25 +++++++
>   drivers/soundwire/stream.c    | 149 +++++++++++++++++++++++++++++++++++++++++-
>   include/linux/soundwire/sdw.h |  67 +++++++++++++++++++
>   3 files changed, 239 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/soundwire/bus.h b/drivers/soundwire/bus.h
> index 2e5043de9a4b..39e6811e435c 100644
> --- a/drivers/soundwire/bus.h
> +++ b/drivers/soundwire/bus.h
> @@ -46,6 +46,27 @@ struct sdw_msg {
>   };
>   
>   /**
> + * sdw_port_runtime: Runtime port parameters for Master or Slave
> + *
> + * @num: Port number. For audio streams, valid port number ranges from
> + * [1,14]
> + * @ch_mask: Channel mask
> + * @transport_params: Transport parameters
> + * @port_params: Port parameters
> + * @port_node: List node for Master or Slave port_list
> + *
> + * SoundWire spec has no mention of ports for Master interface but the
> + * concept is logically extended.
> + */
> +struct sdw_port_runtime {
> +	int num;
> +	int ch_mask;
> +	struct sdw_transport_params transport_params;
> +	struct sdw_port_params port_params;
> +	struct list_head port_node;
> +};
> +
> +/**
>    * sdw_slave_runtime: Runtime Stream parameters for Slave
>    *
>    * @slave: Slave handle
> @@ -53,12 +74,14 @@ struct sdw_msg {
>    * @ch_count: Number of channels handled by the Slave for
>    * this stream
>    * @m_rt_node: sdw_master_runtime list node
> + * @port_list: List of Slave Ports configured for this stream
>    */
>   struct sdw_slave_runtime {
>   	struct sdw_slave *slave;
>   	enum sdw_data_direction direction;
>   	unsigned int ch_count;
>   	struct list_head m_rt_node;
> +	struct list_head port_list;
>   };
>   
>   /**
> @@ -70,6 +93,7 @@ struct sdw_slave_runtime {
>    * @ch_count: Number of channels handled by the Master for
>    * this stream, can be zero.
>    * @slave_rt_list: Slave runtime list
> + * @port_list: List of Master Ports configured for this stream, can be zero.
>    * @bus_node: sdw_bus m_rt_list node
>    */
>   struct sdw_master_runtime {
> @@ -78,6 +102,7 @@ struct sdw_master_runtime {
>   	enum sdw_data_direction direction;
>   	unsigned int ch_count;
>   	struct list_head slave_rt_list;
> +	struct list_head port_list;
>   	struct list_head bus_node;
>   };
>   
> diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
> index 7ec1a3e4b2d6..7e2b3512d8e2 100644
> --- a/drivers/soundwire/stream.c
> +++ b/drivers/soundwire/stream.c
> @@ -81,6 +81,7 @@ static struct sdw_master_runtime
>   		return NULL;
>   
>   	/* Initialization of Master runtime handle */
> +	INIT_LIST_HEAD(&m_rt->port_list);
>   	INIT_LIST_HEAD(&m_rt->slave_rt_list);
>   	stream->m_rt = m_rt;
>   
> @@ -115,6 +116,7 @@ static struct sdw_slave_runtime
>   	if (!s_rt)
>   		return NULL;
>   
> +	INIT_LIST_HEAD(&s_rt->port_list);
>   
>   	s_rt->ch_count = stream_config->ch_count;
>   	s_rt->direction = stream_config->direction;
> @@ -123,6 +125,41 @@ static struct sdw_slave_runtime
>   	return s_rt;
>   }
>   
> +static void sdw_master_port_release(struct sdw_bus *bus,
> +			struct sdw_master_runtime *m_rt)
> +{
> +	struct sdw_port_runtime *p_rt, *_p_rt;
> +
> +	list_for_each_entry_safe(p_rt, _p_rt,
> +			&m_rt->port_list, port_node) {
> +
> +		list_del(&p_rt->port_node);
> +		kfree(p_rt);
> +	}
> +}
> +
> +static void sdw_slave_port_release(struct sdw_bus *bus,
> +		struct sdw_slave *slave,
> +		struct sdw_stream_runtime *stream)
> +{
> +	struct sdw_port_runtime *p_rt, *_p_rt;
> +	struct sdw_master_runtime *m_rt = stream->m_rt;
> +	struct sdw_slave_runtime *s_rt;
> +
> +	list_for_each_entry(s_rt, &m_rt->slave_rt_list, m_rt_node) {
> +
> +		if (s_rt->slave != slave)
> +			continue;
> +
> +		list_for_each_entry_safe(p_rt, _p_rt,
> +				&s_rt->port_list, port_node) {
> +
> +			list_del(&p_rt->port_node);
> +			kfree(p_rt);
> +		}
> +	}
> +}
> +
>   /**
>    * sdw_release_slave_stream: Free Slave(s) runtime handle
>    *
> @@ -167,7 +204,7 @@ static void sdw_release_master_stream(struct sdw_stream_runtime *stream)
>    * @bus: SDW Bus instance
>    * @stream: SoundWire stream
>    *
> - * This removes and frees master_rt from a stream
> + * This removes and frees port_rt and master_rt from a stream
>    */
>   int sdw_stream_remove_master(struct sdw_bus *bus,
>   		struct sdw_stream_runtime *stream)
> @@ -175,6 +212,7 @@ int sdw_stream_remove_master(struct sdw_bus *bus,
>   	mutex_lock(&bus->bus_lock);
>   
>   	sdw_release_master_stream(stream);
> +	sdw_master_port_release(bus, stream->m_rt);
>   	stream->state = SDW_STREAM_RELEASED;
>   	kfree(stream->m_rt);
>   	stream->m_rt = NULL;
> @@ -191,13 +229,14 @@ EXPORT_SYMBOL(sdw_stream_remove_master);
>    * @slave: SDW Slave instance
>    * @stream: SoundWire stream
>    *
> - * This removes and frees slave_rt from a stream
> + * This removes and frees port_rt and slave_rt from a stream
>    */
>   int sdw_stream_remove_slave(struct sdw_slave *slave,
>   		struct sdw_stream_runtime *stream)
>   {
>   	mutex_lock(&slave->bus->bus_lock);
>   
> +	sdw_slave_port_release(slave->bus, slave, stream);

Humm, does this work if the sdw_stream_remove_master() is called first? 
It'll call sdw_release_slave_stream() so you have lost the s_rt pointer 
by the time you want to call sdw_slave_port_release() so will never free 
the ports?

You will also have lost the stream->m_rt at that point. I believe the 
slave ports should be freed from sdw_release_slave_stream(). This call 
to sdw_slave_port_release comes too late if the master takes the 
initiative first to clean house.
