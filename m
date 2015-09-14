From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ASoC: davinci-mcasp: Revise the FIFO threshold
	calculation
Date: Mon, 14 Sep 2015 16:06:48 +0300
Message-ID: <1442236008-28279-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id 2F823260580
 for <alsa-devel@alsa-project.org>; Mon, 14 Sep 2015 15:06:56 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, daniel@zonque.org
List-Id: alsa-devel@alsa-project.org

The FIFO threshold for McASP should be <=[tx/rx]numevt so the initial value
for the refining should meet this requirement as well.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/davinci/davinci-mcasp.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index add6bb99661d..1260b315a96c 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -663,7 +663,7 @@ static int mcasp_common_hw_param(struct davinci_mcasp *mcasp, int stream,
 	u8 rx_ser = 0;
 	u8 slots = mcasp->tdm_slots;
 	u8 max_active_serializers = (channels + slots - 1) / slots;
-	int active_serializers, numevt, n;
+	int active_serializers, numevt;
 	u32 reg;
 	/* Default configuration */
 	if (mcasp->version < MCASP_VERSION_3)
@@ -745,9 +745,8 @@ static int mcasp_common_hw_param(struct davinci_mcasp *mcasp, int stream,
 	 * The number of words for numevt need to be in steps of active
 	 * serializers.
 	 */
-	n = numevt % active_serializers;
-	if (n)
-		numevt += (active_serializers - n);
+	numevt = (numevt / active_serializers) * active_serializers;
+
 	while (period_words % numevt && numevt > 0)
 		numevt -= active_serializers;
 	if (numevt <= 0)
-- 
2.5.2
