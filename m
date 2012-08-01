From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: core: Fix check before defaulting to
	regmap
Date: Wed,  1 Aug 2012 20:06:25 +0100
Message-ID: <1343847985-23712-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CE653265E59
 for <alsa-devel@alsa-project.org>; Wed,  1 Aug 2012 21:06:25 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Check if the chip has provided a write operation (which is mandatory for
I/O) rather than looking for control data as some of the MFDs use a global
for this. Also skip the attempt if there's no regmap available by device
in case things get confused by the attempt to default.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index b1fd043..5359623 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1096,7 +1096,7 @@ static int soc_probe_codec(struct snd_soc_card *card,
 	}
 
 	/* If the driver didn't set I/O up try regmap */
-	if (!codec->control_data)
+	if (!codec->write && dev_get_regmap(codec->dev, NULL))
 		snd_soc_codec_set_cache_io(codec, 0, 0, SND_SOC_REGMAP);
 
 	if (driver->controls)
-- 
1.7.10.4
