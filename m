From: Richard Zhao <richard.zhao@freescale.com>
Subject: [PATCH 1/1] ASoC: Core: check
	of_property_count_strings failure
Date: Tue, 24 Apr 2012 15:24:43 +0800
Message-ID: <1335252283-27750-1-git-send-email-richard.zhao@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from db3outboundpool.messaging.microsoft.com
	(db3ehsobe006.messaging.microsoft.com [213.199.154.144])
	by alsa0.perex.cz (Postfix) with ESMTP id 3046C10446D
	for <alsa-devel@alsa-project.org>;
	Tue, 24 Apr 2012 09:24:59 +0200 (CEST)
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
Cc: broonie@opensource.wolfsonmicro.com, Richard Zhao <richard.zhao@freescale.com>, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
---
 sound/soc/soc-core.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 20e55531..ce4d462 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3683,10 +3683,10 @@ int snd_soc_of_parse_audio_routing(struct snd_soc_card *card,
 	int i, ret;
 
 	num_routes = of_property_count_strings(np, propname);
-	if (num_routes & 1) {
+	if (num_routes < 0 || num_routes & 1) {
 		dev_err(card->dev,
-			"Property '%s's length is not even\n",
-			propname);
+		     "Property '%s' does not exist or its length is not even\n",
+		     propname);
 		return -EINVAL;
 	}
 	num_routes /= 2;
-- 
1.7.5.4
