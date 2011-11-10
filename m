From: Dong Aisheng <b29396@freescale.com>
Subject: [PATCH v4 0/3] ARM: mxs: add recording support for saif
Date: Thu, 10 Nov 2011 14:42:10 +0800
Message-ID: <1320907333-12696-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from DB3EHSOBE001.bigfish.com (db3ehsobe001.messaging.microsoft.com
	[213.199.154.139])
	by alsa0.perex.cz (Postfix) with ESMTP id BB1102412E
	for <alsa-devel@alsa-project.org>; Thu, 10 Nov 2011 07:30:11 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, s.hauer@pengutronix.de, broonie@opensource.wolfsonmicro.com, w.sang@pengutronix.de, u.kleine-koenig@pengutronix.de, lrg@ti.com, shawn.guo@freescale.com
List-Id: alsa-devel@alsa-project.org

Changes since v3:
 * remove unneeded locking according to Sascha.
The patches are based on imx-features branch since commit:
ca4e419c2.

Changes since v2:
 * separate clkmux code into another patch according to Uwe
 * add lock according to Wolfram
 * Other minus fixes suggested by Uwe and Wolfram.
 * remove Wolfram's fix saif clock setting patch which is in v2 series
   since Wolfram will reform the clock code and send it out himself.
   For test purpose, user still needs that patch. People can get it
   from v2 series.
   The patch is:
   [PATCH v2 3/3] arm: mxs: disable clock-gates when setting saif-clocks

The patches are based on imx-features branch since commit:
f4f01e31835f.

Changes since v1:
The main changes are move mach-specific code(clkmux in DIGCTL) from
saif driver to mach-specific layer based on Wolfram's suggestion.

Note that the last patch is a RFC patch and sent out for testing
since without that patch the saif may not work.

Dong Aisheng (3):
  ARM: mxs: add saif clkmux functions
  ARM: mx28evk: add platform data for saif
  ARM: mx28evk: set a initial clock rate for saif

 arch/arm/mach-mxs/clock-mx28.c                  |   65 +++++++++++++++++++++++
 arch/arm/mach-mxs/devices-mx28.h                |    3 +-
 arch/arm/mach-mxs/devices/platform-mxs-saif.c   |    5 +-
 arch/arm/mach-mxs/include/mach/common.h         |    2 +
 arch/arm/mach-mxs/include/mach/devices-common.h |    4 +-
 arch/arm/mach-mxs/include/mach/digctl.h         |   21 +++++++
 arch/arm/mach-mxs/mach-mx28evk.c                |   16 +++++-
 7 files changed, 110 insertions(+), 6 deletions(-)
 create mode 100644 arch/arm/mach-mxs/include/mach/digctl.h
