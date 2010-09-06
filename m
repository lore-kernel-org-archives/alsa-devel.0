From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Add event variants of the AIF widgets
Date: Mon,  6 Sep 2010 09:38:04 +0100
Message-ID: <1283762284-10034-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 90AAB1037FF
	for <alsa-devel@alsa-project.org>;
	Mon,  6 Sep 2010 10:38:07 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc-dapm.h |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index c4a4456..8fd3b41 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -172,9 +172,19 @@
 #define SND_SOC_DAPM_AIF_IN(wname, stname, wslot, wreg, wshift, winvert) \
 {	.id = snd_soc_dapm_aif_in, .name = wname, .sname = stname, \
 	.reg = wreg, .shift = wshift, .invert = winvert }
+#define SND_SOC_DAPM_AIF_IN_E(wname, stname, wslot, wreg, wshift, winvert, \
+			      wevent, wflags)				\
+{	.id = snd_soc_dapm_aif_in, .name = wname, .sname = stname, \
+	.reg = wreg, .shift = wshift, .invert = winvert, \
+	.event = wevent, .event_flags = wflags }
 #define SND_SOC_DAPM_AIF_OUT(wname, stname, wslot, wreg, wshift, winvert) \
 {	.id = snd_soc_dapm_aif_out, .name = wname, .sname = stname, \
 	.reg = wreg, .shift = wshift, .invert = winvert }
+#define SND_SOC_DAPM_AIF_OUT_E(wname, stname, wslot, wreg, wshift, winvert, \
+			     wevent, wflags)				\
+{	.id = snd_soc_dapm_aif_out, .name = wname, .sname = stname, \
+	.reg = wreg, .shift = wshift, .invert = winvert, \
+	.event = wevent, .event_flags = wflags }
 #define SND_SOC_DAPM_DAC(wname, stname, wreg, wshift, winvert) \
 {	.id = snd_soc_dapm_dac, .name = wname, .sname = stname, .reg = wreg, \
 	.shift = wshift, .invert = winvert}
-- 
1.7.1
