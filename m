From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH] ASoC: omap-mcbsp: Do not attempt to change DAI
	sysclk if stream is active
Date: Fri, 10 Jun 2011 14:28:55 +0300
Message-ID: <1307705335-2836-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id E3FA9243AB
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Jun 2011 13:28:03 +0200 (CEST)
Received: by ewy6 with SMTP id 6so886719ewy.38
	for <alsa-devel@alsa-project.org>; Fri, 10 Jun 2011 04:28:01 -0700 (PDT)
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
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, stable@kernel.org
List-Id: alsa-devel@alsa-project.org

Attempt to change McBSP CLKS source while another stream is active is not
safe after commit d135865 ("OMAP: McBSP: implement functional clock
switching via clock framework") in 2.6.37.

CLKS parent clock switching using clock framework have to idle the McBSP
before switching and then activate it again. This short break can cause a
DMA transaction error to already running stream which halts and recovers
only by closing and restarting the stream.

This goes more fatal after commit e2fa61d ("OMAP3: l3: Introduce
l3-interconnect error handling driver") in 2.6.39 where l3 driver detects a
severe timeout error and does BUG_ON().

Fix this by checking is the McBSP active in omap_mcbsp_dai_set_dai_sysclk
before attempting to change any clocking configuration. This test should
have been here just from the beginning anyway.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
Cc: stable@kernel.org
---
For 2.6.37 and onward.

This issue is valid to those machine drivers that use the McBSP as a DAI link
master and are configuring the CLKS source (like sound/soc/omap/omap3pandora.c
in mainline).
---
 sound/soc/omap/omap-mcbsp.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index 07b7723..fc896c1 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -516,6 +516,9 @@ static int omap_mcbsp_dai_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
 	struct omap_mcbsp_reg_cfg *regs = &mcbsp_data->regs;
 	int err = 0;
 
+	if (mcbsp_data->active)
+		return 0;
+
 	/* The McBSP signal muxing functions are only available on McBSP1 */
 	if (clk_id == OMAP_MCBSP_CLKR_SRC_CLKR ||
 	    clk_id == OMAP_MCBSP_CLKR_SRC_CLKX ||
-- 
1.7.4.4
