From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v3 5/6] soundwire: Add support for multi
 link bank switch
Date: Thu, 14 Jun 2018 13:34:13 -0500
Message-ID: <fe087024-ce4e-ca11-cf68-6dca583b7cbb@linux.intel.com>
References: <1528975923-15141-1-git-send-email-shreyas.nc@intel.com>
 <1528975923-15141-6-git-send-email-shreyas.nc@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 500DF2673CC
 for <alsa-devel@alsa-project.org>; Thu, 14 Jun 2018 20:34:25 +0200 (CEST)
In-Reply-To: <1528975923-15141-6-git-send-email-shreyas.nc@intel.com>
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


> diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
> index 0e8a2eb5..771c963 100644
> --- a/drivers/soundwire/stream.c
> +++ b/drivers/soundwire/stream.c
> @@ -638,6 +638,8 @@ static int sdw_bank_switch(struct sdw_bus *bus)
>   	if (!wr_msg)
>   		return -ENOMEM;
>   
> +	bus->defer_msg.msg = wr_msg;
> +
>   	wbuf = kzalloc(sizeof(*wbuf), GFP_KERNEL);
>   	if (!wbuf) {
>   		ret = -ENOMEM;
> @@ -658,17 +660,23 @@ static int sdw_bank_switch(struct sdw_bus *bus)
>   					SDW_MSG_FLAG_WRITE, wbuf);
>   	wr_msg->ssp_sync = true;
>   
> -	ret = sdw_transfer(bus, wr_msg);
> +	if (bus->multi_link)
> +		ret = sdw_transfer_defer(bus, wr_msg, &bus->defer_msg);
> +	else
> +		ret = sdw_transfer(bus, wr_msg);
> +

Re-reading this v3, I wonder if there is a small logic flaw here or an 
intended behavior.

the bus->multi_link field is a hardware capability, it provides 
information on whether the hardware can support synchronized bank 
switches across multiple Master interfaces. This is independent of the 
streams being handled, it's a bus property - not a stream one.

However the default/typical case is a stream handled by a single master, 
so when the hardware is capable of handling multiple masters this does 
not mean you should use the deferred transfer, the regular case would 
work just fine for a regular stream. If your SSP rate is faster than the 
common sync signal it might even be beneficial not to use the deferred 
transfer.

in other words, should the code be written with something like
if (bus->multi_link && master_rt_count > 1)
with master_rt_count being determined based on the stream properties.

Or was the intent that you always rely on the deferred mechanism, even 
if the stream is not handled by multiple masters? In that case, do we 
even need the regular bank switch?

>   	if (ret < 0) {
>   		dev_err(bus->dev, "Slave frame_ctrl reg write failed");
>   		goto error;
>   	}
>   
> -	kfree(wr_msg);
> -	kfree(wbuf);
> -	bus->defer_msg.msg = NULL;
> -	bus->params.curr_bank = !bus->params.curr_bank;
> -	bus->params.next_bank = !bus->params.next_bank;
> +	if (!bus->multi_link) {
> +		kfree(wr_msg);
> +		kfree(wbuf);
> +		bus->defer_msg.msg = NULL;
> +		bus->params.curr_bank = !bus->params.curr_bank;
> +		bus->params.next_bank = !bus->params.next_bank;
> +	}
>   
>   	return 0;
>   
> @@ -679,36 +687,88 @@ static int sdw_bank_switch(struct sdw_bus *bus)
>   	return ret;
>   }
>   
> +/**
> + * sdw_ml_sync_bank_switch: Multilink register bank switch
> + *
> + * @bus: SDW bus instance
> + *
> + * Caller function should free the buffers on error
> + */
> +static int sdw_ml_sync_bank_switch(struct sdw_bus *bus)
> +{
> +	unsigned long time_left;
> +	int ret = 0;
> +
> +	if (!bus->multi_link)
> +		return ret;
> +
> +	/* Wait for completion of transfer */
> +	time_left = wait_for_completion_timeout(&bus->defer_msg.complete,
> +						bus->bank_switch_timeout);
> +
> +	if (!time_left) {
> +		dev_err(bus->dev, "Controller Timed out on bank switch");
> +		return -ETIMEDOUT;
> +	}
> +
> +	bus->params.curr_bank = !bus->params.curr_bank;
> +	bus->params.next_bank = !bus->params.next_bank;
> +
> +	if (bus->defer_msg.msg) {
> +		kfree(bus->defer_msg.msg->buf);
> +		kfree(bus->defer_msg.msg);
> +	}
> +
> +	return ret;
> +}
> +
>   static int do_bank_switch(struct sdw_stream_runtime *stream)
>   {
>   	struct sdw_master_runtime *m_rt = NULL;
>   	const struct sdw_master_ops *ops;
>   	struct sdw_bus *bus = NULL;
> +	bool multi_link = false;
>   	int ret = 0;
>   
> -
>   	list_for_each_entry(m_rt, &stream->master_list, stream_node) {
>   		bus = m_rt->bus;
>   		ops = bus->ops;
>   
> +		if (bus->multi_link) {
> +			multi_link = true;
> +			mutex_lock(&bus->msg_lock);
> +		}
> +
>   		/* Pre-bank switch */
>   		if (ops->pre_bank_switch) {
>   			ret = ops->pre_bank_switch(bus);
>   			if (ret < 0) {
>   				dev_err(bus->dev,
>   					"Pre bank switch op failed: %d", ret);
> -				return ret;
> +				goto msg_unlock;
>   			}
>   		}
>   
> -		/* Bank switch */
> +		/*
> +		 * Perform Bank switch operation.
> +		 * For multi link cases, the actual bank switch is
> +		 * synchronized across all Masters and happens later as a
> +		 * part of post_bank_switch ops.
> +		 */
>   		ret = sdw_bank_switch(bus);
>   		if (ret < 0) {
>   			dev_err(bus->dev, "Bank switch failed: %d", ret);
> -			return ret;
> +			goto error;
> +
>   		}
>   	}
>   
> +	/*
> +	 * For multi link cases, it is expected that the bank switch is
> +	 * triggered by the post_bank_switch for the first Master in the list
> +	 * and for the other Masters the post_bank_switch() should return doing
> +	 * nothing.
> +	 */
>   	list_for_each_entry(m_rt, &stream->master_list, stream_node) {
>   		bus = m_rt->bus;
>   		ops = bus->ops;
> @@ -719,8 +779,44 @@ static int do_bank_switch(struct sdw_stream_runtime *stream)
>   			if (ret < 0) {
>   				dev_err(bus->dev,
>   					"Post bank switch op failed: %d", ret);
> +				goto error;
>   			}
>   		}
> +
> +		/* Set the bank switch timeout to default, if not set */
> +		if (!bus->bank_switch_timeout)
> +			bus->bank_switch_timeout = DEFAULT_BANK_SWITCH_TIMEOUT;
> +
> +		/* Check if bank switch was successful */
> +		ret = sdw_ml_sync_bank_switch(bus);
> +		if (ret < 0) {
> +			dev_err(bus->dev,
> +				"multi link bank switch failed: %d", ret);
> +			goto error;
> +		}
> +
> +		mutex_unlock(&bus->msg_lock);
> +	}
> +
> +	return ret;
> +
> +error:
> +	list_for_each_entry(m_rt, &stream->master_list, stream_node) {
> +
> +		bus = m_rt->bus;
> +
> +		kfree(bus->defer_msg.msg->buf);
> +		kfree(bus->defer_msg.msg);
> +	}
> +
> +msg_unlock:
> +
> +	if (multi_link) {
> +		list_for_each_entry(m_rt, &stream->master_list, stream_node) {
> +			bus = m_rt->bus;
> +			if (mutex_is_locked(&bus->msg_lock))
> +				mutex_unlock(&bus->msg_lock);
> +		}
>   	}
>   
>   	return ret;
> diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
> index 03df709..f006029 100644
> --- a/include/linux/soundwire/sdw.h
> +++ b/include/linux/soundwire/sdw.h
> @@ -673,6 +673,7 @@ struct sdw_master_ops {
>    * @params: Current bus parameters
>    * @prop: Master properties
>    * @m_rt_list: List of Master instance of all stream(s) running on Bus. This
> + * @multi_link: if multi links are supported
>    * is used to compute and program bus bandwidth, clock, frame shape,
>    * transport and port parameters
>    * @defer_msg: Defer message
> @@ -691,6 +692,7 @@ struct sdw_bus {
>   	struct sdw_bus_params params;
>   	struct sdw_master_prop prop;
>   	struct list_head m_rt_list;
> +	bool multi_link;
>   	struct sdw_defer defer_msg;
>   	unsigned int clk_stop_timeout;
>   	u32 bank_switch_timeout;
> 
