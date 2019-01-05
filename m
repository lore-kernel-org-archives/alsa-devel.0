From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 15/21] ASoC: nau8824: fix boolean assignment
Date: Fri,  4 Jan 2019 20:02:43 -0600
Message-ID: <20190105020249.8639-16-pierre-louis.bossart@linux.intel.com>
References: <20190105020249.8639-1-pierre-louis.bossart@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190105020249.8639-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, broonie@kernel.org, liam.r.girdwood@linux.intel.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, John Hsu <KCHSU0@nuvoton.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Colin Ian King <colin.king@canonical.com>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, open list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Reported by Coccinelle:
nau8824.c:810:6-12: ERROR: Assignment of bool to non-0/1 constant

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/nau8824.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/nau8824.c b/sound/soc/codecs/nau8824.c
index 468d5143e2c4..87ed3dc496dc 100644
--- a/sound/soc/codecs/nau8824.c
+++ b/sound/soc/codecs/nau8824.c
@@ -807,7 +807,7 @@ static const struct snd_soc_dapm_route nau8824_dapm_routes[] = {
 static bool nau8824_is_jack_inserted(struct nau8824 *nau8824)
 {
 	struct snd_soc_jack *jack = nau8824->jack;
-	bool insert = FALSE;
+	bool insert = false;
 
 	if (nau8824->irq && jack)
 		insert = jack->status & SND_JACK_HEADPHONE;
-- 
2.17.1
