From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 12/13] ASoC: Remove snd_soc_update_bits_locked()
Date: Tue, 18 Mar 2014 09:02:15 +0100
Message-ID: <1395129736-11938-13-git-send-email-lars@metafoo.de>
References: <1395129736-11938-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-224.synserver.de (smtp-out-230.synserver.de
 [212.40.185.230])
 by alsa0.perex.cz (Postfix) with ESMTP id 7BEA8261B2D
 for <alsa-devel@alsa-project.org>; Tue, 18 Mar 2014 09:01:52 +0100 (CET)
In-Reply-To: <1395129736-11938-1-git-send-email-lars@metafoo.de>
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
Cc: Brian Austin <brian.austin@cirrus.com>, Lars-Peter Clausen <lars@metafoo.de>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, Paul Handrigan <Paul.Handrigan@cirrus.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

There are no users of snd_soc_update_bits_locked() left and it is identical to
snd_soc_update_bits(). So it can be removed.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc.h |  3 ---
 sound/soc/soc-io.c  | 20 --------------------
 2 files changed, 23 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index cb98cd6..4485688 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -465,9 +465,6 @@ static inline void snd_soc_jack_free_gpios(struct snd_soc_jack *jack, int count,
 /* codec register bit access */
 int snd_soc_update_bits(struct snd_soc_codec *codec, unsigned short reg,
 				unsigned int mask, unsigned int value);
-int snd_soc_update_bits_locked(struct snd_soc_codec *codec,
-			       unsigned short reg, unsigned int mask,
-			       unsigned int value);
 int snd_soc_test_bits(struct snd_soc_codec *codec, unsigned short reg,
 				unsigned int mask, unsigned int value);
 
diff --git a/sound/soc/soc-io.c b/sound/soc/soc-io.c
index 762bcbc..4b87e42 100644
--- a/sound/soc/soc-io.c
+++ b/sound/soc/soc-io.c
@@ -161,26 +161,6 @@ int snd_soc_update_bits(struct snd_soc_codec *codec, unsigned short reg,
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
-			       unsigned short reg, unsigned int mask,
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
