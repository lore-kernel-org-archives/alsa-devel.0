From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH] ASoC: topology: rephrase deferred binding
	warning.
Date: Tue,  6 Jun 2017 15:45:08 +0100
Message-ID: <1496760309-6195-3-git-send-email-liam.r.girdwood@linux.intel.com>
References: <1496760309-6195-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 1F2BD266F0D
 for <alsa-devel@alsa-project.org>; Tue,  6 Jun 2017 16:45:21 +0200 (CEST)
In-Reply-To: <1496760309-6195-1-git-send-email-liam.r.girdwood@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Rewrite the message to be more meaningful.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 sound/soc/soc-topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index d5cb66f1bbc3..b0bbb0756f69 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -1648,7 +1648,7 @@ static int soc_tplg_dapm_complete(struct soc_tplg *tplg)
 	*/
 	if (!card || !card->instantiated) {
 		dev_warn(tplg->dev, "ASoC: Parent card not yet available,"
-				"Do not add new widgets now\n");
+			" widget card binding deferred\n");
 		return 0;
 	}
 
-- 
2.11.0
