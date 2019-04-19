From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ASoC: pcm: save fixed-up hw_params of BE
Date: Fri, 19 Apr 2019 10:30:51 -0500
Message-ID: <fa332aba-7695-3687-b0e6-3d17d8f2ab15@linux.intel.com>
References: <1555638792-20848-1-git-send-email-libin.yang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 863DBF807B6
 for <alsa-devel@alsa-project.org>; Fri, 19 Apr 2019 17:31:05 +0200 (CEST)
In-Reply-To: <1555638792-20848-1-git-send-email-libin.yang@intel.com>
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
To: libin.yang@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, tiwai@suse.de, Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On 4/18/19 8:53 PM, libin.yang@intel.com wrote:
> From: Libin Yang <libin.yang@intel.com>
> 
> Some drivers mandate setting up hw params after resuming from system sleep.
> Since, the hw_params ioctl is not invoked upon resuming, the fixed-up BE
> dai hw params should be saved so the driver can use it in its resume
> sequence.

This functionality is needed for SOF. We initially thought of 
implementing it as an SOF-specific patch but thought this could be 
useful to others, and don't see any negative impact.

Libin and Ranjani, can you clarify what 'some drivers' means. I took it 
as "SOF and other DPCM-based drivers without the 'INFO_RESUME' flag". 
Please confirm if I was correct, if we want feedback we should clarify 
who might benefit. Thanks!


> Signed-off-by: Libin Yang <libin.yang@intel.com>
> ---
>   sound/soc/soc-pcm.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
> index d212475..7469535 100644
> --- a/sound/soc/soc-pcm.c
> +++ b/sound/soc/soc-pcm.c
> @@ -2164,6 +2164,10 @@ int dpcm_be_dai_hw_params(struct snd_soc_pcm_runtime *fe, int stream)
>   			}
>   		}
>   
> +		/* copy the fixed-up hw params for BE dai */
> +		memcpy(&be->dpcm[stream].hw_params, &dpcm->hw_params,
> +		       sizeof(struct snd_pcm_hw_params));
> +
>   		/* only allow hw_params() if no connected FEs are running */
>   		if (!snd_soc_dpcm_can_be_params(fe, be, stream))
>   			continue;
> 
