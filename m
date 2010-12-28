From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/9] ASoC: codecs: max98088: Fix register cache
	incoherency
Date: Tue, 28 Dec 2010 21:37:56 +0100
Message-ID: <1293568684-9626-3-git-send-email-lars@metafoo.de>
References: <1293568684-9626-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-089.synserver.de (smtp-out-091.synserver.de
	[212.40.180.91]) by alsa0.perex.cz (Postfix) with SMTP id F05FD245E3
	for <alsa-devel@alsa-project.org>; Tue, 28 Dec 2010 21:38:25 +0100 (CET)
In-Reply-To: <1293568684-9626-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: Peter Hsiang <Peter.Hsiang@maxim-ic.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The multi-component patch(commit f0fba2ad1) moved the allocation of the
register cache from the driver to the ASoC core. Most drivers where adjusted to
this, but the max98088 driver still uses its own register cache for its
private functions, while functions from the ASoC core use the generic cache.
Thus we end up with two from each other incoherent caches, which can lead to
undefined behaviour.
This patch fixes the issue by changing the max98088 driver to use the
generic register cache in its private functions.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Cc: Peter Hsiang <Peter.Hsiang@maxim-ic.com>

---
Compile tested only
---
 sound/soc/codecs/max98088.c |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/max98088.c b/sound/soc/codecs/max98088.c
index d63e287..6447dbb 100644
--- a/sound/soc/codecs/max98088.c
+++ b/sound/soc/codecs/max98088.c
@@ -40,7 +40,6 @@ struct max98088_cdata {
 };
 
 struct max98088_priv {
-       u8 reg_cache[M98088_REG_CNT];
        enum max98088_type devtype;
        void *control_data;
        struct max98088_pdata *pdata;
@@ -1588,7 +1587,7 @@ static int max98088_dai2_set_fmt(struct snd_soc_dai *codec_dai,
 
 static void max98088_sync_cache(struct snd_soc_codec *codec)
 {
-       struct max98088_priv *max98088 = snd_soc_codec_get_drvdata(codec);
+       u16 *reg_cache = codec->reg_cache;
        int i;
 
        if (!codec->cache_sync)
@@ -1599,14 +1598,14 @@ static void max98088_sync_cache(struct snd_soc_codec *codec)
        /* write back cached values if they're writeable and
         * different from the hardware default.
         */
-       for (i = 1; i < ARRAY_SIZE(max98088->reg_cache); i++) {
+       for (i = 1; i < codec->driver->reg_cache_size; i++) {
                if (!max98088_access[i].writable)
                        continue;
 
-               if (max98088->reg_cache[i] == max98088_reg[i])
+               if (reg_cache[i] == max98088_reg[i])
                        continue;
 
-               snd_soc_write(codec, i, max98088->reg_cache[i]);
+               snd_soc_write(codec, i, reg_cache[i]);
        }
 
        codec->cache_sync = 0;
@@ -1951,7 +1950,6 @@ static int max98088_probe(struct snd_soc_codec *codec)
        int ret = 0;
 
        codec->cache_sync = 1;
-       memcpy(codec->reg_cache, max98088_reg, sizeof(max98088_reg));
 
        ret = snd_soc_codec_set_cache_io(codec, 8, 8, SND_SOC_I2C);
        if (ret != 0) {
-- 
1.7.2.3
