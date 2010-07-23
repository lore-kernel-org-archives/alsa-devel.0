From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: asoc multi-component: CPU DAI name is wrong
Date: Fri, 23 Jul 2010 19:16:23 +0100
Message-ID: <1279908983.3076.8.camel@odin>
References: <4C48BEBA.8080207@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 7A8D51039D4
	for <alsa-devel@alsa-project.org>;
	Fri, 23 Jul 2010 20:16:30 +0200 (CEST)
Received: by wyb42 with SMTP id 42so475015wyb.38
	for <alsa-devel@alsa-project.org>; Fri, 23 Jul 2010 11:16:30 -0700 (PDT)
In-Reply-To: <4C48BEBA.8080207@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: ALSA development <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 2010-07-22 at 16:57 -0500, Timur Tabi wrote:
> Liam,
> 
> I have this in my machine driver:
> 
> machine_data->dai[0].cpu_dai_name = strrchr(np->full_name, '/') + 1;
> printk(KERN_INFO "%s:%u cpu_dai_name=%s\n", __func__, __LINE__,
> machine_data->dai[0].cpu_dai_name);
> ...
> platform_set_drvdata(sound_device, &machine_data->card);
> ret = platform_device_add(sound_device);
> 
> which displays this message:
> 
> mpc8610_hpcd_probe:316 cpu_dai_name=ssi@16000
> 
> So my machine driver says the CPU DAI name is "ssi@16000", and my CPU driver
> does the same thing.  However, I put some printks in soc_bind_dai_link, and
> this is what I see:
> 
> soc_bind_dai_link:1136 cpu_dai->name=e0016000.ssi
> dai_link->cpu_dai_name=ssi@16000
> soc_bind_dai_link:1136 cpu_dai->name=cs4270-hifi
> dai_link->cpu_dai_name=ssi@16000
> soc_bind_dai_link:1159 codec->name=0-004f
> dai_link->codec_name=cs4270-codec.0-004f
> soc_bind_dai_link:1193 platform->name=e0021180.dma-channel
> dai_link->platform_name=/soc@e0000000/dma@21300/dma-channel@0
> soc_bind_dai_link:1193 platform->name=e0021100.dma-channel
> dai_link->platform_name=/soc@e0000000/dma@21300/dma-channel@0
> soc_bind_dai_link:1136 cpu_dai->name=e0016000.ssi
> dai_link->cpu_dai_name=ssi@16000
> soc_bind_dai_link:1136 cpu_dai->name=cs4270-hifi
> dai_link->cpu_dai_name=ssi@16000
> soc_bind_dai_link:1159 codec->name=0-004f
> dai_link->codec_name=cs4270-codec.0-004f
> soc_bind_dai_link:1193 platform->name=e0021180.dma-channel
> dai_link->platform_name=/soc@e0000000/dma@21300/dma-channel@1
> soc_bind_dai_link:1193 platform->name=e0021100.dma-channel
> dai_link->platform_name=/soc@e0000000/dma@21300/dma-channel@1
> 
> Where in the world is "e0016000.ssi" coming from?  Why is ASoC ignoring my
> .cpu_dai_name value?
> 

My mistake, I'd missed something in the forward port. I've fixed the DAI
naming problem and you should see your DAI use the correct name.

Give kernel.org about 30 mins to sync before pulling.

Thanks

Liam  
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
