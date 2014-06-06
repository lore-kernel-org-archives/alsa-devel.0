From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 1/3] ASoC: Add SND_SOC_BYTES_EXT control
 type
Date: Fri, 06 Jun 2014 14:48:28 +0200
Message-ID: <5391B89C.80205@metafoo.de>
References: <1402058000-5357-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-252.synserver.de (smtp-out-252.synserver.de
 [212.40.185.252])
 by alsa0.perex.cz (Postfix) with ESMTP id 28F8E265172
 for <alsa-devel@alsa-project.org>; Fri,  6 Jun 2014 14:48:31 +0200 (CEST)
In-Reply-To: <1402058000-5357-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, sameo@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, patches@opensource.wolfsonmicro.com, broonie@kernel.org, lgirdwood@gmail.org, lee.jones@linaro.org
List-Id: alsa-devel@alsa-project.org

On 06/06/2014 02:33 PM, Charles Keepax wrote:
> Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Vinod did beat you on this one:

http://mailman.alsa-project.org/pipermail/alsa-devel/2014-May/076155.html

Although that version of the macro looks slightly different.

> ---
>   include/sound/soc.h |    7 +++++++
>   1 files changed, 7 insertions(+), 0 deletions(-)
>
> diff --git a/include/sound/soc.h b/include/sound/soc.h
> index ed9e2d7..92c1b99 100644
> --- a/include/sound/soc.h
> +++ b/include/sound/soc.h
> @@ -256,6 +256,13 @@
>   		((unsigned long)&(struct soc_bytes)           \
>   		{.base = xbase, .num_regs = xregs }) }
>
> +#define SND_SOC_BYTES_EXT(xname, xbase, xregs, xhandler_get, xhandler_put) \
> +{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname,		   \
> +	.info = snd_soc_bytes_info, .get = xhandler_get,		   \
> +	.put = xhandler_put, .private_value =				   \
> +		((unsigned long)&(struct soc_bytes)			   \
> +		{.base = xbase, .num_regs = xregs }) }
> +
>   #define SND_SOC_BYTES_MASK(xname, xbase, xregs, xmask)	      \
>   {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname,   \
>   	.info = snd_soc_bytes_info, .get = snd_soc_bytes_get, \
>
