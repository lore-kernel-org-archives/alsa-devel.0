From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: soc-cache: Use BUG_ON() for unsupported
	hw_read() calls
Date: Mon,  8 Nov 2010 15:37:07 +0000
Message-ID: <1289230627-15353-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5B787243FA
	for <alsa-devel@alsa-project.org>; Mon,  8 Nov 2010 16:37:11 +0100 (CET)
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

Instead of dereferencing a NULL function pointer and falling apart
use BUG_ON() for any unimplemented hw_read() calls.

Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
---
 sound/soc/soc-cache.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
index 8785a0c..e747998 100644
--- a/sound/soc/soc-cache.c
+++ b/sound/soc/soc-cache.c
@@ -25,6 +25,7 @@ static unsigned int snd_soc_4_12_read(struct snd_soc_codec *codec,
 			if (codec->cache_only)
 				return -1;
 
+			BUG_ON(!codec->hw_read);
 			return codec->hw_read(codec, reg);
 	}
 
@@ -99,6 +100,7 @@ static unsigned int snd_soc_7_9_read(struct snd_soc_codec *codec,
 			if (codec->cache_only)
 				return -1;
 
+			BUG_ON(!codec->hw_read);
 			return codec->hw_read(codec, reg);
 	}
 
@@ -199,6 +201,7 @@ static unsigned int snd_soc_8_8_read(struct snd_soc_codec *codec,
 			if (codec->cache_only)
 				return -1;
 
+			BUG_ON(!codec->hw_read);
 			return codec->hw_read(codec, reg);
 	}
 
@@ -270,6 +273,7 @@ static unsigned int snd_soc_8_16_read(struct snd_soc_codec *codec,
 		if (codec->cache_only)
 			return -1;
 
+		BUG_ON(!codec->hw_read);
 		return codec->hw_read(codec, reg);
 	} else {
 		return cache[reg];
@@ -420,6 +424,7 @@ static unsigned int snd_soc_16_8_read(struct snd_soc_codec *codec,
 			if (codec->cache_only)
 				return -1;
 
+			BUG_ON(!codec->hw_read);
 			return codec->hw_read(codec, reg);
 	}
 
@@ -531,6 +536,7 @@ static unsigned int snd_soc_16_16_read(struct snd_soc_codec *codec,
 		if (codec->cache_only)
 			return -1;
 
+		BUG_ON(!codec->hw_read);
 		return codec->hw_read(codec, reg);
 	}
 
-- 
1.7.3.2
