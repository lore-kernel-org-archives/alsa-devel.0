From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 8/8] ASoC: Remove CODEC mutex
Date: Sun,  9 Nov 2014 17:01:04 +0100
Message-ID: <1415548864-27203-9-git-send-email-lars@metafoo.de>
References: <1415548864-27203-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-180.synserver.de (smtp-out-182.synserver.de
 [212.40.185.182])
 by alsa0.perex.cz (Postfix) with ESMTP id 5B7F7260565
 for <alsa-devel@alsa-project.org>; Sun,  9 Nov 2014 17:01:11 +0100 (CET)
In-Reply-To: <1415548864-27203-1-git-send-email-lars@metafoo.de>
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
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Tushar Behera <tushar.behera@linaro.org>
List-Id: alsa-devel@alsa-project.org

The CODEC mutex is now unused and can be removed.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc.h  | 1 -
 sound/soc/soc-core.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 7ba7130..5c91b06 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -780,7 +780,6 @@ struct snd_soc_codec {
 	struct device *dev;
 	const struct snd_soc_codec_driver *driver;
 
-	struct mutex mutex;
 	struct list_head list;
 	struct list_head card_list;
 
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 4c8f8a2..cc7bb7a 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -4362,7 +4362,6 @@ int snd_soc_register_codec(struct device *dev,
 	codec->dev = dev;
 	codec->driver = codec_drv;
 	codec->component.val_bytes = codec_drv->reg_word_size;
-	mutex_init(&codec->mutex);
 
 #ifdef CONFIG_DEBUG_FS
 	codec->component.init_debugfs = soc_init_codec_debugfs;
-- 
1.8.0
