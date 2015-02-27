From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/3] ASoC: da732x: Fix control-less DAPM routes
Date: Fri, 27 Feb 2015 14:13:03 +0100
Message-ID: <1425042784-727-2-git-send-email-lars@metafoo.de>
References: <1425042784-727-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-145.synserver.de (smtp-out-153.synserver.de
 [212.40.185.153])
 by alsa0.perex.cz (Postfix) with ESMTP id 7133D260703
 for <alsa-devel@alsa-project.org>; Fri, 27 Feb 2015 14:13:09 +0100 (CET)
In-Reply-To: <1425042784-727-1-git-send-email-lars@metafoo.de>
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
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Support Opensource <support.opensource@diasemi.com>
List-Id: alsa-devel@alsa-project.org

Routes without a control must use NULL for the control name. The da732x
driver uses "NULL" instead in a few places. Previous to commit 5fe5b767dc6f
("ASoC: dapm: Do not pretend to support controls for non mixer/mux widgets")
the DAPM core silently ignored non-NULL controls on non-mixer and non-mux
routes. But starting with that commit it will complain and not add the
route breaking the da732x driver in the process.

This patch replaces the incorrect "NULL" control name with NULL to fix the
issue.

Fixes: 5fe5b767dc6f ("ASoC: dapm: Do not pretend to support controls for non mixer/mux widgets")
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/da732x.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/da732x.c b/sound/soc/codecs/da732x.c
index ffe9617..911c26c 100644
--- a/sound/soc/codecs/da732x.c
+++ b/sound/soc/codecs/da732x.c
@@ -876,11 +876,11 @@ static const struct snd_soc_dapm_widget da732x_dapm_widgets[] = {
 
 static const struct snd_soc_dapm_route da732x_dapm_routes[] = {
 	/* Inputs */
-	{"AUX1L PGA", "NULL", "AUX1L"},
-	{"AUX1R PGA", "NULL", "AUX1R"},
+	{"AUX1L PGA", NULL, "AUX1L"},
+	{"AUX1R PGA", NULL, "AUX1R"},
 	{"MIC1 PGA", NULL, "MIC1"},
-	{"MIC2 PGA", "NULL", "MIC2"},
-	{"MIC3 PGA", "NULL", "MIC3"},
+	{"MIC2 PGA", NULL, "MIC2"},
+	{"MIC3 PGA", NULL, "MIC3"},
 
 	/* Capture Path */
 	{"ADC1 Left MUX", "MIC1", "MIC1 PGA"},
-- 
1.8.0
