From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: mmp-pcm: config pcm slave via
 generic dmaengine
Date: Tue, 17 Dec 2013 15:42:52 +0100
Message-ID: <52B062EC.2050605@metafoo.de>
References: <1387268544-31222-1-git-send-email-zhouqiao@marvell.com>
 <20131217124954.GY3185@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-044.synserver.de (smtp-out-201.synserver.de
 [212.40.185.201])
 by alsa0.perex.cz (Postfix) with ESMTP id 3AD85265114
 for <alsa-devel@alsa-project.org>; Tue, 17 Dec 2013 16:41:54 +0100 (CET)
In-Reply-To: <20131217124954.GY3185@sirena.org.uk>
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
Cc: haojian.zhuang@gmail.com, Qiao Zhou <zhouqiao@marvell.com>, alsa-devel@alsa-project.org, zhangfei.gao@gmail.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On 12/17/2013 01:49 PM, Mark Brown wrote:
> On Tue, Dec 17, 2013 at 04:22:24PM +0800, Qiao Zhou wrote:
>> use snd_dmaengine_pcm_prepare_slave_config to set slave config,
>> and remove the max_burst_size = 4 hard code.
>>
>> select SND_SOC_GENERIC_DMAENGINE_PCM for mmp-pcm.
> 
> Applied, thanks.  Can you also convert to use snd_dmaengine_pcm_register() 
> and remove this file completely?
> 

The problem here is that the driver uses sram for its audio memory and the
platform has a custom function for looking up the sram pool. What we really
need is a generic version of that which we can use in memalloc.c in the core.

- Lars
