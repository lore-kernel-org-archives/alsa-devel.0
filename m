From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH] ASoC: core: Allow snd_soc_update_bits use 32
	bits register
Date: Tue, 8 Apr 2014 11:18:10 +0800
Message-ID: <1396927090-31714-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id BE0F5261A8E
 for <alsa-devel@alsa-project.org>; Tue,  8 Apr 2014 05:19:19 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: oder_chiou@realtek.com, bardliao@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

Change reg's type from unsigned short to unsigned int. So that we can use
32 bits reg value in snd_soc_update_bits.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 include/sound/soc.h  | 6 +++---
 sound/soc/soc-core.c | 8 ++++----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 5878410..b18cf27 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -469,12 +469,12 @@ static inline void snd_soc_jack_free_gpios(struct snd_soc_jack *jack, int count,
 #endif
 
 /* codec register bit access */
-int snd_soc_update_bits(struct snd_soc_codec *codec, unsigned short reg,
+int snd_soc_update_bits(struct snd_soc_codec *codec, unsigned int reg,
 				unsigned int mask, unsigned int value);
 int snd_soc_update_bits_locked(struct snd_soc_codec *codec,
-			       unsigned short reg, unsigned int mask,
+			       unsigned int reg, unsigned int mask,
 			       unsigned int value);
-int snd_soc_test_bits(struct snd_soc_codec *codec, unsigned short reg,
+int snd_soc_test_bits(struct snd_soc_codec *codec, unsigned int reg,
 				unsigned int mask, unsigned int value);
 
 int snd_soc_new_ac97_codec(struct snd_soc_codec *codec,
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index cd52d52..7e2734d 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2316,7 +2316,7 @@ EXPORT_SYMBOL_GPL(snd_soc_write);
  *
  * Returns 1 for change, 0 for no change, or negative error code.
  */
-int snd_soc_update_bits(struct snd_soc_codec *codec, unsigned short reg,
+int snd_soc_update_bits(struct snd_soc_codec *codec, unsigned int reg,
 				unsigned int mask, unsigned int value)
 {
 	bool change;
@@ -2357,7 +2357,7 @@ EXPORT_SYMBOL_GPL(snd_soc_update_bits);
  * Returns 1 for change else 0.
  */
 int snd_soc_update_bits_locked(struct snd_soc_codec *codec,
-			       unsigned short reg, unsigned int mask,
+			       unsigned int reg, unsigned int mask,
 			       unsigned int value)
 {
 	int change;
@@ -2382,7 +2382,7 @@ EXPORT_SYMBOL_GPL(snd_soc_update_bits_locked);
  *
  * Returns 1 for change else 0.
  */
-int snd_soc_test_bits(struct snd_soc_codec *codec, unsigned short reg,
+int snd_soc_test_bits(struct snd_soc_codec *codec, unsigned int reg,
 				unsigned int mask, unsigned int value)
 {
 	int change;
@@ -2897,7 +2897,7 @@ int snd_soc_put_volsw_sx(struct snd_kcontrol *kcontrol,
 	int min = mc->min;
 	int mask = (1 << (fls(min + max) - 1)) - 1;
 	int err = 0;
-	unsigned short val, val_mask, val2 = 0;
+	unsigned int val, val_mask, val2 = 0;
 
 	val_mask = mask << shift;
 	val = (ucontrol->value.integer.value[0] + min) & mask;
-- 
1.8.1.1.439.g50a6b54
