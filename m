From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ASoC: davinci-mcasp: Do not touch 0x04
	register above McASP_VERSION_2
Date: Fri, 4 Apr 2014 15:56:30 +0300
Message-ID: <1396616190-3299-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id 70EAF2657D3
 for <alsa-devel@alsa-project.org>; Fri,  4 Apr 2014 14:56:36 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, jsarha@ti.com, zonque@gmail.com
List-Id: alsa-devel@alsa-project.org

This register is not defined in TI81xx and on AM335x/AM437x it is the
SYSCONFIG register which should not be touched by drivers since it is
related to PM and handled by the generic PM code.
This register write was there since the first time the davinci-mcasp driver
was appeared in the kernel.
The reason why it did not caused any issues on AM335x/AM437x is that it sets
bit 1 in SYSCONFIG register which in turn will enable the smart-idle mode.
This is the default mode and this is the mode McASP should be in also when
in use.
On TI81xx the register is not defined.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/davinci/davinci-mcasp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index ce0e55a4304c..50a824d9dbb7 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -495,7 +495,7 @@ static int mcasp_common_hw_param(struct davinci_mcasp *mcasp, int stream,
 	int active_serializers, numevt, n;
 	u32 reg;
 	/* Default configuration */
-	if (mcasp->version != MCASP_VERSION_4)
+	if (mcasp->version < MCASP_VERSION_3)
 		mcasp_set_bits(mcasp, DAVINCI_MCASP_PWREMUMGT_REG, MCASP_SOFT);
 
 	/* All PINS as McASP */
-- 
1.9.1
