From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/5] ASoC: Remove unused num_dai field from
	CODEC
Date: Tue,  6 May 2014 09:39:39 +0200
Message-ID: <1399361981-18518-4-git-send-email-lars@metafoo.de>
References: <1399361981-18518-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-167.synserver.de (smtp-out-016.synserver.de
 [212.40.185.16])
 by alsa0.perex.cz (Postfix) with ESMTP id 8C35A2610C1
 for <alsa-devel@alsa-project.org>; Tue,  6 May 2014 09:39:51 +0200 (CEST)
In-Reply-To: <1399361981-18518-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Bo Shen <voice.shen@atmel.com>
List-Id: alsa-devel@alsa-project.org

Commit d191bd8de8 ("ASoC: snd_soc_codec includes snd_soc_component") removed the
last user of the num_dai field. Also remove the field itself.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc.h  | 1 -
 sound/soc/soc-core.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 5603020..f046dcf 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -692,7 +692,6 @@ struct snd_soc_codec {
 	struct snd_soc_card *card;
 	struct list_head list;
 	struct list_head card_list;
-	int num_dai;
 
 	/* runtime */
 	struct snd_ac97 *ac97;  /* for ad-hoc ac97 devices */
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index cc62526..f32b3f2 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -4265,7 +4265,6 @@ int snd_soc_register_codec(struct device *dev,
 	codec->dapm.stream_event = codec_drv->stream_event;
 	codec->dev = dev;
 	codec->driver = codec_drv;
-	codec->num_dai = num_dai;
 	codec->component.val_bytes = codec_drv->reg_word_size;
 	mutex_init(&codec->mutex);
 
-- 
1.8.0
