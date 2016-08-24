From: Nicolas Iooss <nicolas.iooss_linux@m4x.org>
Subject: [PATCH v2 1/2] ASoC: simple-card-utils: add __printf attribute
Date: Wed, 24 Aug 2016 17:23:47 +0200
Message-ID: <20160824152348.2048-1-nicolas.iooss_linux@m4x.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

asoc_simple_card_set_dailink_name() uses devm_kvasprintf() to format
some of its arguments.  Adding a __printf attribute to this function
makes it possible to detect at compile-time errors related to format
strings.

Signed-off-by: Nicolas Iooss <nicolas.iooss_linux@m4x.org>
---
 include/sound/simple_card_utils.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/sound/simple_card_utils.h b/include/sound/simple_card_utils.h
index 86088aed9002..3207b1a70d38 100644
--- a/include/sound/simple_card_utils.h
+++ b/include/sound/simple_card_utils.h
@@ -27,6 +27,7 @@ int asoc_simple_card_parse_daifmt(struct device *dev,
 				  struct device_node *codec,
 				  char *prefix,
 				  unsigned int *retfmt);
+__printf(3, 4)
 int asoc_simple_card_set_dailink_name(struct device *dev,
 				      struct snd_soc_dai_link *dai_link,
 				      const char *fmt, ...);
-- 
2.9.3
