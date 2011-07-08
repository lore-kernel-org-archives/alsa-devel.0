From: Dong Aisheng <b29396@freescale.com>
Subject: [PATCH 00/10] ARM: mxs: add audio support
Date: Fri, 8 Jul 2011 23:59:40 +0800
Message-ID: <1310140790-2132-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: alsa-devel@alsa-project.org
Cc: s.hauer@pengutronix.de, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

This patch series is to add audio support based on saif for mxs platform.
The driver only supports playback currently.
For capturing, due to hardware limitation that we have to use two saif
instances to implement full duplex (playback & recording), we need to
figure out a good design to fit in ASoC as the following work.

In addition, we simply just support master mode since saif tx can
only work in master mode due to hw limitation(rx can work in both
master & slave mode).

Dong Aisheng (10):
  ASoc: mxs: add mxs-pcm driver
  ASoc: mxs: add mxs-saif driver
  ASoc: mxs: add mxs-sgtl5000 machine driver
  ASoc: mxs: add asoc configuration files
  ARM: mxs: add saif clock
  ARM: mxs: add saif device
  ARM: mxs: add sgtl5000 i2c device
  ARM: mxs: add mxs-sgtl5000 device
  ARM: mxs: correct the using of frac div for saif
  ARM: mxs-dma: include <linux/dmaengine.h>

 arch/arm/mach-mxs/Kconfig                       |    1 +
 arch/arm/mach-mxs/clock-mx28.c                  |    8 +-
 arch/arm/mach-mxs/devices-mx28.h                |    7 +
 arch/arm/mach-mxs/devices/Kconfig               |    3 +
 arch/arm/mach-mxs/devices/Makefile              |    1 +
 arch/arm/mach-mxs/devices/platform-mxs-saif.c   |   60 +++
 arch/arm/mach-mxs/include/mach/audio.h          |   18 +
 arch/arm/mach-mxs/include/mach/devices-common.h |   12 +
 arch/arm/mach-mxs/include/mach/dma.h            |    2 +
 arch/arm/mach-mxs/mach-mx28evk.c                |   39 ++
 sound/soc/Kconfig                               |    1 +
 sound/soc/Makefile                              |    1 +
 sound/soc/mxs/Kconfig                           |   20 +
 sound/soc/mxs/Makefile                          |   10 +
 sound/soc/mxs/mxs-pcm.c                         |  377 ++++++++++++++++
 sound/soc/mxs/mxs-pcm.h                         |   43 ++
 sound/soc/mxs/mxs-saif.c                        |  523 +++++++++++++++++++++++
 sound/soc/mxs/mxs-saif.h                        |  132 ++++++
 sound/soc/mxs/mxs-sgtl5000.c                    |  181 ++++++++
 19 files changed, 1437 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/mach-mxs/devices/platform-mxs-saif.c
 create mode 100644 arch/arm/mach-mxs/include/mach/audio.h
 create mode 100644 sound/soc/mxs/Kconfig
 create mode 100644 sound/soc/mxs/Makefile
 create mode 100644 sound/soc/mxs/mxs-pcm.c
 create mode 100644 sound/soc/mxs/mxs-pcm.h
 create mode 100644 sound/soc/mxs/mxs-saif.c
 create mode 100644 sound/soc/mxs/mxs-saif.h
 create mode 100644 sound/soc/mxs/mxs-sgtl5000.c
