From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 1/1] ALSA: compress_core: Ensure device is
 stopped when stream closed
Date: Fri, 26 Apr 2013 22:12:55 +0530
Message-ID: <20130426164255.GF24632@intel.com>
References: <20130426134706.GA27501@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 6465726030A
 for <alsa-devel@alsa-project.org>; Fri, 26 Apr 2013 19:15:33 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20130426134706.GA27501@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, tiwai@suse.de, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 26, 2013 at 02:47:06PM +0100, Richard Fitzgerald wrote:
> If the stream state is running or paused when device file is
> closed snd_compr_free() will send a SNDRV_PCM_TRIGGER_STOP
> to the stream.
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
> ---
>  sound/core/compress_offload.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
> index 91e6bcb..a81c5e4 100644
> --- a/sound/core/compress_offload.c
> +++ b/sound/core/compress_offload.c
> @@ -132,6 +132,11 @@ static int snd_compr_open(struct inode *inode, struct file *f)
>  static int snd_compr_free(struct inode *inode, struct file *f)
>  {
>  	struct snd_compr_file *data = f->private_data;
> +
> +	if ((data->stream.runtime->state == SNDRV_PCM_STATE_RUNNING) ||
> +	    (data->stream.runtime->state == SNDRV_PCM_STATE_PAUSED))
> +		data->stream.ops->trigger(&data->stream, SNDRV_PCM_TRIGGER_STOP);
two things:
1. I like Mark's idea the switch will make it look better :)
2. why do you want to do explicit stop when you are freeing. Esp the Paused
cases doesnt make sense. Shouldnt the DSP be able to handle this transistion?

--
~Vinod
> +
>  	data->stream.ops->free(&data->stream);
>  	kfree(data->stream.runtime->buffer);
>  	kfree(data->stream.runtime);
> -- 
> 1.7.2.5
> 
