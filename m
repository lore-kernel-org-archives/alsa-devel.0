From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm8994: Fix typo in VMID ramp setting
Date: Tue,  7 Feb 2012 19:02:14 +0000
Message-ID: <1328641334-30169-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E8D13103C5A
	for <alsa-devel@alsa-project.org>; Tue,  7 Feb 2012 20:02:18 +0100 (CET)
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

The VMID ramp rate is supposed to be 3b, not 0x11. Fix that.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8994.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 81795eb..b75a652 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -785,7 +785,7 @@ static void vmid_reference(struct snd_soc_codec *codec)
 				    WM8994_VMID_RAMP_MASK,
 				    WM8994_STARTUP_BIAS_ENA |
 				    WM8994_VMID_BUF_ENA |
-				    (0x11 << WM8994_VMID_RAMP_SHIFT));
+				    (0x3 << WM8994_VMID_RAMP_SHIFT));
 
 		/* Main bias enable, VMID=2x40k */
 		snd_soc_update_bits(codec, WM8994_POWER_MANAGEMENT_1,
-- 
1.7.9.rc1
