From: Zidan Wang <zidan.wang@freescale.com>
Subject: [PATCH 1/2] ASoC: wm8960: correct the min gain value
	of some PGA
Date: Wed, 9 Sep 2015 19:29:10 +0800
Message-ID: <22ae1784eb84bf45b23bb7095b7dea8a116c0c2c.1441798038.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bbn0103.outbound.protection.outlook.com [157.56.111.103])
 by alsa0.perex.cz (Postfix) with ESMTP id 59F092604AA
 for <alsa-devel@alsa-project.org>; Wed,  9 Sep 2015 13:27:33 +0200 (CEST)
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

The min gain is the corresponding gain value when the register value is 0
instead of 1, just correct it.

Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
---
 sound/soc/codecs/wm8960.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index e3b7d0c..6163474 100644
--- a/sound/soc/codecs/wm8960.c
+++ b/sound/soc/codecs/wm8960.c
@@ -211,11 +211,11 @@ static int wm8960_put_deemph(struct snd_kcontrol *kcontrol,
 	return wm8960_set_deemph(codec);
 }
 
-static const DECLARE_TLV_DB_SCALE(adc_tlv, -9700, 50, 0);
-static const DECLARE_TLV_DB_SCALE(dac_tlv, -12700, 50, 1);
+static const DECLARE_TLV_DB_SCALE(adc_tlv, -9750, 50, 1);
+static const DECLARE_TLV_DB_SCALE(dac_tlv, -12750, 50, 1);
 static const DECLARE_TLV_DB_SCALE(bypass_tlv, -2100, 300, 0);
 static const DECLARE_TLV_DB_SCALE(out_tlv, -12100, 100, 1);
-static const DECLARE_TLV_DB_SCALE(boost_tlv, -1200, 300, 1);
+static const DECLARE_TLV_DB_SCALE(boost_tlv, -1500, 300, 1);
 
 static const struct snd_kcontrol_new wm8960_snd_controls[] = {
 SOC_DOUBLE_R_TLV("Capture Volume", WM8960_LINVOL, WM8960_RINVOL,
-- 
1.9.1
