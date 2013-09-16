From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] ALSA: compress: Fix compress device
	unregister.
Date: Mon, 16 Sep 2013 09:45:01 +0530
Message-ID: <20130916041501.GK17188@intel.com>
References: <1379090597-7096-1-git-send-email-liam.r.girdwood@linux.intel.com>
 <1379090597-7096-2-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 1F9BA261A38
 for <alsa-devel@alsa-project.org>; Mon, 16 Sep 2013 07:03:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1379090597-7096-2-git-send-email-liam.r.girdwood@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.jf.intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 13, 2013 at 05:43:17PM +0100, Liam Girdwood wrote:
> snd_unregister_device() should return the device type and not stream
> direction.
Thanks for fixing this, I saw this but didnt get time to fix it.

Acked-By: Vinod Koul <vinod.koul@intel.com>
Tested-By: Vinod Koul <vinod.koul@intel.com>

Is there a Tested-Acked-??

~Vinod
> 
> Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
> ---
>  sound/core/compress_offload.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
> index a9ae4f3..fba7e7a 100644
> --- a/sound/core/compress_offload.c
> +++ b/sound/core/compress_offload.c
> @@ -849,7 +849,8 @@ static int snd_compress_dev_disconnect(struct snd_device *device)
>  	struct snd_compr *compr;
>  
>  	compr = device->device_data;
> -	snd_unregister_device(compr->direction, compr->card, compr->device);
> +	snd_unregister_device(SNDRV_DEVICE_TYPE_COMPRESS, compr->card,
> +		compr->device);
>  	return 0;
>  }
>  
> -- 
> 1.8.1.2
> 

-- 
