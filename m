From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v5 8/9] soundwire: Add support for multi
 link bank switch
Date: Mon, 9 Jul 2018 18:22:26 -0500
Message-ID: <6ac86676-ad92-141d-bda7-99549e0d76ea@linux.intel.com>
References: <1530791196-15483-1-git-send-email-shreyas.nc@intel.com>
 <1530791196-15483-9-git-send-email-shreyas.nc@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by alsa0.perex.cz (Postfix) with ESMTP id 615EF2675CF
 for <alsa-devel@alsa-project.org>; Tue, 10 Jul 2018 01:49:31 +0200 (CEST)
In-Reply-To: <1530791196-15483-9-git-send-email-shreyas.nc@intel.com>
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


>   
> @@ -1170,6 +1276,17 @@ int sdw_stream_add_master(struct sdw_bus *bus,
>   
>   	stream->m_rt_count++;
>   
> +	/*
> +	 * For multi link streams, add the second master only if
> +	 * the bus supports it.
> +	 * Check if bus->multi_link is set
> +	 */
> +	if (!bus->multi_link && stream->m_rt_count > 1) {
> +		dev_err(bus->dev,
> +			"Multilink not supported, link %d", bus->link_id);
> +		goto stream_error;
> +	}
> +
>   	goto unlock;
>   
>   stream_error:
>

This error handling is a bit weird. It's make more sense to check 
upfront if there is already one m_rt allocated (m_rt_count > 0) and bail 
to avoid allocating/releasing a stream. Also there should be a return 
value set (-EINVAL?)
