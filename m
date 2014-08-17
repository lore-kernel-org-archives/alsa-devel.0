From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: Use dev_set_name() instead of init_name
Date: Sun, 17 Aug 2014 11:28:35 +0200
Message-ID: <1408267715-19237-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-157.synserver.de (smtp-out-157.synserver.de
 [212.40.185.157])
 by alsa0.perex.cz (Postfix) with ESMTP id 81314264EE5
 for <alsa-devel@alsa-project.org>; Sun, 17 Aug 2014 11:28:38 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

init_name is basically a hack and should only be used for statically allocated
device structs. For dynamically allocated devices dev_set_name() should be used.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index d4bfd4a..889f4e3 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1325,7 +1325,7 @@ static int soc_post_component_init(struct snd_soc_pcm_runtime *rtd,
 	device_initialize(rtd->dev);
 	rtd->dev->parent = rtd->card->dev;
 	rtd->dev->release = rtd_release;
-	rtd->dev->init_name = name;
+	dev_set_name(rtd->dev, "%s", name);
 	dev_set_drvdata(rtd->dev, rtd);
 	mutex_init(&rtd->pcm_mutex);
 	INIT_LIST_HEAD(&rtd->dpcm[SNDRV_PCM_STREAM_PLAYBACK].be_clients);
-- 
1.8.0
