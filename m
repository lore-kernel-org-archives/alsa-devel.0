From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] ALSA: compress: Make sure we trigger STOP
 before closing the stream.
Date: Mon, 16 Sep 2013 09:27:53 +0530
Message-ID: <20130916035753.GJ17188@intel.com>
References: <1379090597-7096-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 30214261A34
 for <alsa-devel@alsa-project.org>; Mon, 16 Sep 2013 06:46:50 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1379090597-7096-1-git-send-email-liam.r.girdwood@linux.intel.com>
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

On Fri, Sep 13, 2013 at 05:43:16PM +0100, Liam Girdwood wrote:
> Currently we assume that userspace will shut down the compressed stream
> correctly. However, if userspcae dies (e.g. cplay & ctrl-C) we dont
> stop the stream before freeing it.
> 
> This now checks that the stream is stopped before freeing.
> 
> Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
> ---
>  sound/core/compress_offload.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
> index 99db892..a9ae4f3 100644
> --- a/sound/core/compress_offload.c
> +++ b/sound/core/compress_offload.c
> @@ -139,6 +139,18 @@ static int snd_compr_open(struct inode *inode, struct file *f)
>  static int snd_compr_free(struct inode *inode, struct file *f)
>  {
>  	struct snd_compr_file *data = f->private_data;
> +	struct snd_compr_runtime *runtime = data->stream.runtime;
> +
> +	switch (runtime->state) {
> +	case SNDRV_PCM_STATE_RUNNING:
> +	case SNDRV_PCM_STATE_DRAINING:
> +	case SNDRV_PCM_STATE_PAUSED:
> +		data->stream.ops->trigger(&data->stream, SNDRV_PCM_TRIGGER_STOP);
when usermode dies the free will get invoked as we have below. The free is a
valid trigger from any state. So shouldnt the DSP then STOP the DMAs and free
the streams.
Given that most of the usage is a DSP then IMO it might make send to tell DSP
that stop and cleanup rather than saying stop and cleanup?

~Vinod
> +		break;
> +	default:
> +		break;
> +	}
> +
>  	data->stream.ops->free(&data->stream);
>  	kfree(data->stream.runtime->buffer);
>  	kfree(data->stream.runtime);
> -- 
> 1.8.1.2
> 

-- 
