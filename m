From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Subject: Re: [PATCH V2] ASoC: soc-pcm: BE dai needs prepare
 when pause release after resume
Date: Wed, 08 May 2019 09:30:08 -0700
Message-ID: <aa0c6eea81a721f340dd1362801e49049a6620dd.camel@linux.intel.com>
References: <1557282761-26146-1-git-send-email-libin.yang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D4BD5F8075E
 for <alsa-devel@alsa-project.org>; Wed,  8 May 2019 18:30:12 +0200 (CEST)
In-Reply-To: <1557282761-26146-1-git-send-email-libin.yang@intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: libin.yang@intel.com, alsa-devel@alsa-project.org, tiwai@suse.de
Cc: broonie@kernel.org, ranjani.sridharan@intel.com, pierre-louis.bossart@linux.intel.com, rander.wang@intel.com
List-Id: alsa-devel@alsa-project.org

On Wed, 2019-05-08 at 10:32 +0800, libin.yang@intel.com wrote:
> From: Libin Yang <libin.yang@intel.com>
> 
> If playback/capture is paused and system enters S3, after system
> returns
> from suspend, BE dai needs to call prepare() callback when
> playback/capture
> is released from pause if RESUME_INFO flag is not set.
Hi Takashi,

This is a question for you. We've run into the problem of not being
able to do a pause-release after the system resumes from S3 after we
removed INFO_RESUME from the SOF driver. 

Apparently, with this flag removed, when the user does a pause release
after resuming from S3, the prepare() callback gets invoked for the FE
but doesnt happen for the the BE. Could you please guide us on whether
this is the right approach and if not, suggest an alternative?

Thanks,
Ranjani
> 
> Currently, the dpcm_be_dai_prepare() function will block calling
> prepare()
> if the pcm is in SND_SOC_DPCM_STATE_PAUSED state. This will cause the
> following test case fail if the pcm uses BE:
> 
> playback -> pause -> S3 suspend -> S3 resume -> pause release
> 
> The playback may exit abnormally when pause is released because the
> BE dai
> prepare() is not called.
> 
> This patch allows dpcm_be_dai_prepare() to call dai prepare()
> callback in
> SND_SOC_DPCM_STATE_PAUSED state.
> 
> Signed-off-by: Libin Yang <libin.yang@intel.com>
> ---
>  sound/soc/soc-pcm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
> index d2aa560..0888995 100644
> --- a/sound/soc/soc-pcm.c
> +++ b/sound/soc/soc-pcm.c
> @@ -2471,7 +2471,8 @@ int dpcm_be_dai_prepare(struct
> snd_soc_pcm_runtime *fe, int stream)
>  
>  		if ((be->dpcm[stream].state !=
> SND_SOC_DPCM_STATE_HW_PARAMS) &&
>  		    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_STOP)
> &&
> -		    (be->dpcm[stream].state !=
> SND_SOC_DPCM_STATE_SUSPEND))
> +		    (be->dpcm[stream].state !=
> SND_SOC_DPCM_STATE_SUSPEND) &&
> +		    (be->dpcm[stream].state !=
> SND_SOC_DPCM_STATE_PAUSED))
>  			continue;
>  
>  		dev_dbg(be->dev, "ASoC: prepare BE %s\n",
