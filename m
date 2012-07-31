From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 01/19] Configure ux500 Audio Drivers for Device
	Tree
Date: Tue, 31 Jul 2012 14:38:54 +0100
Message-ID: <1343741953-17828-1-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f173.google.com (mail-wi0-f173.google.com
 [209.85.212.173])
 by alsa0.perex.cz (Postfix) with ESMTP id 44BA6264EFB
 for <alsa-devel@alsa-project.org>; Tue, 31 Jul 2012 15:39:20 +0200 (CEST)
Received: by wibhm6 with SMTP id hm6so2372350wib.2
 for <alsa-devel@alsa-project.org>; Tue, 31 Jul 2012 06:39:22 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, olalilja@yahoo.se, ola.o.lilja@stericsson.com, alsa-devel@alsa-project.org, lrg@ti.com, broonie@opensource.wolfsonmicro.com
Cc: STEricsson_nomadik_linux@list.st.com, linus.walleij@stericsson.com, arnd@arndb.de
List-Id: alsa-devel@alsa-project.org

This patch-set sees many of the ux500 related Audio drivers gain
Device Tree enablement. There are also some fixes to issues which
where encountered along the way.

 Documentation/devicetree/bindings/mfd/ab8500.txt   |   15 +
 .../devicetree/bindings/sound/ux500-mop500.txt     |   39 ++
 .../devicetree/bindings/sound/ux500-msp.txt        |   43 ++
 arch/arm/boot/dts/db8500.dtsi                      |  597 ------------------
 arch/arm/boot/dts/dbx5x0.dtsi                      |  636 ++++++++++++++++++++
 arch/arm/boot/dts/snowball.dts                     |   18 +-
 arch/arm/mach-ux500/Makefile                       |    2 +-
 arch/arm/mach-ux500/board-mop500-audio.c           |  189 ++++++
 arch/arm/mach-ux500/board-mop500-msp.c             |  267 --------
 arch/arm/mach-ux500/board-mop500-msp.h             |   14 -
 arch/arm/mach-ux500/board-mop500.c                 |   22 +-
 arch/arm/mach-ux500/board-mop500.h                 |    6 +
 arch/arm/mach-ux500/include/mach/msp.h             |    2 -
 include/linux/mfd/abx500/ab8500-codec.h            |    6 +-
 sound/soc/codecs/ab8500-codec.c                    |   81 +++
 sound/soc/ux500/mop500.c                           |   42 +-
 sound/soc/ux500/ux500_msp_dai.c                    |   20 +-
 sound/soc/ux500/ux500_msp_i2s.c                    |   97 ++-
 sound/soc/ux500/ux500_msp_i2s.h                    |    2 -
 sound/soc/ux500/ux500_pcm.c                        |   19 +-
 sound/soc/ux500/ux500_pcm.h                        |    3 +
 21 files changed, 1189 insertions(+), 931 deletions(-)
