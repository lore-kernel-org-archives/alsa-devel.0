From: =?ISO-8859-1?Q?P=E9ter_Ujfalusi?= <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: dmaengine: Correct Makefile when
 sound is built as module
Date: Tue, 09 Oct 2012 15:16:15 +0200
Message-ID: <5074239F.9050302@ti.com>
References: <1349083766-17076-1-git-send-email-peter.ujfalusi@ti.com>
 <20121009065836.GT8237@opensource.wolfsonmicro.com> <5073E93F.7090507@ti.com>
 <20121009090857.GD8237@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog128.obsmtp.com (na3sys009aog128.obsmtp.com
 [74.125.149.141])
 by alsa0.perex.cz (Postfix) with ESMTP id 16102261669
 for <alsa-devel@alsa-project.org>; Tue,  9 Oct 2012 15:10:41 +0200 (CEST)
Received: by mail-ob0-f179.google.com with SMTP id lz20so4498983obb.38
 for <alsa-devel@alsa-project.org>; Tue, 09 Oct 2012 06:14:47 -0700 (PDT)
In-Reply-To: <20121009090857.GD8237@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On 10/09/2012 11:08 AM, Mark Brown wrote:
> What makes you believe that this is due to the code not being part of
> the core module?

the linker tells me.
Without this patch with mainline kernel from today (I used tegra to see if =
it
happens there as well):

make tegra_defconfig
scripts/config -d CONFIG_MMC # MMC does not compile for tegra
scripts/config -e CONFIG_SOUND -e CONFIG_SND -e CONFIG_SND_SOC

Fine

scripts/config -e CONFIG_SOUND -e CONFIG_SND -m CONFIG_SND_SOC

sound/built-in.o: In function `dmaengine_pcm_dma_complete':
/home/ujfalusi/work/kernel/kernel.org-torvalds-linux-2.6/sound/soc/soc-dmae=
ngine-pcm.c:134:
undefined reference to `snd_pcm_period_elapsed'
sound/built-in.o: In function `snd_dmaengine_pcm_open':
/home/ujfalusi/work/kernel/kernel.org-torvalds-linux-2.6/sound/soc/soc-dmae=
ngine-pcm.c:285:
undefined reference to `snd_pcm_hw_constraint_integer'
make: *** [vmlinux] Error 1

scripts/config -e CONFIG_SOUND -m CONFIG_SND -m CONFIG_SND_SOC
scripts/config -m CONFIG_SOUND -m CONFIG_SND -m CONFIG_SND_SOC

ERROR: "snd_hwparams_to_dma_slave_config"
[sound/soc/tegra/snd-soc-tegra-pcm.ko] undefined!
ERROR: "snd_dmaengine_pcm_pointer" [sound/soc/tegra/snd-soc-tegra-pcm.ko]
undefined!
ERROR: "snd_dmaengine_pcm_open" [sound/soc/tegra/snd-soc-tegra-pcm.ko] unde=
fined!
ERROR: "snd_dmaengine_pcm_close" [sound/soc/tegra/snd-soc-tegra-pcm.ko] und=
efined!
ERROR: "snd_dmaengine_pcm_get_chan" [sound/soc/tegra/snd-soc-tegra-pcm.ko]
undefined!
ERROR: "snd_dmaengine_pcm_trigger" [sound/soc/tegra/snd-soc-tegra-pcm.ko]
undefined!
make[1]: *** [__modpost] Error 1
make: *** [modules] Error 2
make: *** Waiting for unfinished jobs....

With the patch:

make tegra_defconfig
scripts/config -d CONFIG_MMC # MMC does not compile for tegra
scripts/config -e CONFIG_SOUND -e CONFIG_SND -e CONFIG_SND_SOC
scripts/config -e CONFIG_SOUND -e CONFIG_SND -m CONFIG_SND_SOC
scripts/config -e CONFIG_SOUND -m CONFIG_SND -m CONFIG_SND_SOC
scripts/config -m CONFIG_SOUND -m CONFIG_SND -m CONFIG_SND_SOC

is fine.

I guess it was due to the Kconfig/Makefile related to soc-dmaengine:

config SND_SOC_DMAENGINE_PCM
	bool

snd-soc-dmaengine-pcm-objs :=3D soc-dmaengine-pcm.o
obj-$(CONFIG_SND_SOC_DMAENGINE_PCM) +=3D snd-soc-dmaengine-pcm.o

My guess is that in this way the soc-dmaengine-pcm.o would want itself to be
built in to the kernel but since the sound is in modules there is no place =
to
link this part of the code.
If I change the Kconfig from bool to tristate it will build
snd-soc-dmaengine-pcm.ko but since the soc-dmaengine-pcm.c does not have
module_init it is not really going to load.
I might be wrong.

-- =

P=E9ter
