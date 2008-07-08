From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: [PATCH] asoc: at32 - DAI struct merge and enable_pin()
	change.
Date: Tue, 08 Jul 2008 13:21:52 +0100
Message-ID: <1215519712.4882.212.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 377AE243CC
	for <alsa-devel@alsa-project.org>;
	Tue,  8 Jul 2008 14:21:53 +0200 (CEST)
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


This adds support for the recent DAI struct merge and new DAPM pin API.

Signed-off-by: Liam Girdwood <lg@opensource.wolfsonmicro.com>
---
 sound/soc/at32/playpaq_wm8510.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/at32/playpaq_wm8510.c b/sound/soc/at32/playpaq_wm8510.c
index fd62f25..fee5f8e 100644
--- a/sound/soc/at32/playpaq_wm8510.c
+++ b/sound/soc/at32/playpaq_wm8510.c
@@ -341,15 +341,15 @@ static int playpaq_wm8510_init(struct snd_soc_codec *codec)
 	}
 
 
-	/* always connected endpoints */
-	snd_soc_dapm_set_endpoint(codec, "Int Mic", 1);
-	snd_soc_dapm_set_endpoint(codec, "Ext Spk", 1);
-	snd_soc_dapm_sync_endpoints(codec);
+	/* always connected pins */
+	snd_soc_dapm_enable_pin(codec, "Int Mic");
+	snd_soc_dapm_enable_pin(codec, "Ext Spk");
+	snd_soc_dapm_sync(codec);
 
 
 
 	/* Make CSB show PLL rate */
-	codec->dai->dai_ops.set_clkdiv(codec->dai, WM8510_OPCLKDIV,
+	snd_soc_dai_set_clkdiv(codec->dai, WM8510_OPCLKDIV,
 				       WM8510_OPCLKDIV_1 | 4);
 
 	return 0;
-- 
1.5.4.2
