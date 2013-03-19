From: Rajeev kumar <rajeev-dlh.kumar@st.com>
Subject: Re: [PATCH 2/2] ASoC: spear_pcm: Staticize
	non-exported structs
Date: Tue, 19 Mar 2013 09:03:19 +0530
Message-ID: <5147DC7F.9040003@st.com>
References: <1363629444-22082-1-git-send-email-lars@metafoo.de>
 <1363629444-22082-2-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog114.obsmtp.com (eu1sys200aog114.obsmtp.com
 [207.126.144.137])
 by alsa0.perex.cz (Postfix) with ESMTP id A3B47265CFA
 for <alsa-devel@alsa-project.org>; Tue, 19 Mar 2013 04:33:29 +0100 (CET)
In-Reply-To: <1363629444-22082-2-git-send-email-lars@metafoo.de>
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

On 3/18/2013 11:27 PM, Lars-Peter Clausen wrote:
> Signed-off-by: Lars-Peter Clausen<lars@metafoo.de>
> ---
>   sound/soc/spear/spear_pcm.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/sound/soc/spear/spear_pcm.c b/sound/soc/spear/spear_pcm.c
> index 5e7aebe..dd71167 100644
> --- a/sound/soc/spear/spear_pcm.c
> +++ b/sound/soc/spear/spear_pcm.c
> @@ -25,7 +25,7 @@
>   #include<sound/soc.h>
>   #include<sound/spear_dma.h>
>
> -struct snd_pcm_hardware spear_pcm_hardware = {
> +static struct snd_pcm_hardware spear_pcm_hardware = {
>   	.info = (SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_BLOCK_TRANSFER |
>   		 SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID |
>   		 SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_RESUME),
> @@ -178,7 +178,7 @@ static int spear_pcm_new(struct snd_soc_pcm_runtime *rtd)
>   	return 0;
>   }
>
> -struct snd_soc_platform_driver spear_soc_platform = {
> +static struct snd_soc_platform_driver spear_soc_platform = {
>   	.ops		=	&spear_pcm_ops,
>   	.pcm_new	=	spear_pcm_new,
>   	.pcm_free	=	spear_pcm_free,

Acked-by: Rajeev Kumar <rajeev-dlh.kumar@st.com>
	
