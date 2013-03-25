From: Rajeev kumar <rajeev-dlh.kumar@st.com>
Subject: Re: [PATCH 08/14] ASoC: speaer_pcm: No need to use
	snd_dmaengine_pcm_set_data()
Date: Mon, 25 Mar 2013 09:29:51 +0530
Message-ID: <514FCBB7.4020900@st.com>
References: <1363957934-20059-1-git-send-email-lars@metafoo.de>
 <1363957934-20059-9-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog101.obsmtp.com (eu1sys200aog101.obsmtp.com
 [207.126.144.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 0EE122615EC
 for <alsa-devel@alsa-project.org>; Mon, 25 Mar 2013 04:59:57 +0100 (CET)
In-Reply-To: <1363957934-20059-9-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hello Lars,

On 3/22/2013 6:42 PM, Lars-Peter Clausen wrote:
> The driver never uses snd_dmaengine_pcm_get_data(), so there is no need to use
> snd_dmaengine_pcm_set_data().
>
> Signed-off-by: Lars-Peter Clausen<lars@metafoo.de>
> Cc: Rajeev Kumar<rajeev-dlh.kumar@st.com>
> ---
>   sound/soc/spear/spear_pcm.c | 8 +-------
>   1 file changed, 1 insertion(+), 7 deletions(-)
>
> diff --git a/sound/soc/spear/spear_pcm.c b/sound/soc/spear/spear_pcm.c
> index 903ac15..bfbcc1f 100644
> --- a/sound/soc/spear/spear_pcm.c
> +++ b/sound/soc/spear/spear_pcm.c
> @@ -64,13 +64,7 @@ static int spear_pcm_open(struct snd_pcm_substream *substream)
>   	if (ret)
>   		return ret;
>
> -	ret = snd_dmaengine_pcm_open(substream, dma_data->filter, dma_data);
> -	if (ret)
> -		return ret;
> -
> -	snd_dmaengine_pcm_set_data(substream, dma_data);

The dma data is used to set dma parameters to transfer data and it will 
required by the dma engine.

Best Regards
Rajeev

> -
> -	return 0;
> +	return snd_dmaengine_pcm_open(substream, dma_data->filter, dma_data)
>   }
>
>   static int spear_pcm_mmap(struct snd_pcm_substream *substream,
