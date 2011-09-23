From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: [PATCH,
	resend] ASoC: omap-mcbsp: Do not attempt to change DAI sysclk if
	stream is active
Date: Fri, 23 Sep 2011 11:19:13 +0300
Message-ID: <1316765954-17076-1-git-send-email-jarkko.nikula@bitmer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bitmer.com (bitmer.com [213.157.87.50])
	by alsa0.perex.cz (Postfix) with ESMTP id 84FCA24376
	for <alsa-devel@alsa-project.org>;
	Fri, 23 Sep 2011 10:19:44 +0200 (CEST)
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, stable@kernel.org
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

Fix this by not changing any configuration in omap_mcbsp_dai_set_dai_sysclk
if the McBSP is already active. This test should have been here just from
the beginning anyway.

Signed-off-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: stable@kernel.org
Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
For 2.6.37 and onward.

Mark: I didn't add your acked-by even you acked this earlier:
http://mailman.alsa-project.org/pipermail/alsa-devel/2011-June/040717.html
Just in case if this go through your signed-off during kernel.org hazzle.
---
 sound/soc/omap/omap-mcbsp.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index ebcc2d4..478d607 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -516,6 +516,12 @@ static int omap_mcbsp_dai_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
 	struct omap_mcbsp_reg_cfg *regs = &mcbsp_data->regs;
 	int err = 0;
 
+	if (mcbsp_data->active)
+		if (freq == mcbsp_data->in_freq)
+			return 0;
+		else
+			return -EBUSY;
+
 	/* The McBSP signal muxing functions are only available on McBSP1 */
 	if (clk_id == OMAP_MCBSP_CLKR_SRC_CLKR ||
 	    clk_id == OMAP_MCBSP_CLKR_SRC_CLKX ||
-- 
1.7.5.4
