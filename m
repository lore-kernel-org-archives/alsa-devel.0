From: Timur Tabi <timur@freescale.com>
Subject: Re: asoc multi-component: CPU DAI name is wrong
Date: Mon, 26 Jul 2010 13:57:46 -0500
Message-ID: <4C4DDAAA.1000005@freescale.com>
References: <4C48BEBA.8080207@freescale.com> <1279908983.3076.8.camel@odin>
	<4C49E5C7.8020500@freescale.com> <1279964567.3097.5.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from DB3EHSOBE005.bigfish.com (db3ehsobe005.messaging.microsoft.com
	[213.199.154.143])
	by alsa0.perex.cz (Postfix) with ESMTP id 96FBD247E9
	for <alsa-devel@alsa-project.org>;
	Mon, 26 Jul 2010 20:58:07 +0200 (CEST)
Received: from mail19-db3 (localhost.localdomain [127.0.0.1])	by
	mail19-db3-R.bigfish.com (Postfix) with ESMTP id EB49716E0160	for
	<alsa-devel@alsa-project.org>; Mon, 26 Jul 2010 18:58:02 +0000 (UTC)
Received: from DB3EHSMHS001.bigfish.com (unknown [10.3.81.242])	by
	mail19-db3.bigfish.com (Postfix) with ESMTP id 478071448061	for
	<alsa-devel@alsa-project.org>; Mon, 26 Jul 2010 18:58:02 +0000 (UTC)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP id
	o6QIvm9n004673	for
	<alsa-devel@alsa-project.org>; Mon, 26 Jul 2010 11:57:58 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id
	o6QJB8Js011640	for <alsa-devel@alsa-project.org>;
	Mon, 26 Jul 2010 14:11:08 -0500 (CDT)
In-Reply-To: <1279964567.3097.5.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: ALSA development <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Liam Girdwood wrote:
> On Fri, 2010-07-23 at 13:56 -0500, Timur Tabi wrote:
>> Liam Girdwood wrote:
>> > My mistake, I'd missed something in the forward port. I've fixed the DAI
>> > naming problem and you should see your DAI use the correct name.
>>
>> Looks like you forgot something:
>>
>>   CC      sound/soc/soc-core.o
>> sound/soc/soc-core.c: In function 'snd_soc_register_dai':
>> sound/soc/soc-core.c:2872: error: 'struct snd_soc_dai' has no member
> named 'id'
>> sound/soc/soc-core.c: In function 'snd_soc_register_dais':
>> sound/soc/soc-core.c:2949: error: 'struct snd_soc_dai' has no member
> named 'id'
>> sound/soc/soc-core.c: In function 'snd_soc_register_platform':
>> sound/soc/soc-core.c:3004: error: 'struct snd_soc_platform' has no member
>> named 'id'
>> sound/soc/soc-core.c: In function 'snd_soc_register_codec':
>> sound/soc/soc-core.c:3102: error: 'struct snd_soc_codec' has no member
> named
>> 'id'
>> make[2]: *** [sound/soc/soc-core.o] Error 1
>> make[1]: *** [sound/soc] Error 2
>> make: *** [sound] Error 2
>>
> 
> Sorry, now fixed. Sound had somehow been disabled in my upstream .config
> and hence would build kernels.

I'm still seeing the problem:

fsl_ssi_probe:658 cpu_dai_drv.name=ssi@16000
fsl_ssi_probe:713 name=snd-soc-mpc8610hpcd
mpc8610_hpcd_probe:312 cpu_dai_name=ssi@16000
soc_bind_dai_link:1136 cpu_dai->name=e0016000.ssi,
dai_link->cpu_dai_name=ssi@16000
soc_bind_dai_link:1136 cpu_dai->name=cs4270-hifi,
dai_link->cpu_dai_name=ssi@16000
soc_bind_dai_link:1159 codec->name=cs4270-codec.0-004f,
dai_link->codec_name=cs4270-codec
soc_bind_dai_link:1194 platform->name=e0021180.dma-channel,
dai_link->platform_name=/soc@e0000000/dma@21300/dma-channel@0
soc_bind_dai_link:1194 platform->name=e0021100.dma-channel,
dai_link->platform_name=/soc@e0000000/dma@21300/dma-channel@0
soc_bind_dai_link:1136 cpu_dai->name=e0016000.ssi,
dai_link->cpu_dai_name=ssi@16000
soc_bind_dai_link:1136 cpu_dai->name=cs4270-hifi,
dai_link->cpu_dai_name=ssi@16000
soc_bind_dai_link:1159 codec->name=cs4270-codec.0-004f,
dai_link->codec_name=cs4270-codec
soc_bind_dai_link:1194 platform->name=e0021180.dma-channel,
dai_link->platform_name=/soc@e0000000/dma@21300/dma-channel@1
soc_bind_dai_link:1194 platform->name=e0021100.dma-channel,
dai_link->platform_name=/soc@e0000000/dma@21300/dma-channel@1
ALSA device list:
  No soundcards found.

Here's the code that sets the CPU DAI name (in fsl_ssi.c):

        /* The DAI name is the last part of the full name of the node. */
	p = strrchr(np->full_name, '/') + 1;
	ssi_private = kzalloc(sizeof(struct fsl_ssi_private) + strlen(p),
			      GFP_KERNEL);
	if (!ssi_private) {
		dev_err(&of_dev->dev, "could not allocate DAI object\n");
		return -ENOMEM;
	}

	strcpy(ssi_private->name, p);

	/* Initialize this copy of the CPU DAI driver structure */
	memcpy(&ssi_private->cpu_dai_drv, &fsl_ssi_dai_template,
	       sizeof(fsl_ssi_dai_template));
	ssi_private->cpu_dai_drv.name = ssi_private->name;
	printk(KERN_INFO "%s:%u cpu_dai_drv.name=%s\n", __func__, __LINE__,
ssi_private->cpu_dai_drv.name);

...

	ret = snd_soc_register_dai(&of_dev->dev, &ssi_private->cpu_dai_drv);

You can see above that cpu_dai_drv.name is set to "ssi@16000", but when
soc_bind_dai_link() looks for it, cpu_dai->name is set to "e0016000.ssi".  I
don't know where that string comes from, but it's not coming from my code.
