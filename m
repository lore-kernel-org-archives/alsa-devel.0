From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: core: Split the union for CODEC/platform
	in the DAI
Date: Fri,  2 Mar 2012 16:19:11 +0000
Message-ID: <1330705151-8316-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7716C2454E
	for <alsa-devel@alsa-project.org>; Fri,  2 Mar 2012 17:19:14 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

There's now core code which falls back to global CODEC operations for
DAI calls that needs to be able to tell if it's dealing with a CPU or
CODEC DAI and given the small number of DAIs in a typical system and
overall memory usage pattern saving a pointer per DAI is really not
worth the effort.

Reported-by: Ian Lartey <ian@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc-dai.h |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index d474128..868f4b6 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -250,10 +250,9 @@ struct snd_soc_dai {
 	unsigned int rate;
 
 	/* parent platform/codec */
-	union {
-		struct snd_soc_platform *platform;
-		struct snd_soc_codec *codec;
-	};
+	struct snd_soc_platform *platform;
+	struct snd_soc_codec *codec;
+
 	struct snd_soc_card *card;
 
 	struct list_head list;
-- 
1.7.9.1
