From: Rajeev kumar <rajeev-dlh.kumar@st.com>
Subject: Re: [PATCH 02/14] ASoC: spear_pcm: No need to wrap
	snd_dmaengine_pcm_close()
Date: Mon, 25 Mar 2013 09:21:45 +0530
Message-ID: <514FC9D1.7090108@st.com>
References: <1363957934-20059-1-git-send-email-lars@metafoo.de>
 <1363957934-20059-3-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog125.obsmtp.com (eu1sys200aog125.obsmtp.com
 [207.126.144.159])
 by alsa0.perex.cz (Postfix) with ESMTP id 0BB432615EC
 for <alsa-devel@alsa-project.org>; Mon, 25 Mar 2013 04:51:51 +0100 (CET)
In-Reply-To: <1363957934-20059-3-git-send-email-lars@metafoo.de>
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

On 3/22/2013 6:42 PM, Lars-Peter Clausen wrote:
> If a PCM driver using the dmaengine PCM helper functions doesn't need to do
> anything special in its pcm_close callback, snd_dmaengine_pcm_close can be used
> directly for as the pcm_close callback and there is no need to wrap it in a
> custom function.
>
> Signed-off-by: Lars-Peter Clausen<lars@metafoo.de>
> Cc: Rajeev Kumar<rajeev-dlh.kumar@st.com>
> ---
>   sound/soc/spear/spear_pcm.c | 10 +---------
>   1 file changed, 1 insertion(+), 9 deletions(-)
>
> diff --git a/sound/soc/spear/spear_pcm.c b/sound/soc/spear/spear_pcm.c
> index dd71167..903ac15 100644
> --- a/sound/soc/spear/spear_pcm.c
> +++ b/sound/soc/spear/spear_pcm.c
> @@ -73,14 +73,6 @@ static int spear_pcm_open(struct snd_pcm_substream *substream)
>   	return 0;
>   }
>
> -static int spear_pcm_close(struct snd_pcm_substream *substream)
> -{
> -
> -	snd_dmaengine_pcm_close(substream);
> -
> -	return 0;
> -}
> -
>   static int spear_pcm_mmap(struct snd_pcm_substream *substream,
>   		struct vm_area_struct *vma)
>   {
> @@ -93,7 +85,7 @@ static int spear_pcm_mmap(struct snd_pcm_substream *substream,
>
>   static struct snd_pcm_ops spear_pcm_ops = {
>   	.open		= spear_pcm_open,
> -	.close		= spear_pcm_close,
> +	.close		= snd_dmaengine_pcm_close,
>   	.ioctl		= snd_pcm_lib_ioctl,
>   	.hw_params	= spear_pcm_hw_params,
>   	.hw_free	= spear_pcm_hw_free,


Acked-by: Rajeev Kumar <rajeev-dlh.kumar@st.com>
