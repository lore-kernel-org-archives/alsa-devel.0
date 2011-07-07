From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: pxa2xx-pcm: remove unused variable
	'dai'
Date: Thu, 7 Jul 2011 10:20:11 +0100
Message-ID: <4E157A4B.6060407@ti.com>
References: <1309958442.4613.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 0BC7D24456
	for <alsa-devel@alsa-project.org>;
	Thu,  7 Jul 2011 11:20:17 +0200 (CEST)
In-Reply-To: <1309958442.4613.1.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Eric Miao <eric.y.miao@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On 06/07/11 14:20, Axel Lin wrote:
> Remove unused variable 'dai' to eliminate below warning.
> 
>   CC      sound/soc/pxa/pxa2xx-pcm.o
> sound/soc/pxa/pxa2xx-pcm.c: In function 'pxa2xx_soc_pcm_new':
> sound/soc/pxa/pxa2xx-pcm.c:91: warning: unused variable 'dai'
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> ---
>  sound/soc/pxa/pxa2xx-pcm.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/pxa/pxa2xx-pcm.c b/sound/soc/pxa/pxa2xx-pcm.c
> index da28394..c430600 100644
> --- a/sound/soc/pxa/pxa2xx-pcm.c
> +++ b/sound/soc/pxa/pxa2xx-pcm.c
> @@ -88,7 +88,6 @@ static u64 pxa2xx_pcm_dmamask = DMA_BIT_MASK(32);
>  static int pxa2xx_soc_pcm_new(struct snd_soc_pcm_runtime *rtd)
>  {
>  	struct snd_card *card = rtd->card->snd_card;
> -	struct snd_soc_dai *dai = rtd->cpu_dai;
>  	struct snd_pcm *pcm = rtd->pcm;
>  	int ret = 0;
>  

Acked-by: Liam Girdwood <lrg@ti.com>
