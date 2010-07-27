From: Timur Tabi <timur@freescale.com>
Subject: Re: asoc multi-component: almost there!
Date: Tue, 27 Jul 2010 16:23:52 -0500
Message-ID: <AANLkTikeAObgZsyRN-kWLERaOpICfpnjaidtOUfQhQwz@mail.gmail.com>
References: <AANLkTimKhtzu-_Sts3AkVmDhc19tOGg4dqMGzdCro=A7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 30FEF24359
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Jul 2010 23:24:23 +0200 (CEST)
Received: by iwn39 with SMTP id 39so4461933iwn.38
	for <alsa-devel@alsa-project.org>; Tue, 27 Jul 2010 14:24:22 -0700 (PDT)
In-Reply-To: <AANLkTimKhtzu-_Sts3AkVmDhc19tOGg4dqMGzdCro=A7@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel mailing list <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

Is the machine driver required to run last?  The reason I ask is that
my DMA driver is currently initialized via arch_initcall().  If I
change that to module_init(), ASOC fails to register any sound cards.

Here's the debug output with arch_initcall():

soc_bind_dai_link:1136 cpu_dai->name=e0016000.ssi,
dai_link->cpu_dai_name=e0016000.ssi
soc_bind_dai_link:1159 codec->name=cs4270-codec.0-004f,
dai_link->codec_name=cs4270-codec.0-004f
soc_bind_dai_link:1169 codec_dai->name=e0016000.ssi,
dai_link->codec_dai_name=cs4270-hifi
soc_bind_dai_link:1169 codec_dai->name=cs4270-hifi,
dai_link->codec_dai_name=cs4270-hifi
soc_bind_dai_link:1194 platform->name=e0021180.dma-channel,
dai_link->platform_name=e0021100.dma-channel
soc_bind_dai_link:1194 platform->name=e0021100.dma-channel,
dai_link->platform_name=e0021100.dma-channel
soc_bind_dai_link:1136 cpu_dai->name=e0016000.ssi,
dai_link->cpu_dai_name=e0016000.ssi
soc_bind_dai_link:1159 codec->name=cs4270-codec.0-004f,
dai_link->codec_name=cs4270-codec.0-004f
soc_bind_dai_link:1169 codec_dai->name=e0016000.ssi,
dai_link->codec_dai_name=cs4270-hifi
soc_bind_dai_link:1169 codec_dai->name=cs4270-hifi,
dai_link->codec_dai_name=cs4270-hifi
soc_bind_dai_link:1194 platform->name=e0021180.dma-channel,
dai_link->platform_name=e0021180.dma-channel
asoc: cs4270-hifi <-> e0016000.ssi mapping ok
asoc: cs4270-hifi <-> e0016000.ssi mapping ok
mpc8610_hpcd_probe:516
ALSA device list:
  #0: MPC8610 HPCD

And here it is with module_init():

soc_bind_dai_link:1136 cpu_dai->name=e0016000.ssi,
dai_link->cpu_dai_name=e0016000.ssi
soc_bind_dai_link:1159 codec->name=cs4270-codec.0-004f,
dai_link->codec_name=cs4270-codec.0-004f
soc_bind_dai_link:1169 codec_dai->name=e0016000.ssi,
dai_link->codec_dai_name=cs4270-hifi
soc_bind_dai_link:1169 codec_dai->name=cs4270-hifi,
dai_link->codec_dai_name=cs4270-hifi
soc_bind_dai_link:1136 cpu_dai->name=e0016000.ssi,
dai_link->cpu_dai_name=e0016000.ssi
soc_bind_dai_link:1159 codec->name=cs4270-codec.0-004f,
dai_link->codec_name=cs4270-codec.0-004f
soc_bind_dai_link:1169 codec_dai->name=e0016000.ssi,
dai_link->codec_dai_name=cs4270-hifi
soc_bind_dai_link:1169 codec_dai->name=cs4270-hifi,
dai_link->codec_dai_name=cs4270-hifi
mpc8610_hpcd_probe:516
Freescale Elo DMA ASoC PCM Driver
fsl_soc_dma_probe:852
soc_bind_dai_link:1194 platform->name=e0021100.dma-channel,
dai_link->platform_name=e0021100.dma-channel
soc_bind_dai_link:1194 platform->name=e0021100.dma-channel,
dai_link->platform_name=e0021180.dma-channel
fsl_soc_dma_probe:852
soc_bind_dai_link:1194 platform->name=e0021180.dma-channel,
dai_link->platform_name=e0021180.dma-channel
ALSA device list:
  No soundcards found.

-- 
Timur Tabi
Linux kernel developer at Freescale
