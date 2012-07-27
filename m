From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 0/7] Bugfixes and clean-ups bound for the v3.6
	RCs
Date: Fri, 27 Jul 2012 13:38:47 +0100
Message-ID: <1343392734-11805-1-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f179.google.com (mail-we0-f179.google.com
 [74.125.82.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 69CD9264F04
 for <alsa-devel@alsa-project.org>; Fri, 27 Jul 2012 14:38:59 +0200 (CEST)
Received: by weyx10 with SMTP id x10so1836409wey.38
 for <alsa-devel@alsa-project.org>; Fri, 27 Jul 2012 05:39:01 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: ola.o.lilja@stericsson.com, alsa-devel@alsa-project.org, sameo@linux.intel.com, arnd@arndb.de, broonie@opensource.wolfsonmicro.com, olalilja@yahoo.se, STEricsson_nomadik_linux@list.st.com, lrg@ti.com, linus.walleij@stericsson.com
List-Id: alsa-devel@alsa-project.org

This patch-set includes some important changes which should make
their way to the Mainline Release Candidates for the v3.6 release.
Without them Audio doesn't even probe (at all) when booting with
Device Tree selected. The kernel can't compile with ux500 audio
enabled. Also platform data will fail to reach the AB8500 CODEC
driver. Even if we can get that far SoC Core will assume we're
using regmaps and attempt to use them; however, none exist for
this driver, so the kernel will oops.

 arch/arm/mach-ux500/board-mop500-msp.c |    2 +-
 arch/arm/mach-ux500/board-mop500.c     |    9 ++++-----
 drivers/mfd/ab8500-core.c              |    1 +
 drivers/mfd/db8500-prcmu.c             |    1 +
 sound/soc/codecs/ab8500-codec.c        |    4 ++++
 sound/soc/soc-dapm.c                   |    2 --
 6 files changed, 11 insertions(+), 8 deletions(-)
