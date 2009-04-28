From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: [PATCH] ASoC: TWL4030: Fix gain control for earpiece
 amplifier
Date: Tue, 28 Apr 2009 18:18:05 +0900
Message-ID: <49F6C9CD.1020808@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	by alsa0.perex.cz (Postfix) with ESMTP id 42B8910384F
	for <alsa-devel@alsa-project.org>;
	Tue, 28 Apr 2009 11:18:07 +0200 (CEST)
Received: from epmmp2 (mailout2.samsung.com [203.254.224.25])
	by mailout2.samsung.com
	(iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
	with ESMTP id <0KIT0042P0I5GK@mailout2.samsung.com> for
	alsa-devel@alsa-project.org; Tue, 28 Apr 2009 18:18:05 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
	by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
	2004)) with ESMTPA id <0KIT006XQ0I6PW@mmp2.samsung.com> for
	alsa-devel@alsa-project.org; Tue, 28 Apr 2009 18:18:06 +0900 (KST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: kyungmin.park@samsung.com, broonie@opensource.wolfsonmicro.com, peter.ujfalusi@nokia.com, bhmin@samsung.com
List-Id: alsa-devel@alsa-project.org

The gain control for earpiece amplifier uses 0dB ~ 12dB according to the
TRM, but the present code is implemented to -6dB ~ 6dB.

Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
---
 sound/soc/codecs/twl4030.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index a7875c2..bf522a9 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -785,6 +785,12 @@ static DECLARE_TLV_DB_SCALE(analog_tlv, -2400, 200, 0);
 static DECLARE_TLV_DB_SCALE(output_tvl, -1200, 600, 1);
 
 /*
+ * Gain control for earpiece amplifier
+ * 0 dB to 12 dB in 6 dB steps (mute instead of -6)
+ */
+static DECLARE_TLV_DB_SCALE(output_ear_tvl, -600, 600, 1);
+
+/*
  * Capture gain after the ADCs
  * from 0 dB to 31 dB in 1 dB steps
  */
@@ -859,7 +865,7 @@ static const struct snd_kcontrol_new twl4030_snd_controls[] = {
 		4, 3, 0, output_tvl),
 
 	SOC_SINGLE_TLV_TWL4030("Earpiece Playback Volume",
-		TWL4030_REG_EAR_CTL, 4, 3, 0, output_tvl),
+		TWL4030_REG_EAR_CTL, 4, 3, 0, output_ear_tvl),
 
 	/* Common capture gain controls */
 	SOC_DOUBLE_R_TLV("TX1 Digital Capture Volume",
-- 
1.6.0.4
