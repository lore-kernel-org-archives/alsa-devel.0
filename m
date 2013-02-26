From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 3/3] ASoC: wm8994: Remove duplicate headset
	report
Date: Tue, 26 Feb 2013 17:15:34 +0000
Message-ID: <1361898934-615-5-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1361898934-615-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id F30F8265327
 for <alsa-devel@alsa-project.org>; Tue, 26 Feb 2013 18:15:40 +0100 (CET)
In-Reply-To: <1361898934-615-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

We do the same report a few lines earlier for no good reason.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8994.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 1d98f28..8d77c8b 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -3541,9 +3541,6 @@ static void wm8958_mic_id(void *data, u16 status)
 
 		/* If we have jackdet that will detect removal */
 		wm1811_micd_stop(codec);
-
-		snd_soc_jack_report(wm8994->micdet[0].jack, SND_JACK_HEADPHONE,
-				    SND_JACK_HEADSET);
 	}
 }
 
-- 
1.7.10.4
