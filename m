From: Zidan Wang <zidan.wang@freescale.com>
Subject: [PATCH 4/4] ASoC: wm8960: correct the max register
	value of mic boost pga
Date: Fri, 18 Sep 2015 17:19:43 +0800
Message-ID: <119b66684faaf7ff237dfccc864ec8e0561aefd3.1442566367.git.zidan.wang@freescale.com>
References: <4c1fe5d2fa0ae6cf85e9be8b3b8a52feaae7d75b.1442566367.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0113.outbound.protection.outlook.com [207.46.100.113])
 by alsa0.perex.cz (Postfix) with ESMTP id 9843E265C96
 for <alsa-devel@alsa-project.org>; Fri, 18 Sep 2015 11:17:58 +0200 (CEST)
In-Reply-To: <4c1fe5d2fa0ae6cf85e9be8b3b8a52feaae7d75b.1442566367.git.zidan.wang@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: ckeepax@opensource.wolfsonmicro.com, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, Zidan Wang <zidan.wang@freescale.com>
List-Id: alsa-devel@alsa-project.org

the max register value of mic boost pga should be 3.

Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
---
 sound/soc/codecs/wm8960.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index 6975390..dbd8840 100644
--- a/sound/soc/codecs/wm8960.c
+++ b/sound/soc/codecs/wm8960.c
@@ -240,9 +240,9 @@ SOC_SINGLE_TLV("Left Input Boost Mixer LINPUT3 Volume",
 SOC_SINGLE_TLV("Left Input Boost Mixer LINPUT2 Volume",
 	       WM8960_INBMIX2, 1, 7, 0, lineinboost_tlv),
 SOC_SINGLE_TLV("Right Input Boost Mixer RINPUT1 Volume",
-		WM8960_RINPATH, 4, 4, 0, micboost_tlv),
+		WM8960_RINPATH, 4, 3, 0, micboost_tlv),
 SOC_SINGLE_TLV("Left Input Boost Mixer LINPUT1 Volume",
-		WM8960_LINPATH, 4, 4, 0, micboost_tlv),
+		WM8960_LINPATH, 4, 3, 0, micboost_tlv),
 
 SOC_DOUBLE_R_TLV("Playback Volume", WM8960_LDAC, WM8960_RDAC,
 		 0, 255, 0, dac_tlv),
-- 
1.9.1
