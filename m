From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: Re: [ASoC]Changing the order of trigger in
	soc_pcm_trigger
Date: Wed, 06 Jun 2007 14:24:06 +0100
Message-ID: <1181136246.13316.11.camel@a10072.wolfsonmicro.main>
References: <8d6898730706060606ree4bb6ahf8b4fd0b07453408@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (unknown [80.75.67.54])
	by alsa0.perex.cz (Postfix) with ESMTP id 81C4A24493
	for <alsa-devel@alsa-project.org>;
	Wed,  6 Jun 2007 15:24:08 +0200 (CEST)
In-Reply-To: <8d6898730706060606ree4bb6ahf8b4fd0b07453408@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Nobin Mathew <nobin.mathew@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2007-06-06 at 18:36 +0530, Nobin Mathew wrote:
> Liam,
> 
> I have one suggestion.
> 
> Can we use this
> 
> if (rtd->codec_dai->ops.trigger) {
> 		ret = rtd->codec_dai->ops.trigger(substream, cmd);
> 		if (ret < 0)
> 			return ret;
> 	}
> 
> if (rtd->cpu_dai->ops.trigger) {
> 	ret = rtd->cpu_dai->ops.trigger(substream, cmd);
> 	if (ret < 0)
> 		return ret;
> }
> if (platform->pcm_ops->trigger) {
> 	ret = platform->pcm_ops->trigger(substream, cmd);
> 	if (ret < 0)
> 		return ret;
> }
> 
> Instead of
> 
> if (rtd->codec_dai->ops.trigger) {
> 		ret = rtd->codec_dai->ops.trigger(substream, cmd);
> 		if (ret < 0)
> 			return ret;
> 	}
> 
> if (platform->pcm_ops->trigger) {
> 	ret = platform->pcm_ops->trigger(substream, cmd);
> 	if (ret < 0)
> 		return ret;
> }
> 
> if (rtd->cpu_dai->ops.trigger) {
> 	ret = rtd->cpu_dai->ops.trigger(substream, cmd);
> 	if (ret < 0)
> 		return ret;
> }
> 
> 
> That means trigger the Cpu before pcm. Because most of the controllers
> needs to be initialized and triggered before external DMA is
> triggered.
> 
> Correct me if i am going wrong.


The current ordering allows the DMA to trigger before the I2S/PCM
controller triggers. This means that the DMA should be ready before the
controller generates any FIFO DMA interrupt requests. Fwiw, this seems
to work well on most machines atm. 

> This was causing so many problems in my hardware.

What sort of problems. Underruns ? What does your trigger do in each
case ?

Is it possible to set some of your controller up in prepare() and then
hit it's enable bit in trigger ?

Liam
