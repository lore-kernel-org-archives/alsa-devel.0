From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: soc-core: use GFP_KERNEL flag for
	kmalloc in snd_soc_cnew
Date: Mon, 22 Aug 2011 11:59:25 +0100
Message-ID: <4E52368D.4050301@ti.com>
References: <1313809425.4691.3.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 5F03B10386D
	for <alsa-devel@alsa-project.org>;
	Mon, 22 Aug 2011 12:59:41 +0200 (CEST)
In-Reply-To: <1313809425.4691.3.camel@phoenix>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On 20/08/11 04:03, Axel Lin wrote:
> GFP_ATOMIC is not needed here, use GFP_KERNEL instead.
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> ---
>  sound/soc/soc-core.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index ae93aa8..b6d8716 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -1913,7 +1913,7 @@ struct snd_kcontrol *snd_soc_cnew(const struct snd_kcontrol_new *_template,
>  
>  	if (prefix) {
>  		name_len = strlen(long_name) + strlen(prefix) + 2;
> -		name = kmalloc(name_len, GFP_ATOMIC);
> +		name = kmalloc(name_len, GFP_KERNEL);
>  		if (!name)
>  			return NULL;
>  

Acked-by: Liam Girdwood <lrg@ti.com>
