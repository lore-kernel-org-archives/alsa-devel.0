From: Qiao Zhou <zhouqiao@marvell.com>
Subject: Re: [PATCH] ASoC: pcm: fix dpcm_path_put in dpcm
	runtime update
Date: Thu, 12 Jun 2014 14:52:03 +0800
Message-ID: <53994E13.4020800@marvell.com>
References: <1401882126-26225-1-git-send-email-zhouqiao@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by alsa0.perex.cz (Postfix) with ESMTP id C48A5265502
 for <alsa-devel@alsa-project.org>; Thu, 12 Jun 2014 08:52:10 +0200 (CEST)
In-Reply-To: <1401882126-26225-1-git-send-email-zhouqiao@marvell.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.de" <tiwai@suse.de>, "zhangfei.gao@gmail.com" <zhangfei.gao@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 06/04/2014 07:42 PM, Qiao Zhou wrote:
> we need to release dapm widget list after dpcm_path_get in
> soc_dpcm_runtime_update. otherwise, there will be potential memory
> leak. add dpcm_path_put to fix it.
>
> Signed-off-by: Qiao Zhou <zhouqiao@marvell.com>
> ---
>   sound/soc/soc-pcm.c |    1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
> index a391de0..3bb8b80 100644
> --- a/sound/soc/soc-pcm.c
> +++ b/sound/soc/soc-pcm.c
> @@ -2072,6 +2072,7 @@ int soc_dpcm_runtime_update(struct snd_soc_card *card)
>   			dpcm_be_disconnect(fe, SNDRV_PCM_STREAM_PLAYBACK);
>   		}
>
> +		dpcm_path_put(&list);
>   capture:
>   		/* skip if FE doesn't have capture capability */
>   		if (!fe->cpu_dai->driver->capture.channels_min)
>
Hi Maintainers,

Do you have any comments? Thanks.

-- 

Best Regards
Qiao
