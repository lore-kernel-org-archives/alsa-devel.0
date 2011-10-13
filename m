From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 1/3] ASoC: alc5623: Convert codec->hw_read to
	regmap_read
Date: Thu, 13 Oct 2011 15:22:55 +0800
Message-ID: <1318490575.2857.8.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 818E11039A7
	for <alsa-devel@alsa-project.org>;
	Thu, 13 Oct 2011 09:23:03 +0200 (CEST)
Received: by ywn1 with SMTP id 1so917089ywn.38
	for <alsa-devel@alsa-project.org>; Thu, 13 Oct 2011 00:23:02 -0700 (PDT)
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Arnaud Patard <arnaud.patard@rtp-net.org>
List-Id: alsa-devel@alsa-project.org

codec->hw_read is broken now, let's covert to regmap_read.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/alc5623.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/alc5623.c b/sound/soc/codecs/alc5623.c
index 557b3af..8c156cb 100644
--- a/sound/soc/codecs/alc5623.c
+++ b/sound/soc/codecs/alc5623.c
@@ -51,10 +51,13 @@ static void alc5623_fill_cache(struct snd_soc_codec *codec)
 {
 	int i, step = codec->driver->reg_cache_step;
 	u16 *cache = codec->reg_cache;
+	unsigned int val;
 
 	/* not really efficient ... */
-	for (i = 0 ; i < codec->driver->reg_cache_size ; i += step)
-		cache[i] = codec->hw_read(codec, i);
+	for (i = 0 ; i < codec->driver->reg_cache_size ; i += step) {
+		regmap_read(codec->control_data, i, &val);
+		cache[i] = val;
+	}
 }
 
 static inline int alc5623_reset(struct snd_soc_codec *codec)
-- 
1.7.4.1
