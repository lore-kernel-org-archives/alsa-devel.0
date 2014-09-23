From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: Fix snd_soc_{new,
	free}_ac97_codec() locking removal
Date: Tue, 23 Sep 2014 04:15:48 +0200
Message-ID: <1411438548-8463-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-051.synserver.de (smtp-out-051.synserver.de
 [212.40.185.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 44E7F261600
 for <alsa-devel@alsa-project.org>; Tue, 23 Sep 2014 04:15:51 +0200 (CEST)
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

Commit e3f205a72c45 ("ASoC: Remove locking in
snd_soc_{new,free}_ac97_codec()") overlooked a unlock on one of the error
paths.

Fixes: e3f205a72c45 ("ASoC: Remove locking in snd_soc_{new,free}_ac97_codec()")
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index f7e4ede..5b88fde 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1967,7 +1967,6 @@ int snd_soc_new_ac97_codec(struct snd_soc_codec *codec,
 	if (codec->ac97->bus == NULL) {
 		kfree(codec->ac97);
 		codec->ac97 = NULL;
-		mutex_unlock(&codec->mutex);
 		return -ENOMEM;
 	}
 
-- 
1.8.0
