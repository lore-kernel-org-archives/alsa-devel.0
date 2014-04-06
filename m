From: <bardliao@realtek.com>
Subject: [PATCH] Allow snd_soc_update_bits use 32 bits register
Date: Sun, 6 Apr 2014 15:28:41 +0800
Message-ID: <1396769321-32694-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 0C220265205
 for <alsa-devel@alsa-project.org>; Sun,  6 Apr 2014 09:29:11 +0200 (CEST)
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

From: Bard Liao <bardliao@realtek.com>

Change reg's type from unsigned short to unsigned int. So that we can use 32 bits reg value in snd_soc_update_bits.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 include/sound/soc.h  | 2 +-
 sound/soc/soc-core.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 0b83168..687dec0 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -469,7 +469,7 @@ static inline void snd_soc_jack_free_gpios(struct snd_soc_jack *jack, int count,
 #endif
 
 /* codec register bit access */
-int snd_soc_update_bits(struct snd_soc_codec *codec, unsigned short reg,
+int snd_soc_update_bits(struct snd_soc_codec *codec, unsigned int reg,
 				unsigned int mask, unsigned int value);
 int snd_soc_update_bits_locked(struct snd_soc_codec *codec,
 			       unsigned short reg, unsigned int mask,
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index caebd63..fde636c 100644
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
-- 
1.8.1.1.439.g50a6b54
