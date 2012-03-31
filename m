From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 1/1] ASoC: soc-dmaengine-pcm: fix compile
 error	since dma api is changed
Date: Sat, 31 Mar 2012 13:33:33 +0200
Message-ID: <4F76EB8D.2060200@metafoo.de>
References: <1333197468-3263-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailhost.informatik.uni-hamburg.de
	(mailhost.informatik.uni-hamburg.de [134.100.9.70])
	by alsa0.perex.cz (Postfix) with ESMTP id 9452D244EA
	for <alsa-devel@alsa-project.org>;
	Sat, 31 Mar 2012 14:33:12 +0200 (CEST)
In-Reply-To: <1333197468-3263-1-git-send-email-b29396@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dong Aisheng <b29396@freescale.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On 03/31/2012 02:37 PM, Dong Aisheng wrote:
> From: Dong Aisheng <dong.aisheng@linaro.org>
> 
> The following compiling error is caused by the API device_prep_dma_cyclic
> is changed. Using dmaengine_prep_dma_cyclic to fix it.
> 
> sound/soc/soc-dmaengine-pcm.c: In function 'dmaengine_pcm_prepare_and_submit':
> sound/soc/soc-dmaengine-pcm.c:149: error: too few arguments to function 'chan->device->device_prep_dma_cyclic'
> make[2]: *** [sound/soc/soc-dmaengine-pcm.o] Error 1
> make[1]: *** [sound/soc] Error 2
> make: *** [sound] Error 2
> 

Hi,

There is already a fix for this in Mark's for-3.4 branch.
