From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH 3/3] ASoC: wm8997: Set symmetric samplebits on AIFs
Date: Tue, 22 Jul 2014 11:52:56 +0100
Message-ID: <20140722105256.GD19663@opensource.wolfsonmicro.com>
References: <20140722105022.GB19663@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140722105022.GB19663@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.de, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, Li.Xiubo@freescale.com
List-Id: alsa-devel@alsa-project.org

Different playback and capture bits-per-sample
are not supported on the AIFs

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8997.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm8997.c b/sound/soc/codecs/wm8997.c
index bb9b47b..ab33fe5 100644
--- a/sound/soc/codecs/wm8997.c
+++ b/sound/soc/codecs/wm8997.c
@@ -967,6 +967,7 @@ static struct snd_soc_dai_driver wm8997_dai[] = {
 		 },
 		.ops = &arizona_dai_ops,
 		.symmetric_rates = 1,
+		.symmetric_samplebits = 1,
 	},
 	{
 		.name = "wm8997-aif2",
@@ -988,6 +989,7 @@ static struct snd_soc_dai_driver wm8997_dai[] = {
 		 },
 		.ops = &arizona_dai_ops,
 		.symmetric_rates = 1,
+		.symmetric_samplebits = 1,
 	},
 	{
 		.name = "wm8997-slim1",
-- 
1.7.2.5
