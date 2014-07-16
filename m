From: Daniel Mack <daniel@zonque.org>
Subject: Re: [PATCH 0/3] ASoC: davinci-mcasp/edma: Switch
	AM335x/43xx to edma-pcm
Date: Wed, 16 Jul 2014 16:11:48 +0200
Message-ID: <53C68824.605@zonque.org>
References: <1405512724-23628-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 5D6A62651B9
 for <alsa-devel@alsa-project.org>; Wed, 16 Jul 2014 16:12:07 +0200 (CEST)
In-Reply-To: <1405512724-23628-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, jsarha@ti.com
List-Id: alsa-devel@alsa-project.org

Hi Peter,

On 07/16/2014 02:12 PM, Peter Ujfalusi wrote:
> This series will switch the AM335x/AM43xx SoCs to use the edma-pcm as platform
> driver instead of the old davinic-pcm.
> Doing this we can benefit improvements within the dmaengine driver stack and are
> going to rely on standard interfaces towards the DMA.

FWIW, this works fine on our AM335x based custom design.


Thanks,
Daniel


> 
> Regards,
> Peter
> ---
> Peter Ujfalusi (3):
>   ASoC: edma-pcm: Remove PCM_INFO_BATCH and add
>     PCM_INFO_NO_PERIOD_WAKEUP flag
>   ASoC: edma-pcm: Add empty functions for !CONFIG_SND_EDMA_SOC builds
>   ASoC: davinci-mcasp: Use dmaengine based platform driver for
>     AM335x/447x
> 
>  sound/soc/davinci/Kconfig         | 18 ++++++++++++++----
>  sound/soc/davinci/Makefile        |  2 ++
>  sound/soc/davinci/davinci-mcasp.c | 11 +++++++++--
>  sound/soc/davinci/edma-pcm.c      |  2 +-
>  sound/soc/davinci/edma-pcm.h      |  7 +++++++
>  5 files changed, 33 insertions(+), 7 deletions(-)
> 
