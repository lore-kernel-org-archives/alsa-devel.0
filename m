From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 5/7] ASoC: Remove snd_soc_update_bits_locked()
Date: Sat, 19 Apr 2014 10:44:00 +0200
Message-ID: <1397897042-20092-6-git-send-email-lars@metafoo.de>
References: <1397897042-20092-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-073.synserver.de (smtp-out-120.synserver.de
 [212.40.185.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 12BAA261A92
 for <alsa-devel@alsa-project.org>; Sat, 19 Apr 2014 10:44:14 +0200 (CEST)
In-Reply-To: <1397897042-20092-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Sven Brandau <brandau@gmx.de>, Daniel Mack <daniel@zonque.org>
List-Id: alsa-devel@alsa-project.org

There are no users of snd_soc_update_bits_locked() left and it is identical to
snd_soc_update_bits(). So it can be removed.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-io.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/sound/soc/soc-io.c b/sound/soc/soc-io.c
index 0fdb924..0e11410 100644
--- a/sound/soc/soc-io.c
+++ b/sound/soc/soc-io.c
@@ -241,26 +241,6 @@ int snd_soc_update_bits(struct snd_soc_codec *codec, unsigned int reg,
 EXPORT_SYMBOL_GPL(snd_soc_update_bits);
 
 /**
- * snd_soc_update_bits_locked - update codec register bits
- * @codec: audio codec
- * @reg: codec register
- * @mask: register mask
- * @value: new value
- *
- * Writes new register value, and takes the codec mutex.
- *
- * Returns 1 for change else 0.
- */
-int snd_soc_update_bits_locked(struct snd_soc_codec *codec,
-			       unsigned int reg, unsigned int mask,
-			       unsigned int value)
-{
-	return snd_soc_component_update_bits(&codec->component, reg, mask,
-		value);
-}
-EXPORT_SYMBOL_GPL(snd_soc_update_bits_locked);
-
-/**
  * snd_soc_test_bits - test register for change
  * @codec: audio codec
  * @reg: codec register
-- 
1.8.0
