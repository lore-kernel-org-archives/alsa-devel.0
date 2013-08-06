From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/3] ASoC: twl4030: Remove embedded
	snd_soc_codec structs from private data structs
Date: Tue,  6 Aug 2013 13:39:30 +0200
Message-ID: <1375789171-12098-2-git-send-email-lars@metafoo.de>
References: <1375789171-12098-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-024.synserver.de (smtp-out-024.synserver.de
 [212.40.185.24])
 by alsa0.perex.cz (Postfix) with ESMTP id BD56C265338
 for <alsa-devel@alsa-project.org>; Tue,  6 Aug 2013 13:38:44 +0200 (CEST)
In-Reply-To: <1375789171-12098-1-git-send-email-lars@metafoo.de>
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
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

It is unused and a leftover of the pre multi-component era.

Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/twl4030.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index 8e6e5b0..1e3884d 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -137,8 +137,6 @@ static const u8 twl4030_reg[TWL4030_CACHEREGNUM] = {
 
 /* codec private data */
 struct twl4030_priv {
-	struct snd_soc_codec codec;
-
 	unsigned int codec_powered;
 
 	/* reference counts of AIF/APLL users */
-- 
1.8.0
