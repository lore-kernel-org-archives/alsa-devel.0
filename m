From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 2/2] ASoC: wm8741: Use snd_soc_cache_sync to
 sync reg_cache with the hardware
Date: Mon, 17 Oct 2011 20:16:37 +0800
Message-ID: <1318853797.4642.3.camel@phoenix>
References: <1318853696.4642.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f171.google.com (mail-yx0-f171.google.com
	[209.85.213.171])
	by alsa0.perex.cz (Postfix) with ESMTP id DDF9C243FA
	for <alsa-devel@alsa-project.org>;
	Mon, 17 Oct 2011 14:16:43 +0200 (CEST)
Received: by yxl11 with SMTP id 11so3236132yxl.30
	for <alsa-devel@alsa-project.org>; Mon, 17 Oct 2011 05:16:43 -0700 (PDT)
In-Reply-To: <1318853696.4642.1.camel@phoenix>
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
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/wm8741.c |   10 +---------
 1 files changed, 1 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/wm8741.c b/sound/soc/codecs/wm8741.c
index 85ebe02..57ad22a 100644
--- a/sound/soc/codecs/wm8741.c
+++ b/sound/soc/codecs/wm8741.c
@@ -404,15 +404,7 @@ static struct snd_soc_dai_driver wm8741_dai = {
 #ifdef CONFIG_PM
 static int wm8741_resume(struct snd_soc_codec *codec)
 {
-	u16 *cache = codec->reg_cache;
-	int i;
-
-	/* RESTORE REG Cache */
-	for (i = 0; i < WM8741_REGISTER_COUNT; i++) {
-		if (cache[i] == wm8741_reg_defaults[i] || WM8741_RESET == i)
-			continue;
-		snd_soc_write(codec, i, cache[i]);
-	}
+	snd_soc_cache_sync(codec);
 	return 0;
 }
 #else
-- 
1.7.5.4
