From: keroid1@gmail.com
Subject: [PATCH] Avoid useless loop
Date: Sun, 10 Apr 2011 19:19:20 -0400
Message-ID: <1302477560-23550-1-git-send-email-keroid1@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 10D761037EC
	for <alsa-devel@alsa-project.org>;
	Sun, 10 Apr 2011 13:18:09 +0200 (CEST)
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
Cc: richard@openedhand.com, broonie@opensource.wolfsonmicro.com, xingchao <keroid1@gmail.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

From: xingchao <keroid1@gmail.com>

Only drop to the for loop to bind DAI when the work is not finished.

Signed-off-by: xingchao <keroid1@gmail.com>
---
 sound/soc/soc-core.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 4dda589..0380a26 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1810,8 +1810,10 @@ static void snd_soc_instantiate_card(struct snd_soc_card *card)
 	}
 
 	/* bind DAIs */
-	for (i = 0; i < card->num_links; i++)
-		soc_bind_dai_link(card, i);
+	if (card->num_rtds != card->num_links) {
+		for (i = 0; i < card->num_links; i++)
+			soc_bind_dai_link(card, i);
+	}
 
 	/* bind completed ? */
 	if (card->num_rtd != card->num_links) {
-- 
1.7.1
