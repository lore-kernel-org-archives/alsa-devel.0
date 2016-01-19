From: <stuarth@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm8960: Fix input boost mixer left/right
	naming
Date: Tue, 19 Jan 2016 13:09:08 +0000
Message-ID: <1453208949-23946-1-git-send-email-stuarth@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 717EE260536
 for <alsa-devel@alsa-project.org>; Tue, 19 Jan 2016 14:09:56 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: Stuart Henderson <stuart.henderson@cirrus.com>, alsa-devel@alsa-project.org, ckeepax@opensource.wolfsonmicro.com, zidan.wang@freescale.com
List-Id: alsa-devel@alsa-project.org

From: Stuart Henderson <stuart.henderson@cirrus.com>

INBMIX1 controls LINPUTs and INBMIX2 controls RINPUTs, so fix the naming
accordingly.

Signed-off-by: Stuart Henderson <stuart.henderson@cirrus.com>
---
 sound/soc/codecs/wm8960.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index ff23772..7f20fb2 100644
--- a/sound/soc/codecs/wm8960.c
+++ b/sound/soc/codecs/wm8960.c
@@ -240,13 +240,13 @@ SOC_DOUBLE_R("Capture Volume ZC Switch", WM8960_LINVOL, WM8960_RINVOL,
 SOC_DOUBLE_R("Capture Switch", WM8960_LINVOL, WM8960_RINVOL,
 	7, 1, 1),
 
-SOC_SINGLE_TLV("Right Input Boost Mixer RINPUT3 Volume",
+SOC_SINGLE_TLV("Left Input Boost Mixer LINPUT3 Volume",
 	       WM8960_INBMIX1, 4, 7, 0, lineinboost_tlv),
-SOC_SINGLE_TLV("Right Input Boost Mixer RINPUT2 Volume",
+SOC_SINGLE_TLV("Left Input Boost Mixer LINPUT2 Volume",
 	       WM8960_INBMIX1, 1, 7, 0, lineinboost_tlv),
-SOC_SINGLE_TLV("Left Input Boost Mixer LINPUT3 Volume",
+SOC_SINGLE_TLV("Right Input Boost Mixer RINPUT3 Volume",
 	       WM8960_INBMIX2, 4, 7, 0, lineinboost_tlv),
-SOC_SINGLE_TLV("Left Input Boost Mixer LINPUT2 Volume",
+SOC_SINGLE_TLV("Right Input Boost Mixer RINPUT2 Volume",
 	       WM8960_INBMIX2, 1, 7, 0, lineinboost_tlv),
 SOC_SINGLE_TLV("Right Input Boost Mixer RINPUT1 Volume",
 		WM8960_RINPATH, 4, 3, 0, micboost_tlv),
-- 
2.1.4
