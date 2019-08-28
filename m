From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v2] ASoC: Intel: Baytrail: Fix implicit
 fallthrough warning
Date: Wed, 28 Aug 2019 12:00:14 -0500
Message-ID: <64773d79-b9ed-f42f-e2b9-4c1c18768348@linux.intel.com>
References: <20190828095102.15737-1-cezary.rojewski@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 57152F8980C
 for <alsa-devel@alsa-project.org>; Thu, 29 Aug 2019 01:05:26 +0200 (CEST)
In-Reply-To: <20190828095102.15737-1-cezary.rojewski@intel.com>
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
To: Cezary Rojewski <cezary.rojewski@intel.com>, alsa-devel@alsa-project.org
Cc: broonie@kernel.org, tiwai@suse.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On 8/28/19 4:51 AM, Cezary Rojewski wrote:
> Append fallthrough statement to fix warning reported during compilation.
> 
> Fixes: b80d19c166c4 ("ASoC: Intel: Restore Baytrail ADSP streams only when ADSP was in reset")
> Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
> 
> Changes from v1:
> - made use of fallthrough statement as suggested by Pierre
> - updated commit message
> 
>   sound/soc/intel/baytrail/sst-baytrail-pcm.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/sound/soc/intel/baytrail/sst-baytrail-pcm.c b/sound/soc/intel/baytrail/sst-baytrail-pcm.c
> index 9cbc982d46a9..54f2ee3010ee 100644
> --- a/sound/soc/intel/baytrail/sst-baytrail-pcm.c
> +++ b/sound/soc/intel/baytrail/sst-baytrail-pcm.c
> @@ -193,6 +193,7 @@ static int sst_byt_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
>   		break;
>   	case SNDRV_PCM_TRIGGER_SUSPEND:
>   		pdata->restore_stream = false;
> +		/* fallthrough */
>   	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
>   		sst_byt_stream_pause(byt, pcm_data->stream);
>   		break;
> 
