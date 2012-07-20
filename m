From: Dong Aisheng <b29396@freescale.com>
Subject: [PATCH 0/4] ASoC: fix saif record unwork issue
Date: Fri, 20 Jul 2012 17:20:23 +0800
Message-ID: <1342776027-31758-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe002.messaging.microsoft.com [216.32.180.185])
 by alsa0.perex.cz (Postfix) with ESMTP id 26ED22602AE
 for <alsa-devel@alsa-project.org>; Fri, 20 Jul 2012 11:31:22 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-arm-kernel@lists.infradead.org
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@ti.com, shawn.guo@freescale.com, w.sang@pengutronix.de
List-Id: alsa-devel@alsa-project.org

This patch series mainly fixes the saif record unwork issue.
The root cause consists of:
1) clk_prepare and clk_enable un-balanced
2) missed setting a proper initial clock rate for saif in dt
3) sgtl5000 dapm widget kcontrol does not work
   So can not test record on mx28evk.
4) missed setting clkmux mode for saif in dt

With this patch series it can fix sgtl5000 widget kcontrol unwork
and saif record unwork issue.

BTW, just let people konw, i still met a few overruns during record,
that's another issue and will be fixed in separte patches later.

Patch based on sound-2.6/for-3.6.

Dong Aisheng (4):
  ASoC: mxs-saif: fix clock prepare and enable unbalance issue
  ASoC: mxs-saif: set a base clock rate for EXTMASTER mode work
  ASoC: sgtl5000: remove unneeded snd_soc_dapm_new_widgets in probe
  ARM: mx28evk: add missed clkmux select for saif

 arch/arm/mach-mxs/mach-mxs.c |    3 +++
 sound/soc/codecs/sgtl5000.c  |    2 --
 sound/soc/mxs/mxs-saif.c     |   24 ++++++++++++++++++++++++
 3 files changed, 27 insertions(+), 2 deletions(-)
