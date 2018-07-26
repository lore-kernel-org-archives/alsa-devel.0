From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v7 09/10] soundwire: Add support for multi
 link bank switch
Date: Thu, 26 Jul 2018 09:02:03 -0500
Message-ID: <ffec253d-427d-44dd-522e-f0ffd08dfae6@linux.intel.com>
References: <1532605362-19282-1-git-send-email-shreyas.nc@intel.com>
 <1532605362-19282-10-git-send-email-shreyas.nc@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 4A2D626739D
 for <alsa-devel@alsa-project.org>; Thu, 26 Jul 2018 16:02:07 +0200 (CEST)
In-Reply-To: <1532605362-19282-10-git-send-email-shreyas.nc@intel.com>
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

The series looks pretty good now, I just found one possible improvement 
below
Thanks!

>   
> -static int sdw_bank_switch(struct sdw_bus *bus)
> +static int sdw_bank_switch(struct sdw_bus *bus, int m_rt_count)
>   {
>   	int col_index, row_index;
> +	bool multi_link;
>   	struct sdw_msg *wr_msg;
>   	u8 *wbuf = NULL;
>   	int ret = 0;
> @@ -638,6 +639,8 @@ static int sdw_bank_switch(struct sdw_bus *bus)
>   	if (!wr_msg)
>   		return -ENOMEM;
>   
> +	bus->defer_msg.msg = wr_msg;
> +
>   	wbuf = kzalloc(sizeof(*wbuf), GFP_KERNEL);
>   	if (!wbuf) {
>   		ret = -ENOMEM;
> @@ -658,17 +661,29 @@ static int sdw_bank_switch(struct sdw_bus *bus)
>   					SDW_MSG_FLAG_WRITE, wbuf);
>   	wr_msg->ssp_sync = true;
>   
> -	ret = sdw_transfer(bus, wr_msg);
> +	/*
> +	 * Set the multi_link flag only when both the hardware supports
> +	 * and there is a stream handled by multiple masters
> +	 */
> +	multi_link = bus->multi_link && (m_rt_count > 1);
> +
> +	if (multi_link)
> +		ret = sdw_transfer_defer(bus, wr_msg, &bus->defer_msg);
> +	else
> +		ret = sdw_transfer(bus, wr_msg);
> +
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

Should this test be extended to the case where the bus can support 
multi-link but m_rt_count ==1
should it be
if (!multi_link)
?
