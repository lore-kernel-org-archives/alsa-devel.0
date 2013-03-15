From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] SoC: dma-sh7760: Fix compile error
Date: Fri, 15 Mar 2013 11:44:51 +0100
Message-ID: <5142FBA3.8070600@metafoo.de>
References: <1363343175-14744-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-220.synserver.de (smtp-out-220.synserver.de
 [212.40.185.220])
 by alsa0.perex.cz (Postfix) with ESMTP id 1F065262629
 for <alsa-devel@alsa-project.org>; Fri, 15 Mar 2013 11:42:53 +0100 (CET)
In-Reply-To: <1363343175-14744-1-git-send-email-lars@metafoo.de>
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
Cc: Manuel Lauss <manuel.lauss@gmail.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Sorry for the hiccup in patch subject, the prefix should have of course been
"ASoC"

On 03/15/2013 11:26 AM, Lars-Peter Clausen wrote:
> The dma-sh7760 currently fails with the following compile error:
> 	sound/soc/sh/dma-sh7760.c:346:2: error: unknown field 'pcm_ops' specified in initializer
> 	sound/soc/sh/dma-sh7760.c:346:2: warning: initialization from incompatible pointer type
> 	sound/soc/sh/dma-sh7760.c:347:2: error: unknown field 'pcm_new' specified in initializer
> 	sound/soc/sh/dma-sh7760.c:347:2: warning: initialization makes integer from pointer without a cast
> 	sound/soc/sh/dma-sh7760.c:348:2: error: unknown field 'pcm_free' specified in initializer
> 	sound/soc/sh/dma-sh7760.c:348:2: warning: initialization from incompatible pointer type
> 	sound/soc/sh/dma-sh7760.c: In function 'sh7760_soc_platform_probe':
> 	sound/soc/sh/dma-sh7760.c:353:2: warning: passing argument 2 of 'snd_soc_register_platform' from incompatible pointer type
> 	include/sound/soc.h:368:5: note: expected 'struct snd_soc_platform_driver *' but argument is of type 'struct snd_soc_platform *'
> 
> This is due the misnaming of the snd_soc_platform_driver type name and 'ops'
> field. The issue was introduced in commit f0fba2a("ASoC: multi-component - ASoC
> Multi-Component Support").
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
