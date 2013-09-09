From: <oku@iki.fi>
Subject: [PATCH RFC 0/8] Fix AM335x-evm analog audio support
Date: Mon, 9 Sep 2013 18:12:11 +0300
Message-ID: <cover.1378738436.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id 241B92650A0
 for <alsa-devel@alsa-project.org>; Mon,  9 Sep 2013 17:12:22 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: liam.r.girdwood@linux.intel.com, devicetree-discuss@lists.ozlabs.org, broonie@kernel.org, Jyri Sarha <jsarha@ti.com>
List-Id: alsa-devel@alsa-project.org

From: Jyri Sarha <jsarha@ti.com>

This set of patches fixes the basic audio support for am335x-evm. It
should also be relatively simple to add the necessary nodes to
relevant dts files to get BeagleBone + AudioCape and am335x-evmsk
working too.

The patch set depends on following patches:

[PATCH v2] ARM: dts: add AM33XX EDMA support 
     https://lkml.org/lkml/2013/8/26/57 

[PATCH v11 5/8] ARM: dts: add AM33XX SPI DMA support
     https://lkml.org/lkml/2013/6/18/55

[PATCH v2] ARM: EDMA: Fix clearing of unused list for DT DMA resources
     https://lkml.org/lkml/2013/7/22/441

I have tried my best not to break the existing support for older
davinci boards, but since I do not have those boards I can not be
sure.

Some commit comments refer to a dmaengine based davinci audio
implementation which is planned for but nothing has been done yet.

Best regards,
Jyri

Darren Etheridge (1):
  ARM/dts: am335x-evm: Add audio support for am335x-evm.dts

Hebbar, Gururaja (2):
  ASoC: davinci-evm: Add device tree binding
  ASoC: davinci: Add support for AM33xx SoC Audio

Joel A Fernandes (1):
  ASoC: davinci-mcasp: Add pinctrl support

Jyri Sarha (3):
  ASoC: davinci-mcasp: Get DMA related properties from DT
  ASoC: davinci-mcasp: Extract DMA channels directly from DT
  ARM/dts: am33xx: mcasp: Add new dma related properties

Pantelis Antoniou (1):
  ARM/dts: am33xx: Add mcasp0 and mcasp1 device tree entries

 .../bindings/sound/davinci-evm-audio.txt           |   53 ++++++
 .../bindings/sound/davinci-mcasp-audio.txt         |   13 +-
 arch/arm/boot/dts/am335x-evm.dts                   |   56 ++++++
 arch/arm/boot/dts/am33xx.dtsi                      |   35 ++++
 include/linux/platform_data/davinci_asp.h          |    2 +
 sound/soc/davinci/Kconfig                          |    8 +
 sound/soc/davinci/Makefile                         |    3 +
 sound/soc/davinci/davinci-evm.c                    |  181 +++++++++++++++++---
 sound/soc/davinci/davinci-mcasp.c                  |   82 +++++++--
 9 files changed, 391 insertions(+), 42 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/davinci-evm-audio.txt

-- 
1.7.9.5
