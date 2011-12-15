From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: [PATCH] ASoC: Staticise mfld_msic_dailink
Date: Thu, 15 Dec 2011 10:24:22 +0530
Message-ID: <1323924862.1641.2425.camel@vkoul-udesk3>
References: <1323861781.16636.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id DF2911038F9
	for <alsa-devel@alsa-project.org>; Thu, 15 Dec 2011 05:55:08 +0100 (CET)
In-Reply-To: <1323861781.16636.2.camel@phoenix>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 2011-12-14 at 19:23 +0800, Axel Lin wrote:
> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> ---
>  sound/soc/mid-x86/mfld_machine.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/mid-x86/mfld_machine.c b/sound/soc/mid-x86/mfld_machine.c
> index e53f8e4..8ae0574 100644
> --- a/sound/soc/mid-x86/mfld_machine.c
> +++ b/sound/soc/mid-x86/mfld_machine.c
> @@ -281,7 +281,7 @@ static int mfld_init(struct snd_soc_pcm_runtime *runtime)
>  	return ret_val;
>  }
>  
> -struct snd_soc_dai_link mfld_msic_dailink[] = {
> +static struct snd_soc_dai_link mfld_msic_dailink[] = {
>  	{
>  		.name = "Medfield Headset",
>  		.stream_name = "Headset",

Acked by: Vinod Koul <vinod.koul@linux.intel.com>

-- 
~Vinod
