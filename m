From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 03/21] ASoC: es8316: remove unused constant variables
Date: Fri,  4 Jan 2019 20:02:31 -0600
Message-ID: <20190105020249.8639-4-pierre-louis.bossart@linux.intel.com>
References: <20190105020249.8639-1-pierre-louis.bossart@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190105020249.8639-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, broonie@kernel.org, liam.r.girdwood@linux.intel.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, open list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Fix warnings with W=1

If these variables are useful this driver should be modified to expose
them.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/es8316.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/sound/soc/codecs/es8316.c b/sound/soc/codecs/es8316.c
index e97d12d578b0..b10c4d812958 100644
--- a/sound/soc/codecs/es8316.c
+++ b/sound/soc/codecs/es8316.c
@@ -159,8 +159,6 @@ static const char * const es8316_hpmux_texts[] = {
 	"lin-rin with Boost and PGA"
 };
 
-static const unsigned int es8316_hpmux_values[] = { 0, 1, 2, 3 };
-
 static SOC_ENUM_SINGLE_DECL(es8316_left_hpmux_enum, ES8316_HPMIX_SEL,
 	4, es8316_hpmux_texts);
 
@@ -191,8 +189,6 @@ static const char * const es8316_dacsrc_texts[] = {
 	"RDATA TO LDAC, LDATA TO RDAC",
 };
 
-static const unsigned int es8316_dacsrc_values[] = { 0, 1, 2, 3 };
-
 static SOC_ENUM_SINGLE_DECL(es8316_dacsrc_mux_enum, ES8316_DAC_SET1,
 	6, es8316_dacsrc_texts);
 
-- 
2.17.1
