From: Troy Kisky <troy.kisky@boundarydevices.com>
Subject: Re: [PATCH] To avoid the divide by zero error during
 the first	execution, initialize the data type.
Date: Wed, 09 Sep 2009 17:39:43 -0700
Message-ID: <4AA84ACF.508@boundarydevices.com>
References: <7A436F7769CA33409C6B44B358BFFF0C0129E88EA5@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpauth01.csee.onr.siteprotect.com
	(smtpauth01.csee.onr.siteprotect.com [64.26.60.145])
	by alsa0.perex.cz (Postfix) with ESMTP id 8C7922454B
	for <alsa-devel@alsa-project.org>;
	Thu, 10 Sep 2009 02:39:52 +0200 (CEST)
In-Reply-To: <7A436F7769CA33409C6B44B358BFFF0C0129E88EA5@dlee02.ent.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Mani, Arun" <avm@ti.com>
Cc: "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Mani, Arun wrote:
> It indeed gets initialized in the hw_params. But the runtime dma parameters are not populated with the substream private data information that is gets in hw_params for the first time. I am not sure why. Any ideas?
> 
> 
> 
> Thanks,
> Arun.
> 

The real bug is in the routine davinci_i2s_startup.

The line

	cpu_dai->dma_data = dev->dma_params[substream->stream];


This works, as long as both streams aren't open.

playback stream
davinci_i2s_startup: P0 dma_params=c03a7680
davinci_pcm_dma_request: P0 dma_data=c03a7680
^^ saves pointer

capture stream
davinci_i2s_startup: C1 dma_params=c03a769c
^^ changes cpu_dai pointer
davinci_pcm_dma_request: C1 dma_data=c03a769c
^^ saves pointer
davinci_i2s_hw_params: data_type=2 C1 dma_params=c03a769c
^^ capture data_type=2

davinci_pcm_enqueue_dma: data_type=2 C1 c03a769c
davinci_pcm_enqueue_dma: data_type=2 C1 c03a769c

playback stream
davinci_i2s_hw_params: data_type=2 P0 dma_params=c03a769c
^^ playback dma_params is WRONG should be c03a7680

davinci_pcm_enqueue_dma: data_type=0 P0 c03a7680
^^ This uses the save dma_params value, hence data_type is still 0

Division by zero in kernel.


It seems like a lot of drivers may have this bug.

Troy
