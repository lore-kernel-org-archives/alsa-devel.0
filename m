From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 1/4] ASoC: compress: Pass error out of
	soc_compr_pointer
Date: Fri, 11 Mar 2016 13:18:43 +0530
Message-ID: <20160311074843.GV11154@localhost>
References: <1457606694-10985-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 3866B2605D4
 for <alsa-devel@alsa-project.org>; Fri, 11 Mar 2016 08:44:42 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1457606694-10985-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, tiwai@suse.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 10, 2016 at 10:44:51AM +0000, Charles Keepax wrote:
> The soc_compr_pointer does not correctly pass any errors returned by the
> driver callback back up the stack. This patch corrects this issue.

Should we do that :) I am not too sure. Pointer query is supposed to read
the current value and return. You are trying to indicate that stream has
gone bad which is not the same as read faced an error...

Also please use cover letter for these things to describe problem you are
trying to solve.

> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
> ---
>  sound/soc/soc-compress.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
> index 875733c..d2df46c 100644
> --- a/sound/soc/soc-compress.c
> +++ b/sound/soc/soc-compress.c
> @@ -530,14 +530,15 @@ static int soc_compr_pointer(struct snd_compr_stream *cstream,
>  {
>  	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
>  	struct snd_soc_platform *platform = rtd->platform;
> +	int ret = 0;
>  
>  	mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);
>  
>  	if (platform->driver->compr_ops && platform->driver->compr_ops->pointer)
> -		 platform->driver->compr_ops->pointer(cstream, tstamp);
> +		ret = platform->driver->compr_ops->pointer(cstream, tstamp);
>  
>  	mutex_unlock(&rtd->pcm_mutex);
> -	return 0;
> +	return ret;
>  }
>  
>  static int soc_compr_copy(struct snd_compr_stream *cstream,
> -- 
> 2.1.4
> 

-- 
~Vinod
