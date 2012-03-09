From: =?utf-8?q?Philippe=20R=C3=A9tornaz?= <philippe.retornaz@epfl.ch>
Subject: [PATCH 0/4] mc13783 sound support
Date: Fri,  9 Mar 2012 15:55:12 +0100
Message-ID: <1331304916-4724-1-git-send-email-philippe.retornaz@epfl.ch>
Content-Type: multipart/mixed; boundary="===============0450966018382750254=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4.epfl.ch (smtp4.epfl.ch [128.178.224.218])
	by alsa0.perex.cz (Postfix) with SMTP id 44734103BBB
	for <alsa-devel@alsa-project.org>; Fri,  9 Mar 2012 16:01:02 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: linux-arm-kernel@lists.infradead.org
Cc: alsa-devel@alsa-project.org, juergen.lambrecht@gmail.com, s.hauer@pengutronix.de, broonie@opensource.wolfsonmicro.com, =?utf-8?q?Philippe=20R=C3=A9tornaz?= <philippe.retornaz@epfl.ch>, festevam@gmail.com
List-Id: alsa-devel@alsa-project.org

--===============0450966018382750254==

Hello

This is patchset enable sound support on boards with mc13783 codec.
The first patch adds the codec driver. It's Sascha's code ported to the
current kernel with some minors additions.
The second patch adds a generic SoC platform driver for imx3 boards with
mc13783 codecs.
The last two patches enable the sound on the mx31moboard boards and on 
mx31pdk_3ds boards.

This patchset has been tested on mx31moboard and mx31pdk_3ds.

It is based on a 3.3-rc6 kernel. I know there are some patches which change
how audmux is handled on i.Mx processor but they are not yet merged so
I prefer to post this patchset based on a known tree than to add another
dependency. If the audmux change is merged I will rebase this patchset.

Small note: If you want to test this, make sure you use redboot as bootloader
or that you have the patch i.MX 35/5 AIPS Setup applied.


Philippe Rétornaz (3):
  Add imx3sound sound support.
  mx31moboard: Add ssi configuration
  imx31pdk: Add sound support

Sascha Hauer (1):
  add a mc13783 codec driver

 arch/arm/mach-imx/Kconfig            |    2 +
 arch/arm/mach-imx/mach-mx31_3ds.c    |   40 ++-
 arch/arm/mach-imx/mach-mx31moboard.c |   37 ++-
 drivers/mfd/mc13xxx-core.c           |    3 +-
 include/linux/mfd/mc13xxx.h          |   11 +
 sound/soc/codecs/Kconfig             |    4 +
 sound/soc/codecs/Makefile            |    2 +
 sound/soc/codecs/mc13783.c           | 1036 ++++++++++++++++++++++++++++++++++
 sound/soc/codecs/mc13783.h           |   30 +
 sound/soc/imx/Kconfig                |   10 +
 sound/soc/imx/Makefile               |    2 +
 sound/soc/imx/imx3sound-mc13783.c    |  141 +++++
 12 files changed, 1315 insertions(+), 3 deletions(-)
 create mode 100644 sound/soc/codecs/mc13783.c
 create mode 100644 sound/soc/codecs/mc13783.h
 create mode 100644 sound/soc/imx/imx3sound-mc13783.c


--===============0450966018382750254==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0450966018382750254==--
