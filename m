From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Correct definition of WM8903_VMID_RES_5K
Date: Mon, 21 Feb 2011 18:57:35 +0000
Message-ID: <1298314655-5596-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 84A421037EE
	for <alsa-devel@alsa-project.org>; Mon, 21 Feb 2011 19:57:37 +0100 (CET)
In-Reply-To: <>
References: <>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8903.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm8903.h b/sound/soc/codecs/wm8903.h
index 7d96646..ed4cb5b 100644
--- a/sound/soc/codecs/wm8903.h
+++ b/sound/soc/codecs/wm8903.h
@@ -183,7 +183,7 @@ extern int wm8903_mic_detect(struct snd_soc_codec *codec,
 
 #define WM8903_VMID_RES_50K                          2
 #define WM8903_VMID_RES_250K                         3
-#define WM8903_VMID_RES_5K                           4
+#define WM8903_VMID_RES_5K                           6
 
 /*
  * R8 (0x08) - Analogue DAC 0
-- 
1.7.2.3
