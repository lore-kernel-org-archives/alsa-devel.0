Return-Path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id 4BC642607B6
 for <alsa-devel@alsa-project.org>; Wed,  6 Aug 2014 15:52:50 +0200 (CEST)
Received: from dflxv15.itg.ti.com ([128.247.5.124])
 by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id s76Dqmbx006555
 for <alsa-devel@alsa-project.org>; Wed, 6 Aug 2014 08:52:48 -0500
Received: from DLEE70.ent.ti.com (dlee70.ent.ti.com [157.170.170.113])
 by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id s76DqmOS023284
 for <alsa-devel@alsa-project.org>; Wed, 6 Aug 2014 08:52:48 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])	by
 dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id s76DqlHs026314	for
 <alsa-devel@alsa-project.org>; Wed, 6 Aug 2014 08:52:48 -0500
From: Jyri Sarha <jsarha@ti.com>
Date: Wed, 6 Aug 2014 16:52:37 +0300
Message-ID: <cover.1407332062.git.jsarha@ti.com>
MIME-Version: 1.0
Subject: [alsa-devel] [PATCH 0/9] Beaglebone-Black HDMI audio
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-ID: <alsa-devel@alsa-project.org>

The code has a functional dependency to:
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg108199.html

Without the above patch the audio card does not probe.

The code has been rebased on top of Linux 3.16 merged with 
git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
with http://www.mail-archive.com/linux-omap@vger.kernel.org/msg108199.html
cherry-picked on top.

All patches have gone trough some cleaning up since the RFC version of
these patches over half a year ago.

ps. I forgot to send these patches to alsa-devel@alsa-project.org
    first time around. The original mailing can be found here:
    http://www.mail-archive.com/linux-omap@vger.kernel.org/msg108229.html

Jyri Sarha (9):
  ASoC: mcasp: Fix implicit BLCK divider setting
  clk: add gpio controlled clock
  drm/tilcdc: Add I2S HDMI audio config for tda998x
  ASoC: davinci-evm: HDMI audio support for TDA998x trough McASP I2S
    bus
  ASoC: davinci: HDMI audio build for AM33XX and TDA998x
  ARM: dts: am33xx: Add external clock provider
  ARM: dts: am335x-boneblack: Add HDMI audio support
  ARM: OMAP2+: omap2plus_defconfig: TDA998X HDMI trough tilcdc,slave
  ARM: OMAP2+: omap2plus_defconfig: Enable BeagleBone Black HDMI audio
    support

 .../devicetree/bindings/clock/gpio-clock.txt       |   21 ++
 .../bindings/sound/davinci-evm-audio.txt           |    4 +-
 arch/arm/boot/dts/am335x-boneblack.dts             |   54 +++++
 arch/arm/boot/dts/am33xx.dtsi                      |   10 +
 arch/arm/configs/omap2plus_defconfig               |    5 +
 drivers/clk/Makefile                               |    1 +
 drivers/clk/clk-gpio.c                             |  206 ++++++++++++++++++++
 drivers/gpu/drm/tilcdc/tilcdc_slave.c              |   24 ++-
 include/linux/clk-provider.h                       |   23 +++
 sound/soc/davinci/Kconfig                          |   12 ++
 sound/soc/davinci/davinci-evm.c                    |   82 +++++++-
 sound/soc/davinci/davinci-mcasp.c                  |   14 +-
 12 files changed, 449 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/gpio-clock.txt
 create mode 100644 drivers/clk/clk-gpio.c

-- 
1.7.9.5

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
