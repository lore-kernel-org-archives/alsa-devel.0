From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH] ASoC: DAPM: Fix potential DAI widget pointer
	deref when linking DAIs
Date: Thu, 14 Jun 2018 20:26:42 +0100
Message-ID: <20180614192642.11708-1-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id CFA2826760A
 for <alsa-devel@alsa-project.org>; Thu, 14 Jun 2018 21:26:54 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Sometime a component or topology may configure a DAI widget with no
private data leading to a dev_dbg() dereferencne of this data.

Fix this to check for non NULL private data and let users know if widget
is missing DAI.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 sound/soc/soc-dapm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 36a39ba30226..8ede773b1db8 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -4073,6 +4073,13 @@ int snd_soc_dapm_link_dai_widgets(struct snd_soc_card *card)
 			continue;
 		}
 
+		/* let users know there is no DAI to link */
+		if (!dai_w->priv) {
+			dev_dbg(card->dev, "dai widget %s has no DAI\n",
+				dai_w->name);
+			continue;
+		}
+
 		dai = dai_w->priv;
 
 		/* ...find all widgets with the same stream and link them */
-- 
2.17.1
