From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] ASoC: compress: Derive substream from
 stream based on direction
Date: Mon, 19 Jun 2017 18:12:28 +0530
Message-ID: <20170619124228.GJ19154@localhost>
References: <1497659620-7197-1-git-send-email-bgoswami@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 66A4A266C24
 for <alsa-devel@alsa-project.org>; Mon, 19 Jun 2017 14:39:46 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1497659620-7197-1-git-send-email-bgoswami@codeaurora.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: bgoswami@codeaurora.org
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, plai@codeaurora.org, Satish Babu Patakokila <sbpata@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 16, 2017 at 05:33:40PM -0700, bgoswami@codeaurora.org wrote:
> From: Satish Babu Patakokila <sbpata@codeaurora.org> 
> 
> Currently compress driver hardcodes direction as playback to get
> substream from the stream. This results in getting the incorrect
> substream for compressed capture usecase.
> To fix this, remove the hardcoding and derive substream based on
> the stream direction.

Acked-By: Vinod Koul <vinod.koul@intel.com>

I think we should cc this to stable..

> 
> Signed-off-by: Satish Babu Patakokila <sbpata@codeaurora.org>
> Signed-off-by: Banajit Goswami <bgoswami@codeaurora.org>
> ---
>  sound/soc/soc-compress.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
> index bfd71b8..206f36b 100644
> --- a/sound/soc/soc-compress.c
> +++ b/sound/soc/soc-compress.c
> @@ -81,7 +81,8 @@ static int soc_compr_open(struct snd_compr_stream *cstream)
>  static int soc_compr_open_fe(struct snd_compr_stream *cstream)
>  {
>  	struct snd_soc_pcm_runtime *fe = cstream->private_data;
> -	struct snd_pcm_substream *fe_substream = fe->pcm->streams[0].substream;
> +	struct snd_pcm_substream *fe_substream =
> +		 fe->pcm->streams[cstream->direction].substream;
>  	struct snd_soc_platform *platform = fe->platform;
>  	struct snd_soc_dai *cpu_dai = fe->cpu_dai;
>  	struct snd_soc_dpcm *dpcm;
> @@ -467,7 +468,8 @@ static int soc_compr_set_params_fe(struct snd_compr_stream *cstream,
>  					struct snd_compr_params *params)
>  {
>  	struct snd_soc_pcm_runtime *fe = cstream->private_data;
> -	struct snd_pcm_substream *fe_substream = fe->pcm->streams[0].substream;
> +	struct snd_pcm_substream *fe_substream =
> +		 fe->pcm->streams[cstream->direction].substream;
>  	struct snd_soc_platform *platform = fe->platform;
>  	struct snd_soc_dai *cpu_dai = fe->cpu_dai;
>  	int ret = 0, stream;
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 

-- 
~Vinod
