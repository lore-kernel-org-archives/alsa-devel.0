From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: bells: Fix up git patch application
	failure
Date: Fri, 16 Nov 2012 09:32:21 +0900
Message-ID: <1353025941-4677-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id EC7A7265CC7
 for <alsa-devel@alsa-project.org>; Fri, 16 Nov 2012 01:32:27 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

It seems git has been getting confused by the very similar contexts
for the speaker DAIs and has been applying patches to the wrong places
causing all sorts of confusion.  Fix this up by hand.

Reported-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/samsung/bells.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/samsung/bells.c b/sound/soc/samsung/bells.c
index b56b9a3..a2ca156 100644
--- a/sound/soc/samsung/bells.c
+++ b/sound/soc/samsung/bells.c
@@ -212,7 +212,7 @@ static struct snd_soc_dai_link bells_dai_wm5102[] = {
 	{
 		.name = "Sub",
 		.stream_name = "Sub",
-		.cpu_dai_name = "wm5110-aif3",
+		.cpu_dai_name = "wm5102-aif3",
 		.codec_dai_name = "wm9081-hifi",
 		.codec_name = "wm9081.1-006c",
 		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
@@ -247,7 +247,7 @@ static struct snd_soc_dai_link bells_dai_wm5110[] = {
 	{
 		.name = "Sub",
 		.stream_name = "Sub",
-		.cpu_dai_name = "wm5102-aif3",
+		.cpu_dai_name = "wm5110-aif3",
 		.codec_dai_name = "wm9081-hifi",
 		.codec_name = "wm9081.1-006c",
 		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
-- 
1.7.10.4
