From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH 1/3] ASoC: wm5110: Set symmetric samplebits on AIFs
Date: Tue, 22 Jul 2014 11:50:22 +0100
Message-ID: <20140722105022.GB19663@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.de, broonie@kernel.org
Cc: lgirdwood@gmail.com, Li.Xiubo@freescale.com, lars@metafoo.de, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Different playback and capture bits-per-sample
are not supported on the AIFs

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm5110.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index 62ef544..2f2ec26 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -1485,6 +1485,7 @@ static struct snd_soc_dai_driver wm5110_dai[] = {
 		 },
 		.ops = &arizona_dai_ops,
 		.symmetric_rates = 1,
+		.symmetric_samplebits = 1,
 	},
 	{
 		.name = "wm5110-aif2",
@@ -1506,6 +1507,7 @@ static struct snd_soc_dai_driver wm5110_dai[] = {
 		 },
 		.ops = &arizona_dai_ops,
 		.symmetric_rates = 1,
+		.symmetric_samplebits = 1,
 	},
 	{
 		.name = "wm5110-aif3",
@@ -1527,6 +1529,7 @@ static struct snd_soc_dai_driver wm5110_dai[] = {
 		 },
 		.ops = &arizona_dai_ops,
 		.symmetric_rates = 1,
+		.symmetric_samplebits = 1,
 	},
 	{
 		.name = "wm5110-slim1",
-- 
1.7.2.5
