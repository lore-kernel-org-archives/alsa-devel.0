From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH 2/3] ASoC: wm5102: Set symmetric samplebits on AIFs
Date: Tue, 22 Jul 2014 11:51:57 +0100
Message-ID: <20140722105157.GC19663@opensource.wolfsonmicro.com>
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
 sound/soc/codecs/wm5102.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm5102.c b/sound/soc/codecs/wm5102.c
index fa24d55..f602349 100644
--- a/sound/soc/codecs/wm5102.c
+++ b/sound/soc/codecs/wm5102.c
@@ -1715,6 +1715,7 @@ static struct snd_soc_dai_driver wm5102_dai[] = {
 		 },
 		.ops = &arizona_dai_ops,
 		.symmetric_rates = 1,
+		.symmetric_samplebits = 1,
 	},
 	{
 		.name = "wm5102-aif2",
@@ -1736,6 +1737,7 @@ static struct snd_soc_dai_driver wm5102_dai[] = {
 		 },
 		.ops = &arizona_dai_ops,
 		.symmetric_rates = 1,
+		.symmetric_samplebits = 1,
 	},
 	{
 		.name = "wm5102-aif3",
@@ -1757,6 +1759,7 @@ static struct snd_soc_dai_driver wm5102_dai[] = {
 		 },
 		.ops = &arizona_dai_ops,
 		.symmetric_rates = 1,
+		.symmetric_samplebits = 1,
 	},
 	{
 		.name = "wm5102-slim1",
-- 
1.7.2.5
