From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 4/4] ASoC: wm8994: Actively discharge VMID when
	not in use
Date: Sat, 11 Feb 2012 23:13:30 +0000
Message-ID: <1329002010-5688-4-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1329002010-5688-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A312F103AEA
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

Ensure we're in a known state when we restart.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8994.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index aa94ca1..3a69ec0 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -838,6 +838,10 @@ static void vmid_dereference(struct snd_soc_codec *codec)
 				    WM8994_BIAS_ENA |
 				    WM8994_VMID_SEL_MASK, 0);
 
+		/* Discharge VMID */
+		snd_soc_update_bits(codec, WM8994_ANTIPOP_2,
+				    WM8994_VMID_DISCH, WM8994_VMID_DISCH);
+
 		/* Discharge line */
 		snd_soc_update_bits(codec, WM8994_ANTIPOP_1,
 				    WM8994_LINEOUT1_DISCH |
-- 
1.7.9.rc1
