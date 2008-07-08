From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: [PATCH] asoc: n810 - fix build error.
Date: Tue, 08 Jul 2008 13:20:39 +0100
Message-ID: <1215519639.4882.210.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0A302243BA
	for <alsa-devel@alsa-project.org>;
	Tue,  8 Jul 2008 14:20:40 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


This patch adds a missing " that was recently introduced (removed)
in the DAI struct merge patch series.

Signed-off-by: Liam Girdwood <lg@opensource.wolfsonmicro.com>
---
 sound/soc/omap/n810.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/omap/n810.c b/sound/soc/omap/n810.c
index e53c055..02cec96 100644
--- a/sound/soc/omap/n810.c
+++ b/sound/soc/omap/n810.c
@@ -63,7 +63,7 @@ static void n810_ext_control(struct snd_soc_codec *codec)
 	if (n810_dmic_func)
 		snd_soc_dapm_enable_pin(codec, "DMic");
 	else
-		snd_soc_dapm_disable_pin(codec, "DMic);
+		snd_soc_dapm_disable_pin(codec, "DMic");
 
 	snd_soc_dapm_sync(codec);
 }
-- 
1.5.4.2
