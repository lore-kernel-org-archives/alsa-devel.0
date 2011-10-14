From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 2/3] ASoC: tlv320aic3x: Convert codec->hw_read
 to snd_soc_read
Date: Fri, 14 Oct 2011 09:37:00 +0800
Message-ID: <1318556220.6379.3.camel@phoenix>
References: <1318556120.6379.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id EDE3024153
	for <alsa-devel@alsa-project.org>;
	Fri, 14 Oct 2011 03:37:07 +0200 (CEST)
Received: by gyg8 with SMTP id 8so682737gyg.38
	for <alsa-devel@alsa-project.org>; Thu, 13 Oct 2011 18:37:07 -0700 (PDT)
In-Reply-To: <1318556120.6379.1.camel@phoenix>
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
Cc: Vladimir Barinov <vbarinov@embeddedalley.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

codec->hw_read is broken now, let's covert to snd_soc_read.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/tlv320aic3x.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index be55b7f..7a49390 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -137,7 +137,10 @@ static int aic3x_read(struct snd_soc_codec *codec, unsigned int reg,
 	if (reg >= AIC3X_CACHEREGNUM)
 		return -1;
 
-	*value = codec->hw_read(codec, reg);
+	codec->cache_bypass = 1;
+	*value = snd_soc_read(codec, reg);
+	codec->cache_bypass = 0;
+
 	cache[reg] = *value;
 
 	return 0;
-- 
1.7.4.1
