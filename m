From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [PATCH v2 6/9] ASoC: Intel: Skylake: Initialize
 and load DSP controls
Date: Fri, 18 Sep 2015 10:58:54 +0100
Message-ID: <1442570334.7634.39.camel@loki>
References: <1439832404-12424-1-git-send-email-vinod.koul@intel.com>
 <1439832404-12424-7-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 4755E265A12
 for <alsa-devel@alsa-project.org>; Fri, 18 Sep 2015 11:59:00 +0200 (CEST)
In-Reply-To: <1439832404-12424-7-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: patches.audio@intel.com, Jeeja KP <jeeja.kp@intel.com>, alsa-devel@alsa-project.org, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 2015-08-17 at 22:56 +0530, Vinod Koul wrote:
> From: Jeeja KP <jeeja.kp@intel.com>
> 
> Initialize and creates DSP controls if processing pipe capability
> is supported by HW. Updates the dma_id, hw_params to module param
> to be used when DSP module has to be configured.
> 
> Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
> Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
> Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> ---
>  sound/soc/intel/skylake/skl-pcm.c | 138 ++++++++++++++++++++++++++++++--------
>  1 file changed, 111 insertions(+), 27 deletions(-)
> 
> diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
> index 7d617bf493bc..3e491149bf0c 100644
> --- a/sound/soc/intel/skylake/skl-pcm.c
> +++ b/sound/soc/intel/skylake/skl-pcm.c
> @@ -24,6 +24,7 @@
>  #include <sound/pcm_params.h>
>  #include <sound/soc.h>
>  #include "skl.h"
> +#include "skl-topology.h"
>  
>  #define HDA_MONO 1
>  #define HDA_STEREO 2
> @@ -214,6 +215,7 @@ static int skl_pcm_hw_params(struct snd_pcm_substream *substream,
>  	struct hdac_ext_bus *ebus = dev_get_drvdata(dai->dev);
>  	struct hdac_ext_stream *stream = get_hdac_ext_stream(substream);
>  	struct snd_pcm_runtime *runtime = substream->runtime;
> +	struct skl_pipe_params p_params = {0};
>  	int ret, dma_id;
>  
>  	dev_dbg(dai->dev, "%s: %s\n", __func__, dai->name);
> @@ -228,6 +230,13 @@ static int skl_pcm_hw_params(struct snd_pcm_substream *substream,
>  	dma_id = hdac_stream(stream)->stream_tag - 1;
>  	dev_dbg(dai->dev, "dma_id=%d\n", dma_id);
>  
> +	p_params.s_fmt = snd_pcm_format_width(params_format(params));
> +	p_params.ch = params_channels(params);
> +	p_params.s_freq = params_rate(params);
> +	p_params.host_dma_id = dma_id;
> +	p_params.stream = substream->stream;
> +	skl_tplg_fe_update_params(dai, &p_params);
> +
>  	return 0;
>  }
>  
> @@ -268,6 +277,46 @@ static int skl_pcm_hw_free(struct snd_pcm_substream *substream,
>  	return skl_substream_free_pages(ebus_to_hbus(ebus), substream);
>  }
>  
> +static int skl_be_hw_params(struct snd_pcm_substream *substream,
> +				struct snd_pcm_hw_params *params,
> +				struct snd_soc_dai *dai)
> +{
> +	struct skl_pipe_params p_params = {0};
> +
> +	dev_dbg(dai->dev, "%s: %s\n", __func__, dai->name);
> +

Seeing a lot of dev_dbg(__func__) in this series that really are just
tracing. Probably best to trace the calls properly or remove if it's
just development debugging.

Liam
