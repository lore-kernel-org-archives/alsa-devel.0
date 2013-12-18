From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: mmp-pcm: config pcm slave via
 generic dmaengine
Date: Wed, 18 Dec 2013 10:16:36 +0100
Message-ID: <52B167F4.1080806@metafoo.de>
References: <1387268544-31222-1-git-send-email-zhouqiao@marvell.com>
 <20131217124954.GY3185@sirena.org.uk> <52B062EC.2050605@metafoo.de>
 <52B138CE.3000800@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-044.synserver.de (smtp-out-038.synserver.de
 [212.40.185.38])
 by alsa0.perex.cz (Postfix) with ESMTP id A12FE2651A3
 for <alsa-devel@alsa-project.org>; Wed, 18 Dec 2013 11:15:39 +0100 (CET)
In-Reply-To: <52B138CE.3000800@marvell.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Qiao Zhou <zhouqiao@marvell.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "haojian.zhuang@gmail.com" <haojian.zhuang@gmail.com>, Mark Brown <broonie@kernel.org>, "zhangfei.gao@gmail.com" <zhangfei.gao@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 12/18/2013 06:55 AM, Qiao Zhou wrote:
> On 12/17/2013 10:42 PM, Lars-Peter Clausen wrote:
>> On 12/17/2013 01:49 PM, Mark Brown wrote:
>>> On Tue, Dec 17, 2013 at 04:22:24PM +0800, Qiao Zhou wrote:
>>>> use snd_dmaengine_pcm_prepare_slave_config to set slave config,
>>>> and remove the max_burst_size = 4 hard code.
>>>>
>>>> select SND_SOC_GENERIC_DMAENGINE_PCM for mmp-pcm.
>>>
>>> Applied, thanks.  Can you also convert to use snd_dmaengine_pcm_register()
>>> and remove this file completely?
>>>
>>
>> The problem here is that the driver uses sram for its audio memory and the
>> platform has a custom function for looking up the sram pool. What we really
>> need is a generic version of that which we can use in memalloc.c in the core.
>>
>> - Lars
>>
> I'll check the general memalloc implementation. Thanks.
> 

It's a bit dirty but if nobody has any strong objections we could add the
following temporary hack until there is a generic method for looking up
genpools. This would allow us to cut down mmp-pcm.c quite a bit by switching
it over to the generic dmaengine PCM driver.


--- a/sound/core/memalloc.c
+++ b/sound/core/memalloc.c
@@ -178,6 +178,15 @@ static void snd_malloc_dev_iram(struct snd_dma_buffer
*dmab, size_t size)
 	if (dev->of_node)
 		pool = of_get_named_gen_pool(dev->of_node, "iram", 0);

+#ifdef CONFIG_CPU_MMP2
+	/*
+	 * Temporary hack until we have a generic gen_pool lookup
+	 * infrastructure.
+	 */
+	if (!pool)
+		pool = sram_get_gpool("asram");
+#endif
+
 	if (!pool)
 		return;
