From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v3 3/5] ASoC: Remove
	snd_soc_update_bits_locked()
Date: Tue, 22 Apr 2014 12:02:22 +0200
Message-ID: <1398160944-6661-4-git-send-email-lars@metafoo.de>
References: <1398160944-6661-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-072.synserver.de (smtp-out-075.synserver.de
 [212.40.185.75])
 by alsa0.perex.cz (Postfix) with ESMTP id 575E6261ABB
 for <alsa-devel@alsa-project.org>; Tue, 22 Apr 2014 12:02:34 +0200 (CEST)
In-Reply-To: <1398160944-6661-1-git-send-email-lars@metafoo.de>
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

There are no users of snd_soc_update_bits_locked() left and it is identical to
snd_soc_update_bits(). So it can be removed.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-io.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/sound/soc/soc-io.c b/sound/soc/soc-io.c
index ac64fd7..2ead9ed 100644
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
