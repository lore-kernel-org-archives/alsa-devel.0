From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 3/4] ASoC: wm8994: VMID management improvements
Date: Sat, 11 Feb 2012 23:13:29 +0000
Message-ID: <1329002010-5688-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1329002010-5688-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 08811103AFE
	for <alsa-devel@alsa-project.org>; Sun, 12 Feb 2012 00:13:35 +0100 (CET)
In-Reply-To: <1329002010-5688-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

Raise the ramp time to 50ms to cover corner cases, use the startup bias
generator, explicitly reset the ramp circuit when complete and reorder
things all of which should improve performance somewhat for systems that
are sensitive to noise from VMID.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8994.c |   20 ++++++++++++++------
 1 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 21931a0..aa94ca1 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -778,29 +778,37 @@ static void vmid_reference(struct snd_soc_codec *codec)
 		wm8994->vmid_refcount);
 
 	if (wm8994->vmid_refcount == 1) {
+		snd_soc_update_bits(codec, WM8994_ANTIPOP_1,
+				    WM8994_LINEOUT_VMID_BUF_ENA |
+				    WM8994_LINEOUT1_DISCH |
+				    WM8994_LINEOUT2_DISCH,
+				    WM8994_LINEOUT_VMID_BUF_ENA);
+
 		/* Startup bias, VMID ramp & buffer */
 		snd_soc_update_bits(codec, WM8994_ANTIPOP_2,
+				    WM8994_BIAS_SRC |
+				    WM8994_VMID_DISCH |
 				    WM8994_STARTUP_BIAS_ENA |
 				    WM8994_VMID_BUF_ENA |
 				    WM8994_VMID_RAMP_MASK,
+				    WM8994_BIAS_SRC |
 				    WM8994_STARTUP_BIAS_ENA |
 				    WM8994_VMID_BUF_ENA |
 				    (0x3 << WM8994_VMID_RAMP_SHIFT));
 
 		wm_hubs_vmid_ena(codec);
 
-		/* Remove discharge for line out */
-		snd_soc_update_bits(codec, WM8994_ANTIPOP_1,
-				    WM8994_LINEOUT1_DISCH |
-				    WM8994_LINEOUT2_DISCH, 0);
-
 		/* Main bias enable, VMID=2x40k */
 		snd_soc_update_bits(codec, WM8994_POWER_MANAGEMENT_1,
 				    WM8994_BIAS_ENA |
 				    WM8994_VMID_SEL_MASK,
 				    WM8994_BIAS_ENA | 0x2);
 
-		msleep(20);
+		msleep(50);
+
+		snd_soc_update_bits(codec, WM8994_ANTIPOP_2,
+				    WM8994_VMID_RAMP_MASK | WM8994_BIAS_SRC,
+				    0);
 	}
 }
 
-- 
1.7.9.rc1
