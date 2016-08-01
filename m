From: Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH] ASoC: simple-card: fix module load "unknown symbol" issue
Date: Mon,  1 Aug 2016 16:36:08 -0700
Message-ID: <20160801233610.10479-1-khilman@baylibre.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Sekhar Nori <nsekhar@ti.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, open list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

An ASoC driver using simple-card, when built as a module gets the
following error at module load time:

[   23.571873] simple_card_utils: Unknown symbol snd_soc_of_parse_daifmt (err 0)
[   23.712726] simple_card_utils: Unknown symbol snd_soc_of_parse_card_name (err 0)

fix this by including simple-card-utils.o symbols in the module build
its symols are resolved correctly.

Tested on Davinci DA850-EVM using snd_soc_edma, snc_soc_davinci_mcasp,
with all of ASoC built as modules.

Cc: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
---
 sound/soc/generic/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/generic/Makefile b/sound/soc/generic/Makefile
index 45602ca8536e..ff0c55eee4f7 100644
--- a/sound/soc/generic/Makefile
+++ b/sound/soc/generic/Makefile
@@ -2,4 +2,8 @@ obj-$(CONFIG_SND_SIMPLE_CARD_UTILS) := simple-card-utils.o
 
 snd-soc-simple-card-objs	:= simple-card.o
 
+ifneq ($(CONFIG_SND_SIMPLE_CARD_UTILS),)
+snd-soc-simple-card-objs	+=  simple-card-utils.o
+endif
+
 obj-$(CONFIG_SND_SIMPLE_CARD)	+= snd-soc-simple-card.o
-- 
2.9.0
