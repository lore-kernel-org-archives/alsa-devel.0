From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Subject: Re: [PATCH 1/2] ASoC: SOF: ipc: update
 sof_ipc_stream_params
Date: Tue, 02 Jul 2019 16:29:57 -0700
Message-ID: <a233dfdbb973251d439197d13b69c867667d3f76.camel@linux.intel.com>
References: <20190702121144.7809-1-yang.jie@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 20EDCF800C5
 for <alsa-devel@alsa-project.org>; Wed,  3 Jul 2019 01:30:08 +0200 (CEST)
In-Reply-To: <20190702121144.7809-1-yang.jie@linux.intel.com>
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
Cc: marcin.rajwa@intel.com, pierre-louis.bossart@linux.intel.com, Marcin Rajwa <marcin.rajwa@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 2019-07-02 at 20:11 +0800, Keyon Jie wrote:
> From: Marcin Rajwa <marcin.rajwa@linux.intel.com>
> 
> The host period bytes needs to be passed to firmware.
> Currently this field is used as notification for host
> about period copy completion. Therefore we need to split these
> two informations.
Keyon/Marcin,

Could you please add a bit more context in the commit message on the
need to split these two fields ie.. what usecases need this?

Thanks,
Ranjani
> 
> Signed-off-by: Marcin Rajwa <marcin.rajwa@linux.intel.com>
> Signed-off-by: Keyon Jie <yang.jie@linux.intel.com>
> ---
>  include/sound/sof/stream.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/sound/sof/stream.h b/include/sound/sof/stream.h
> index 643f175cb479..44acfa62fa69 100644
> --- a/include/sound/sof/stream.h
> +++ b/include/sound/sof/stream.h
> @@ -83,10 +83,10 @@ struct sof_ipc_stream_params {
>  	uint16_t sample_valid_bytes;
>  	uint16_t sample_container_bytes;
>  
> -	/* for notifying host period has completed - 0 means no period
> IRQ */
>  	uint32_t host_period_bytes;
> +	uint16_t no_period_irq; /* 1 means period IRQ mode OFF */
>  
> -	uint32_t reserved[2];
> +	uint16_t reserved[3];
>  	uint16_t chmap[SOF_IPC_MAX_CHANNELS];	/**< channel map -
> SOF_CHMAP_ */
>  } __packed;
>  
