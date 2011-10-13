From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: sta32x: Write the register default value
 to cache for reserved registers
Date: Thu, 13 Oct 2011 14:57:31 +0800
Message-ID: <1318489051.2857.3.camel@phoenix>
References: <1318488008.2857.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 827C71039A7
	for <alsa-devel@alsa-project.org>;
	Thu, 13 Oct 2011 08:57:38 +0200 (CEST)
Received: by gyg4 with SMTP id 4so1627816gyg.38
	for <alsa-devel@alsa-project.org>; Wed, 12 Oct 2011 23:57:37 -0700 (PDT)
In-Reply-To: <1318488008.2857.1.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Chip documentation explicitly requires that the reset values
of reserved register bits are left untouched.

codec->hw_read is broken now.
Here we use below trick to avoid writing to reserved registers while resume.
Write the register default value to cache for reserved registers,
so the write to the these registers are suppressed by the cache
restore code when it skips writes of default registers.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/sta32x.c |   28 +++++++++++++---------------
 1 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/sound/soc/codecs/sta32x.c b/sound/soc/codecs/sta32x.c
index 754b3ff..bb82408 100644
--- a/sound/soc/codecs/sta32x.c
+++ b/sound/soc/codecs/sta32x.c
@@ -756,21 +756,19 @@ static int sta32x_probe(struct snd_soc_codec *codec)
 		return ret;
 	}
 
-	/* preserve reset values of reserved register bits */
-	snd_soc_cache_write(codec, STA32X_CONFC,
-			    codec->hw_read(codec, STA32X_CONFC));
-	snd_soc_cache_write(codec, STA32X_CONFE,
-			    codec->hw_read(codec, STA32X_CONFE));
-	snd_soc_cache_write(codec, STA32X_CONFF,
-			    codec->hw_read(codec, STA32X_CONFF));
-	snd_soc_cache_write(codec, STA32X_MMUTE,
-			    codec->hw_read(codec, STA32X_MMUTE));
-	snd_soc_cache_write(codec, STA32X_AUTO1,
-			    codec->hw_read(codec, STA32X_AUTO1));
-	snd_soc_cache_write(codec, STA32X_AUTO3,
-			    codec->hw_read(codec, STA32X_AUTO3));
-	snd_soc_cache_write(codec, STA32X_C3CFG,
-			    codec->hw_read(codec, STA32X_C3CFG));
+	/* Chip documentation explicitly requires that the reset values
+	 * of reserved register bits are left untouched.
+	 * Write the register default value to cache for reserved registers,
+	 * so the write to the these registers are suppressed by the cache
+	 * restore code when it skips writes of default registers.
+	 */
+	snd_soc_cache_write(codec, STA32X_CONFC, 0xc2);
+	snd_soc_cache_write(codec, STA32X_CONFE, 0xc2);
+	snd_soc_cache_write(codec, STA32X_CONFF, 0x5c);
+	snd_soc_cache_write(codec, STA32X_MMUTE, 0x10);
+	snd_soc_cache_write(codec, STA32X_AUTO1, 0x60);
+	snd_soc_cache_write(codec, STA32X_AUTO3, 0x00);
+	snd_soc_cache_write(codec, STA32X_C3CFG, 0x40);
 
 	/* FIXME enable thermal warning adjustment and recovery  */
 	snd_soc_update_bits(codec, STA32X_CONFA,
-- 
1.7.4.1
