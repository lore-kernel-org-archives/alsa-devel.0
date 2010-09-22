From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Fix incorrect parameter to
	snd_soc_codec_volatile_register
Date: Wed, 22 Sep 2010 16:16:06 +0100
Message-ID: <1285168566-20226-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 90247103903
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Sep 2010 17:16:12 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

We need to pass the register index and not the register value.
This patch depends on my previous patch "ASoC: Delegate to hw
specific read for volatile registers".

Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
---
 sound/soc/soc-cache.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
index 5d9d2f8..3e4680b 100644
--- a/sound/soc/soc-cache.c
+++ b/sound/soc/soc-cache.c
@@ -177,7 +177,7 @@ static int snd_soc_8_8_write(struct snd_soc_codec *codec, unsigned int reg,
 	data[0] = reg;
 	data[1] = value & 0xff;
 
-	if (!snd_soc_codec_volatile_register(codec, value) &&
+	if (!snd_soc_codec_volatile_register(codec, reg) &&
 		reg < codec->driver->reg_cache_size)
 			cache[reg] = value;
 
-- 
1.7.3
