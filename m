From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ASoC: soc-pcm: BE dai needs prepare when
 pause release after resume
Date: Mon, 6 May 2019 10:07:31 -0500
Message-ID: <1135262a-0488-3261-e8d3-5e538837ba8d@linux.intel.com>
References: <1557038262-26356-1-git-send-email-libin.yang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3E3A1F80C07
 for <alsa-devel@alsa-project.org>; Mon,  6 May 2019 17:07:33 +0200 (CEST)
In-Reply-To: <1557038262-26356-1-git-send-email-libin.yang@intel.com>
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
To: libin.yang@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org
Cc: ranjani.sridharan@intel.com, rander.wang@intel.com
List-Id: alsa-devel@alsa-project.org

On 5/5/19 1:37 AM, libin.yang@intel.com wrote:
> From: Libin Yang <libin.yang@intel.com>
> 
> If playback/capture is paused and system enters S3, after system returns
> from suspend, BE dai needs to call prepare() callback when playback/capture
> is released from pause.

Libin, this patch was discussed at length on GitHub [1] and the commit 
message does not convey any of the information we looked into. It's not 
very helpful to send such patches to a larger audience without 
explaining context and goals. I personally still have no idea of the 
state machine and if all solutions need this or if this is only needed 
in the case where the RESUME_INFO flag is not set.

[1] https://github.com/thesofproject/linux/pull/868


> 
> Signed-off-by: Libin Yang <libin.yang@intel.com>
> ---
>   sound/soc/soc-pcm.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
> index d2aa560..0888995 100644
> --- a/sound/soc/soc-pcm.c
> +++ b/sound/soc/soc-pcm.c
> @@ -2471,7 +2471,8 @@ int dpcm_be_dai_prepare(struct snd_soc_pcm_runtime *fe, int stream)
>   
>   		if ((be->dpcm[stream].state != SND_SOC_DPCM_STATE_HW_PARAMS) &&
>   		    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_STOP) &&
> -		    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_SUSPEND))
> +		    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_SUSPEND) &&
> +		    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_PAUSED))
>   			continue;
>   
>   		dev_dbg(be->dev, "ASoC: prepare BE %s\n",
> 
