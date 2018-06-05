From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 3/6] soundwire: Add support to lock across
 bus instances
Date: Tue, 5 Jun 2018 14:55:41 -0500
Message-ID: <410b5432-cfc4-4a67-467a-aa091a85cdf3@linux.intel.com>
References: <1528196497-29554-1-git-send-email-shreyas.nc@intel.com>
 <1528196497-29554-4-git-send-email-shreyas.nc@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by alsa0.perex.cz (Postfix) with ESMTP id 878B7267913
 for <alsa-devel@alsa-project.org>; Tue,  5 Jun 2018 21:55:44 +0200 (CEST)
In-Reply-To: <1528196497-29554-4-git-send-email-shreyas.nc@intel.com>
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



On 06/05/2018 06:01 AM, Shreyas NC wrote:
> From: Sanyog Kale <sanyog.r.kale@intel.com>
>
> Currently, the stream concept is limited to a Master and one or
> more Codecs.
>
> This patch extends the concept to support multiple Master(s)
> sharing the same reference clock and synchronized in the hardware.
> Modify sdw_stream_runtime to support a list of sdw_master_runtime
> for the same. The existing reference to a single m_rt is removed
> in the next patch.
>
> Typically to lock, one would acquire a global lock and then lock
> bus instances. In this case, the caller framework(ASoC DPCM)
> guarentees that stream operations on a card are always serialised.
guarantees
> So, there is no race condition and hence no need for global lock.
>
> Bus lock(s) are acquired to reconfigure the bus while the stream
> is set-up.
> So, we add sdw_acquire_bus_lock()/sdw_release_bus_lock() for the same.
We should add a precision that this lock is only needed for the 
reconfiguration parts. It is my understanding that we can still do a 
synchronized bank switch between two or more streams handled by multiple 
masters, right?
>
> Signed-off-by: Sanyog Kale <sanyog.r.kale@intel.com>
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> Signed-off-by: Shreyas NC <shreyas.nc@intel.com>
> ---
>   drivers/soundwire/bus.h       |  2 ++
>   drivers/soundwire/stream.c    | 26 ++++++++++++++++++++++++++
>   include/linux/soundwire/sdw.h |  2 ++
>   3 files changed, 30 insertions(+)
>
> diff --git a/drivers/soundwire/bus.h b/drivers/soundwire/bus.h
> index 3b15c4e..b6cfbdf 100644
> --- a/drivers/soundwire/bus.h
> +++ b/drivers/soundwire/bus.h
> @@ -99,6 +99,7 @@ struct sdw_slave_runtime {
>    * this stream, can be zero.
>    * @slave_rt_list: Slave runtime list
>    * @port_list: List of Master Ports configured for this stream, can be zero.
> + * @stream_node: sdw_stream_runtime master_list node
Should we clarify that there is an expectation that the master_list can 
only handle one node per master?

>    * @bus_node: sdw_bus m_rt_list node
>    */
>   struct sdw_master_runtime {
> @@ -108,6 +109,7 @@ struct sdw_master_runtime {
>   	unsigned int ch_count;
>   	struct list_head slave_rt_list;
>   	struct list_head port_list;
> +	struct list_head stream_node;
>   	struct list_head bus_node;
>   };
>   
> diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
> index 68252f2..604fe93 100644
> --- a/drivers/soundwire/stream.c
> +++ b/drivers/soundwire/stream.c
> @@ -749,6 +749,7 @@ struct sdw_stream_runtime *sdw_alloc_stream(char *stream_name)
>   		return NULL;
>   
>   	stream->name = stream_name;
> +	INIT_LIST_HEAD(&stream->master_list);
>   	stream->state = SDW_STREAM_ALLOCATED;
>   
>   	return stream;
> @@ -1243,6 +1244,31 @@ struct sdw_dpn_prop *sdw_get_slave_dpn_prop(struct sdw_slave *slave,
>   	return NULL;
>   }
>   
> +static void sdw_acquire_bus_lock(struct sdw_stream_runtime *stream)
> +{
> +	struct sdw_master_runtime *m_rt = NULL;
> +	struct sdw_bus *bus = NULL;
> +
> +	/* Iterate for all Master(s) in Master list */
> +	list_for_each_entry(m_rt, &stream->master_list, stream_node) {
> +		bus = m_rt->bus;
> +
> +		mutex_lock(&bus->bus_lock);
> +	}
> +}
> +
> +static void sdw_release_bus_lock(struct sdw_stream_runtime *stream)
> +{
> +	struct sdw_master_runtime *m_rt = NULL;
> +	struct sdw_bus *bus = NULL;
> +
> +	/* Iterate for all Master(s) in Master list */
> +	list_for_each_entry(m_rt, &stream->master_list, stream_node) {
> +		bus = m_rt->bus;
> +		mutex_unlock(&bus->bus_lock);
> +	}
> +}
> +
>   static int _sdw_prepare_stream(struct sdw_stream_runtime *stream)
>   {
>   	struct sdw_master_runtime *m_rt = stream->m_rt;
> diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
> index 322baf4..5692de0 100644
> --- a/include/linux/soundwire/sdw.h
> +++ b/include/linux/soundwire/sdw.h
> @@ -769,6 +769,7 @@ struct sdw_stream_params {
>    * @state: Current state of the stream
>    * @type: Stream type PCM or PDM
>    * @m_rt: Master runtime
> + * @master_list: List of Master runtime(s) in this stream
>    */
>   struct sdw_stream_runtime {
>   	char *name;
> @@ -776,6 +777,7 @@ struct sdw_stream_runtime {
>   	enum sdw_stream_state state;
>   	enum sdw_stream_type type;
>   	struct sdw_master_runtime *m_rt;
> +	struct list_head master_list;
>   };
>   
>   struct sdw_stream_runtime *sdw_alloc_stream(char *stream_name);
