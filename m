From: Dong Aisheng <b29396@freescale.com>
Subject: [PATCH v2 0/3] ARM: mxs: add recording support for saif
Date: Wed, 7 Sep 2011 21:57:35 +0800
Message-ID: <1315403858-9904-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from AM1EHSOBE001.bigfish.com (am1ehsobe001.messaging.microsoft.com
	[213.199.154.204])
	by alsa0.perex.cz (Postfix) with ESMTP id 19A4D103813
	for <alsa-devel@alsa-project.org>;
	Wed,  7 Sep 2011 15:41:44 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: s.hauer@pengutronix.de, broonie@opensource.wolfsonmicro.com, lrg@ti.com, linux-arm-kernel@lists.infradead.org, w.sang@pengutronix.de
List-Id: alsa-devel@alsa-project.org

The first series does not have a cover letter.
Add it now for v2.

The main changes are move mach-specific code(clkmux in DIGCTL) from
saif driver to mach-specific layer based on Wolfram's suggestion.

Note that the last patch is a RFC patch and sent out for testing
since without that patch the saif may not work.

Dong Aisheng (2):
  ARM: mx28evk: add platform data for saif
  ARM: mx28evk: set a initial clock rate for saif

Wolfram Sang (1):
  arm: mxs: disable clock-gates when setting saif-clocks

 arch/arm/mach-mxs/clock-mx28.c                  |   63 ++++++++++++++++++++++-
 arch/arm/mach-mxs/devices-mx28.h                |    4 +-
 arch/arm/mach-mxs/devices/platform-mxs-saif.c   |    5 +-
 arch/arm/mach-mxs/include/mach/common.h         |    2 +
 arch/arm/mach-mxs/include/mach/devices-common.h |    4 +-
 arch/arm/mach-mxs/include/mach/digctl.h         |   18 +++++++
 arch/arm/mach-mxs/mach-mx28evk.c                |   15 +++++-
 arch/arm/mach-mxs/regs-clkctrl-mx28.h           |    2 +
 8 files changed, 105 insertions(+), 8 deletions(-)
 create mode 100644 arch/arm/mach-mxs/include/mach/digctl.h
