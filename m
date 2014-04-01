From: Nariman Poushin <nariman@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: core: Fail codec probe if we fail to add
	controls
Date: Tue, 1 Apr 2014 13:59:33 +0100
Message-ID: <20140401125933.GA25844@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6183826561C
 for <alsa-devel@alsa-project.org>; Tue,  1 Apr 2014 14:59:34 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Nariman Poushin <nariman@opensource.wolfsonmicro.com>
---
 sound/soc/soc-core.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 35c0e71..7f9ae6c 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1127,9 +1127,17 @@ static int soc_probe_codec(struct snd_soc_card *card,
 
 	soc_init_codec_debugfs(codec);
 
-	if (driver->dapm_widgets)
-		snd_soc_dapm_new_controls(&codec->dapm, driver->dapm_widgets,
-					  driver->num_dapm_widgets);
+	if (driver->dapm_widgets) {
+		ret = snd_soc_dapm_new_controls(&codec->dapm,
+						driver->dapm_widgets,
+					  	driver->num_dapm_widgets);
+		
+		if (ret != 0) {
+			dev_err(codec->dev,
+				"Failed to create new controls %d\n", ret);
+			goto err_probe;
+		}
+	}
 
 	/* Create DAPM widgets for each DAI stream */
 	list_for_each_entry(dai, &codec->component.dai_list, list) {
-- 
1.8.5.3
