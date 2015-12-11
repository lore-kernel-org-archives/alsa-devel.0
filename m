From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ASoC: davinci-mcasp: Fix XDATA check in
	mcasp_start_tx
Date: Fri, 11 Dec 2015 13:06:24 +0200
Message-ID: <1449831984-29403-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id 320862657C5
 for <alsa-devel@alsa-project.org>; Fri, 11 Dec 2015 12:06:31 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, Jyri Sarha <jsarha@ti.com>
List-Id: alsa-devel@alsa-project.org

The condition for checking for XDAT being cleared was not correct.

Fixes: 36bcecd0a73eb ("ASoC: davinci-mcasp: Correct TX start sequence")
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/davinci/davinci-mcasp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index c1c9c2e3525b..2ccb8bccc9d4 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -223,8 +223,8 @@ static void mcasp_start_tx(struct davinci_mcasp *mcasp)
 
 	/* wait for XDATA to be cleared */
 	cnt = 0;
-	while (!(mcasp_get_reg(mcasp, DAVINCI_MCASP_TXSTAT_REG) &
-		 ~XRDATA) && (cnt < 100000))
+	while ((mcasp_get_reg(mcasp, DAVINCI_MCASP_TXSTAT_REG) & XRDATA) &&
+	       (cnt < 100000))
 		cnt++;
 
 	/* Release TX state machine */
-- 
2.6.4
