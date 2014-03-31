From: Nariman Poushin <nariman@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: core: Fail probe if we fail to add dai
	widgets
Date: Mon, 31 Mar 2014 15:47:12 +0100
Message-ID: <20140331144712.GA6263@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 010A1265171
 for <alsa-devel@alsa-project.org>; Mon, 31 Mar 2014 17:04:22 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, patches@wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Nariman Poushin <nariman@opensource.wolfsonmicro.com>
---
 sound/soc/soc-core.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index b322cf2..5cf7107 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1132,8 +1132,15 @@ static int soc_probe_codec(struct snd_soc_card *card,
 					  driver->num_dapm_widgets);
 
 	/* Create DAPM widgets for each DAI stream */
-	list_for_each_entry(dai, &codec->component.dai_list, list)
-		snd_soc_dapm_new_dai_widgets(&codec->dapm, dai);
+	list_for_each_entry(dai, &codec->component.dai_list, list) {
+		ret = snd_soc_dapm_new_dai_widgets(&codec->dapm, dai);
+
+		if (ret != 0) {
+			dev_err(codec->dev,
+				"Failed to create DAI widgets %d\n", ret);
+			goto err_probe;
+		}
+	}
 
 	codec->dapm.idle_bias_off = driver->idle_bias_off;
 
-- 
1.8.5.3
