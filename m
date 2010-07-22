From: Timur Tabi <timur@freescale.com>
Subject: asoc multi-component: CPU DAI name is wrong
Date: Thu, 22 Jul 2010 16:57:14 -0500
Message-ID: <4C48BEBA.8080207@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from TX2EHSOBE007.bigfish.com (tx2ehsobe004.messaging.microsoft.com
	[65.55.88.14]) by alsa0.perex.cz (Postfix) with ESMTP id B5BFB10380D
	for <alsa-devel@alsa-project.org>;
	Thu, 22 Jul 2010 23:57:30 +0200 (CEST)
Received: from mail143-tx2 (localhost.localdomain [127.0.0.1])	by
	mail143-tx2-R.bigfish.com (Postfix) with ESMTP id C80461620336	for
	<alsa-devel@alsa-project.org>; Thu, 22 Jul 2010 21:57:27 +0000 (UTC)
Received: from TX2EHSMHS042.bigfish.com (unknown [10.9.14.248])	by
	mail143-tx2.bigfish.com (Postfix) with ESMTP id 68ECEAE0052	for
	<alsa-devel@alsa-project.org>; Thu, 22 Jul 2010 21:57:27 +0000 (UTC)
Received: from az33smr01.freescale.net (az33smr01.freescale.net
	[10.64.34.199])	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP
	id o6MLvFta023049	for <alsa-devel@alsa-project.org>;
	Thu, 22 Jul 2010 14:57:26 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
	o6MM8Cbo006988	for <alsa-devel@alsa-project.org>;
	Thu, 22 Jul 2010 17:08:13 -0500 (CDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Liam,

I have this in my machine driver:

machine_data->dai[0].cpu_dai_name = strrchr(np->full_name, '/') + 1;
printk(KERN_INFO "%s:%u cpu_dai_name=%s\n", __func__, __LINE__,
machine_data->dai[0].cpu_dai_name);
...
platform_set_drvdata(sound_device, &machine_data->card);
ret = platform_device_add(sound_device);

which displays this message:

mpc8610_hpcd_probe:316 cpu_dai_name=ssi@16000

So my machine driver says the CPU DAI name is "ssi@16000", and my CPU driver
does the same thing.  However, I put some printks in soc_bind_dai_link, and
this is what I see:

soc_bind_dai_link:1136 cpu_dai->name=e0016000.ssi
dai_link->cpu_dai_name=ssi@16000
soc_bind_dai_link:1136 cpu_dai->name=cs4270-hifi
dai_link->cpu_dai_name=ssi@16000
soc_bind_dai_link:1159 codec->name=0-004f
dai_link->codec_name=cs4270-codec.0-004f
soc_bind_dai_link:1193 platform->name=e0021180.dma-channel
dai_link->platform_name=/soc@e0000000/dma@21300/dma-channel@0
soc_bind_dai_link:1193 platform->name=e0021100.dma-channel
dai_link->platform_name=/soc@e0000000/dma@21300/dma-channel@0
soc_bind_dai_link:1136 cpu_dai->name=e0016000.ssi
dai_link->cpu_dai_name=ssi@16000
soc_bind_dai_link:1136 cpu_dai->name=cs4270-hifi
dai_link->cpu_dai_name=ssi@16000
soc_bind_dai_link:1159 codec->name=0-004f
dai_link->codec_name=cs4270-codec.0-004f
soc_bind_dai_link:1193 platform->name=e0021180.dma-channel
dai_link->platform_name=/soc@e0000000/dma@21300/dma-channel@1
soc_bind_dai_link:1193 platform->name=e0021100.dma-channel
dai_link->platform_name=/soc@e0000000/dma@21300/dma-channel@1

Where in the world is "e0016000.ssi" coming from?  Why is ASoC ignoring my
.cpu_dai_name value?
