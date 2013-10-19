From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ALSA: Add MAINTAINERS entry for dmaengine
 helpers
Date: Sat, 19 Oct 2013 19:17:41 +0200
Message-ID: <5262BEB5.2000709@metafoo.de>
References: <1382189634-22645-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-101.synserver.de (smtp-out-103.synserver.de
 [212.40.185.103])
 by alsa0.perex.cz (Postfix) with ESMTP id 4D0752608ED
 for <alsa-devel@alsa-project.org>; Sat, 19 Oct 2013 19:17:51 +0200 (CEST)
In-Reply-To: <1382189634-22645-1-git-send-email-broonie@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

On 10/19/2013 03:33 PM, Mark Brown wrote:
> From: Mark Brown <broonie@linaro.org>
> 
> Help ensure that Lars-Peter gets CCed on dmaengine related patches by
> adding a MAINTAINERS entry for the helpers.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>

Thanks.

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

> ---
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 34ca01a..3a7eaaa 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7877,6 +7877,13 @@ F:	Documentation/sound/alsa/soc/
>  F:	sound/soc/
>  F:	include/sound/soc*
>  
> +SOUND - DMAENGINE HELPERS
> +M:	Lars-Peter Clausen <lars@metafoo.de>
> +S:	Supported
> +F:	include/sound/dmaengine_pcm.h
> +F:	sound/core/pcm_dmaengine.c
> +F:	sound/soc/soc-generic-dmaengine-pcm.c
> +
>  SPARC + UltraSPARC (sparc/sparc64)
>  M:	"David S. Miller" <davem@davemloft.net>
>  L:	sparclinux@vger.kernel.org
> 
