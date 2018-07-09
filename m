From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v5 1/9] soundwire: Fix duplicate stream
	state assignment
Date: Mon, 9 Jul 2018 18:41:40 -0500
Message-ID: <31cd152c-b8f1-77eb-6a81-a6e5a1ac7101@linux.intel.com>
References: <1530791196-15483-1-git-send-email-shreyas.nc@intel.com>
 <1530791196-15483-2-git-send-email-shreyas.nc@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by alsa0.perex.cz (Postfix) with ESMTP id 3BCD02676FB
 for <alsa-devel@alsa-project.org>; Tue, 10 Jul 2018 01:49:35 +0200 (CEST)
In-Reply-To: <1530791196-15483-2-git-send-email-shreyas.nc@intel.com>
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



On 07/05/2018 06:46 AM, Shreyas NC wrote:
> For a SoundWire stream it is expected that a Slave is added to the
> stream before Master is added.
>
> So, move the stream state to CONFIGURED after the first Slave is
> added and remove the stream state assignment for Master add.
> Along with these changes, add additional comments to explain the same.
>
> Signed-off-by: Shreyas NC <shreyas.nc@intel.com>
> ---
>   drivers/soundwire/stream.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
> index 8974a0f..37603c3 100644
> --- a/drivers/soundwire/stream.c
> +++ b/drivers/soundwire/stream.c
> @@ -1123,8 +1123,6 @@ int sdw_stream_add_master(struct sdw_bus *bus,
>   	if (ret)
>   		goto stream_error;
>   
> -	stream->state = SDW_STREAM_CONFIGURED;
> -
>   stream_error:
>   	sdw_release_master_stream(stream);
>   error:
> @@ -1141,6 +1139,10 @@ EXPORT_SYMBOL(sdw_stream_add_master);
>    * @stream: SoundWire stream
>    * @port_config: Port configuration for audio stream
>    * @num_ports: Number of ports
> + *
> + * It is expected that Slave is added before adding Master
> + * to the Stream.
> + *
>    */
>   int sdw_stream_add_slave(struct sdw_slave *slave,
>   		struct sdw_stream_config *stream_config,
> @@ -1186,6 +1188,11 @@ int sdw_stream_add_slave(struct sdw_slave *slave,
>   	if (ret)
>   		goto stream_error;
>   
> +	/*
> +	 * Change stream state to CONFIGURED on first Slave add.
> +	 * We don't know number of Slaves in a stream currently so cant
can't or cannot.
> +	 * wait for all Slaves to be added
> +	 */
>   	stream->state = SDW_STREAM_CONFIGURED;
>   	goto error;
>   
