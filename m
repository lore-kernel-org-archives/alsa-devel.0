From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 1/2] ASoC: remove one extraneous 'const'
Date: Tue, 14 Jun 2016 12:17:52 +0200
Message-ID: <5926900.hCFXH4RQH6@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Richard Fitzgerald <rf@opensource.wolfsonmicro.com>, Nikesh Oswal <Nikesh.Oswal@cirrus.com>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

A recent commit made a few arrays 'const', but also added the
same attribute to a function return type, where it makes no
sense, and we get a warning when building with W=1:

sound/soc/codecs/arizona.c:1725:27: error: type qualifiers ignored on function return type [-Werror=ignored-qualifiers]
 static const char * const arizona_dai_clk_str(int clk_id)

This removes it again.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: a3178a3ed798 ("ASoC: arizona: Add a couple of missing consts")
---
This is one of two patches for warnings that were introduced first in
today's linux-next.

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index ed0425763755..ecfdbfcae366 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -1722,7 +1722,7 @@ restore_aif:
 	return ret;
 }
 
-static const char * const arizona_dai_clk_str(int clk_id)
+static const char *arizona_dai_clk_str(int clk_id)
 {
 	switch (clk_id) {
 	case ARIZONA_CLK_SYSCLK:
