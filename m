From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Add some missing volume update bit sets
	for wm_hubs devices
Date: Sun, 15 May 2011 12:19:24 -0700
Message-ID: <1305487164-17716-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CA62624402
	for <alsa-devel@alsa-project.org>;
	Sun, 15 May 2011 21:19:27 +0200 (CEST)
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

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_hubs.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm_hubs.c b/sound/soc/codecs/wm_hubs.c
index c7c2fec..e55b298 100644
--- a/sound/soc/codecs/wm_hubs.c
+++ b/sound/soc/codecs/wm_hubs.c
@@ -836,17 +836,21 @@ int wm_hubs_add_analogue_controls(struct snd_soc_codec *codec)
 	snd_soc_update_bits(codec, WM8993_RIGHT_LINE_INPUT_3_4_VOLUME,
 			    WM8993_IN2_VU, WM8993_IN2_VU);
 
+	snd_soc_update_bits(codec, WM8993_SPEAKER_VOLUME_LEFT,
+			    WM8993_SPKOUT_VU, WM8993_SPKOUT_VU);
 	snd_soc_update_bits(codec, WM8993_SPEAKER_VOLUME_RIGHT,
 			    WM8993_SPKOUT_VU, WM8993_SPKOUT_VU);
 
 	snd_soc_update_bits(codec, WM8993_LEFT_OUTPUT_VOLUME,
-			    WM8993_HPOUT1L_ZC, WM8993_HPOUT1L_ZC);
+			    WM8993_HPOUT1_VU | WM8993_HPOUT1L_ZC,
+			    WM8993_HPOUT1_VU | WM8993_HPOUT1L_ZC);
 	snd_soc_update_bits(codec, WM8993_RIGHT_OUTPUT_VOLUME,
 			    WM8993_HPOUT1_VU | WM8993_HPOUT1R_ZC,
 			    WM8993_HPOUT1_VU | WM8993_HPOUT1R_ZC);
 
 	snd_soc_update_bits(codec, WM8993_LEFT_OPGA_VOLUME,
-			    WM8993_MIXOUTL_ZC, WM8993_MIXOUTL_ZC);
+			    WM8993_MIXOUTL_ZC | WM8993_MIXOUT_VU,
+			    WM8993_MIXOUTL_ZC | WM8993_MIXOUT_VU);
 	snd_soc_update_bits(codec, WM8993_RIGHT_OPGA_VOLUME,
 			    WM8993_MIXOUTR_ZC | WM8993_MIXOUT_VU,
 			    WM8993_MIXOUTR_ZC | WM8993_MIXOUT_VU);
-- 
1.7.5.1
