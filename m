From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm8994: Fix some indentation issues
Date: Thu, 26 Jul 2012 14:49:51 +0100
Message-ID: <1343310591-23553-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 289CB265B8A
 for <alsa-devel@alsa-project.org>; Thu, 26 Jul 2012 15:56:24 +0200 (CEST)
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

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8994.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index e0125e3..eaa77f9 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -2273,7 +2273,7 @@ static int _wm8994_set_fll(struct snd_soc_codec *codec, int id, int src,
 
 	snd_soc_update_bits(codec, WM8994_FLL1_CONTROL_4 + reg_offset,
 			    WM8994_FLL1_N_MASK,
-				    fll.n << WM8994_FLL1_N_SHIFT);
+			    fll.n << WM8994_FLL1_N_SHIFT);
 
 	snd_soc_update_bits(codec, WM8994_FLL1_CONTROL_5 + reg_offset,
 			    WM8994_FLL1_FRC_NCO | WM8958_FLL1_BYP |
@@ -3501,7 +3501,7 @@ static void wm8958_default_micdet(u16 status, void *data)
 
 			snd_soc_jack_report(wm8994->micdet[0].jack, 0,
 					    wm8994->btn_mask |
-					     SND_JACK_HEADSET);
+					    SND_JACK_HEADSET);
 		}
 		return;
 	}
-- 
1.7.10.4
