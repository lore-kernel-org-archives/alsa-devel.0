From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v2 1/2] ASoC: SOF: add flag for position
	update ipc
Date: Wed, 17 Jul 2019 10:48:03 -0500
Message-ID: <323bbf08-c6dd-a95c-761d-c464ddf7275f@linux.intel.com>
References: <20190703151023.30313-1-yang.jie@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 72D0BF8015B
 for <alsa-devel@alsa-project.org>; Wed, 17 Jul 2019 17:48:06 +0200 (CEST)
In-Reply-To: <20190703151023.30313-1-yang.jie@linux.intel.com>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Keyon Jie <yang.jie@linux.intel.com>, alsa-devel@alsa-project.org
Cc: ranjani.sridharan@linux.intel.com, Marcin Rajwa <marcin.rajwa@linux.intel.com>
List-Id: alsa-devel@alsa-project.org



On 7/3/19 10:10 AM, Keyon Jie wrote:
> From: Marcin Rajwa <marcin.rajwa@linux.intel.com>
> 
> In some cases, FW might need use the host_period_bytes even no position
> update ipc reqiured from driver, here add another flag for position update,
> and preserve host_period_bytes for FW to use.

please fix the commit message, e.g. with the suggested edit below

In some cases, FW might need to use the host_period_bytes field to fetch 
data over DMA but the driver does not need any position information 
returned over the IPC channel by the firmware. The current IPC 
definition prevents this capability, so add new field.

> 
> This might require corresponding FW change and ABI alignment.

remove this statement, this is already handled in backwards compatible mode.

> 
> Signed-off-by: Marcin Rajwa <marcin.rajwa@linux.intel.com>
> Signed-off-by: Keyon Jie <yang.jie@linux.intel.com>
> ---
>   include/sound/sof/stream.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/sound/sof/stream.h b/include/sound/sof/stream.h
> index 643f175cb479..44acfa62fa69 100644
> --- a/include/sound/sof/stream.h
> +++ b/include/sound/sof/stream.h
> @@ -83,10 +83,10 @@ struct sof_ipc_stream_params {
>   	uint16_t sample_valid_bytes;
>   	uint16_t sample_container_bytes;
>   
> -	/* for notifying host period has completed - 0 means no period IRQ */
>   	uint32_t host_period_bytes;
> +	uint16_t no_period_irq; /* 1 means period IRQ mode OFF */

I'd like this field to be renamed as 'no_position_update'. This really 
has nothing to do with no period_irq in general, even when you do use 
the no_irq mode you can still retrieve the position information from the 
HDaudio DMA registers.

> -	uint32_t reserved[2];
> +	uint16_t reserved[3];
>   	uint16_t chmap[SOF_IPC_MAX_CHANNELS];	/**< channel map - SOF_CHMAP_ */
>   } __packed;
>   
> 
