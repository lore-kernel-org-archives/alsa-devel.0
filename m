From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: [PATCH 1/2] ASoC: dapm - Add DAPM for always active
 DAC or ADC
Date: Tue, 24 Mar 2009 21:57:20 +0900
Message-ID: <49C8D8B0.8030807@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout5.samsung.com (mailout5.samsung.com [203.254.224.35])
	by alsa0.perex.cz (Postfix) with ESMTP id 5051D10382C
	for <alsa-devel@alsa-project.org>; Tue, 24 Mar 2009 13:57:33 +0100 (CET)
Received: from epmmp1 (mailout5.samsung.com [203.254.224.35])
	by mailout5.samsung.com
	(iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
	with ESMTP id <0KH0001HKHBKQZ@mailout5.samsung.com> for
	alsa-devel@alsa-project.org; Tue, 24 Mar 2009 21:57:20 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
	by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
	2004)) with ESMTPA id <0KH000HAZHBKDM@mmp1.samsung.com> for
	alsa-devel@alsa-project.org; Tue, 24 Mar 2009 21:57:20 +0900 (KST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, =?UTF-8?B?J+uwleqyveuvvCc=?= <kyungmin.park@samsung.com>, =?UTF-8?B?66+8?= =?UTF-8?B?67OR7Zi4?= <bhmin@samsung.com>
List-Id: alsa-devel@alsa-project.org

This patch supports DAPM widget for always active DAC or ADC regardless
of stream. This widgets will be used for voice call at TWL4030 codec.

TWL4030 codec use the digital signal for voice call, so it needs DAC and
ADC to change signal to digital or analog, however currently DAC and ADC
widgets cannot support voice call because they are activated only when
playback or capture is executed.

Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
---
 Documentation/sound/alsa/soc/dapm.txt |    3 +++
 include/sound/soc-dapm.h              |    6 ++++++
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/Documentation/sound/alsa/soc/dapm.txt b/Documentation/sound/alsa/soc/dapm.txt
index 9e67632..50a1e21 100644
--- a/Documentation/sound/alsa/soc/dapm.txt
+++ b/Documentation/sound/alsa/soc/dapm.txt
@@ -93,6 +93,9 @@ e.g. stream widgets for HiFi playback and capture
 SND_SOC_DAPM_DAC("HiFi DAC", "HiFi Playback", REG, 3, 1),
 SND_SOC_DAPM_ADC("HiFi ADC", "HiFi Capture", REG, 2, 1),
 
+If you want always active DAC or ADC widget regardless of stream, you can use
+SND_SOC_DAPM_DAC_ACTIVE or SND_SOC_DAPM_ADC_ACTIVE instead, and stream name
+parameter isn't used.
 
 2.2 Path Domain Widgets
 -----------------------
diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index a7def6a..5e26f81 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -143,6 +143,12 @@
 #define SND_SOC_DAPM_ADC(wname, stname, wreg, wshift, winvert) \
 {	.id = snd_soc_dapm_adc, .name = wname, .sname = stname, .reg = wreg, \
 	.shift = wshift, .invert = winvert}
+#define SND_SOC_DAPM_DAC_ACTIVE(wname, wreg, wshift, winvert) \
+{	.id = snd_soc_dapm_dac, .name = wname, .reg = wreg, \
+	.shift = wshift, .invert = winvert, .active = 1}
+#define SND_SOC_DAPM_ADC_ACTIVE(wname, wreg, wshift, winvert) \
+{	.id = snd_soc_dapm_adc, .name = wname, .reg = wreg, \
+	.shift = wshift, .invert = winvert, .active = 1}
 
 /* generic register modifier widget */
 #define SND_SOC_DAPM_REG(wid, wname, wreg, wshift, wmask, won_val, woff_val) \
-- 
1.5.6.3
