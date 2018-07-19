From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v6 07/10] soundwire: keep track of Masters
 in a stream
Date: Thu, 19 Jul 2018 10:06:30 -0500
Message-ID: <4a8e46a4-4010-aa70-a3d4-5c5d3faf5245@linux.intel.com>
References: <20180716184713.13356-1-sanyog.r.kale@intel.com>
 <20180716184713.13356-8-sanyog.r.kale@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by alsa0.perex.cz (Postfix) with ESMTP id 1787826733D
 for <alsa-devel@alsa-project.org>; Fri, 20 Jul 2018 01:18:10 +0200 (CEST)
In-Reply-To: <20180716184713.13356-8-sanyog.r.kale@intel.com>
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
To: Sanyog Kale <sanyog.r.kale@intel.com>, alsa-devel@alsa-project.org
Cc: patches.audio@intel.com, gregkh@linuxfoundation.org, vkoul@kernel.org, shreyas.nc@intel.com
List-Id: alsa-devel@alsa-project.org

On 7/16/18 1:47 PM, Sanyog Kale wrote:
> From: Shreyas NC <shreyas.nc@intel.com>
> 
> A multi link bankswitch can be done if the hardware supports and
> the stream is handled by multiple Master(s).
> 
> This preparatory patch adds support to track m_rt in a stream.

The order of the patches seems off, you are adding the definition of 
m_rt_count in patch 7 but using it in patch 6, that'll break git bisect.
What am i missing?

It'd also make more sense to have the reference counts in the same 
patch, it's hard to track otherwise, so maybe one patch to add the 
definitions and inits and the second to increase/decrease+use the value 
as needed.

> 
> Signed-off-by: Shreyas NC <shreyas.nc@intel.com>
> Signed-off-by: Sanyog Kale <sanyog.r.kale@intel.com>
> ---
>   drivers/soundwire/stream.c    | 2 ++
>   include/linux/soundwire/sdw.h | 2 ++
>   2 files changed, 4 insertions(+)
> 
> diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
> index 7e75a400d03e..539b98ec18d9 100644
> --- a/drivers/soundwire/stream.c
> +++ b/drivers/soundwire/stream.c
> @@ -759,6 +759,7 @@ struct sdw_stream_runtime *sdw_alloc_stream(char *stream_name)
>   	stream->name = stream_name;
>   	INIT_LIST_HEAD(&stream->master_list);
>   	stream->state = SDW_STREAM_ALLOCATED;
> +	stream->m_rt_count = 0;
>   
>   	return stream;
>   }
> @@ -963,6 +964,7 @@ int sdw_stream_remove_master(struct sdw_bus *bus,
>   
>   		sdw_master_port_release(bus, m_rt);
>   		sdw_release_master_stream(m_rt, stream);
> +		stream->m_rt_count--;
>   	}
>   
>   	if (list_empty(&stream->master_list))
> diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
> index 03df709fb8ef..214e14604d9f 100644
> --- a/include/linux/soundwire/sdw.h
> +++ b/include/linux/soundwire/sdw.h
> @@ -771,6 +771,7 @@ struct sdw_stream_params {
>    * @master_list: List of Master runtime(s) in this stream.
>    * master_list can contain only one m_rt per Master instance
>    * for a stream
> + * @m_rt_count: Count of Master runtime(s) in this stream
>    */
>   struct sdw_stream_runtime {
>   	char *name;
> @@ -778,6 +779,7 @@ struct sdw_stream_runtime {
>   	enum sdw_stream_state state;
>   	enum sdw_stream_type type;
>   	struct list_head master_list;
> +	int m_rt_count;
>   };
>   
>   struct sdw_stream_runtime *sdw_alloc_stream(char *stream_name);
> 
