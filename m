From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm8994: Use fast VMID ramp
Date: Tue,  6 Mar 2012 00:08:41 +0000
Message-ID: <1330992521-16560-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9592624352
	for <alsa-devel@alsa-project.org>; Tue,  6 Mar 2012 01:08:47 +0100 (CET)
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
 sound/soc/codecs/wm8994.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 581049a..a6df001 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -808,7 +808,7 @@ static void vmid_reference(struct snd_soc_codec *codec)
 				    WM8994_BIAS_SRC |
 				    WM8994_STARTUP_BIAS_ENA |
 				    WM8994_VMID_BUF_ENA |
-				    (0x0 << WM8994_VMID_RAMP_SHIFT));
+				    (0x3 << WM8994_VMID_RAMP_SHIFT));
 
 		/* Main bias enable, VMID=2x40k */
 		snd_soc_update_bits(codec, WM8994_POWER_MANAGEMENT_1,
@@ -816,7 +816,7 @@ static void vmid_reference(struct snd_soc_codec *codec)
 				    WM8994_VMID_SEL_MASK,
 				    WM8994_BIAS_ENA | 0x2);
 
-		msleep(100);
+		msleep(50);
 
 		snd_soc_update_bits(codec, WM8994_ANTIPOP_2,
 				    WM8994_VMID_RAMP_MASK | WM8994_BIAS_SRC,
-- 
1.7.9.1
