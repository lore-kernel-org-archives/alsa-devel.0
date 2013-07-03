From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [v2 0/5] ASoC: atmel-pcm: align with generic
	dmaengine framwork
Date: Wed, 03 Jul 2013 11:01:49 +0200
Message-ID: <51D3E87D.6040203@metafoo.de>
References: <1372840680-2253-1-git-send-email-voice.shen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-086.synserver.de (smtp-out-086.synserver.de
 [212.40.185.86])
 by alsa0.perex.cz (Postfix) with ESMTP id 424A2265532
 for <alsa-devel@alsa-project.org>; Wed,  3 Jul 2013 11:01:21 +0200 (CEST)
In-Reply-To: <1372840680-2253-1-git-send-email-voice.shen@atmel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bo Shen <voice.shen@atmel.com>
Cc: alsa-devel@alsa-project.org, richard.genoud@gmail.com, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-sound@vger.kernel.org, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On 07/03/2013 10:37 AM, Bo Shen wrote:
> This patch set is based on linux next-20130701
> 
> mainly implement
>   - move set dma data from hw_params to startup callback to avoid memory leak
>   - align atmel pcm with generic dmaenigne framwork
> 

Whole series looks good to me. Although the DMA driver still references the
ssc struct, but that can be fixed later.

FWIW, Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>


> Bo Shen (5):
>   ASoC: atmel_ssc_dai: move set dma data to startup callback
>   ASoC: atmel_ssc_dai: add error mask define
>   ASoC: atmel-pcm-dma: move prepare for dma to dai prepare
>   ARM: atmel-ssc: change phybase type to dma_addr_t
>   ASoC: atmel-pcm: use generic dmaengine framework
> 
>  include/linux/atmel-ssc.h       |    2 +-
>  sound/soc/atmel/Kconfig         |    1 +
>  sound/soc/atmel/atmel-pcm-dma.c |  118 ++++++---------------------------------
>  sound/soc/atmel/atmel_ssc_dai.c |   36 ++++++------
>  4 files changed, 37 insertions(+), 120 deletions(-)
> 
