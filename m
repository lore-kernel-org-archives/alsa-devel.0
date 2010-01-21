From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH] add simplified versions of widget macros
Date: Thu, 21 Jan 2010 21:10:47 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1001212046320.9137@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id 3B10210387C
	for <alsa-devel@alsa-project.org>; Thu, 21 Jan 2010 21:10:40 +0100 (CET)
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Many macros from include/sound/soc-dapm.h take an array and a number of 
elements in it as arguments, whereas most users use static arrays and use 
"x, ARRAY_SIZE(x)" as arguments. This patch adds simplified versions of 
those macros, calling ARRAY_SIZE() internally.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index c5c95e1..c0922a0 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -95,6 +95,21 @@
 	.shift = wshift, .invert = winvert, .kcontrols = wcontrols, \
 	.num_kcontrols = 1}
 
+/* Simplified versions of above macros, assuming wncontrols = ARRAY_SIZE(wcontrols) */
+#define SOC_PGA_ARRAY(wname, wreg, wshift, winvert,\
+	 wcontrols) \
+{	.id = snd_soc_dapm_pga, .name = wname, .reg = wreg, .shift = wshift, \
+	.invert = winvert, .kcontrols = wcontrols, .num_kcontrols = ARRAY_SIZE(wcontrols)}
+#define SOC_MIXER_ARRAY(wname, wreg, wshift, winvert, \
+	 wcontrols)\
+{	.id = snd_soc_dapm_mixer, .name = wname, .reg = wreg, .shift = wshift, \
+	.invert = winvert, .kcontrols = wcontrols, .num_kcontrols = ARRAY_SIZE(wcontrols)}
+#define SOC_MIXER_NAMED_CTL_ARRAY(wname, wreg, wshift, winvert, \
+	 wcontrols)\
+{       .id = snd_soc_dapm_mixer_named_ctl, .name = wname, .reg = wreg, \
+	.shift = wshift, .invert = winvert, .kcontrols = wcontrols, \
+	.num_kcontrols = ARRAY_SIZE(wcontrols)}
+
 /* path domain with event - event handler must return 0 for success */
 #define SND_SOC_DAPM_PGA_E(wname, wreg, wshift, winvert, wcontrols, \
 	wncontrols, wevent, wflags) \
@@ -126,6 +141,23 @@
 	.invert = winvert, .kcontrols = wcontrols, .num_kcontrols = 1, \
 	.event = wevent, .event_flags = wflags}
 
+/* Simplified versions of above macros, assuming wncontrols = ARRAY_SIZE(wcontrols) */
+#define SOC_PGA_E_ARRAY(wname, wreg, wshift, winvert, wcontrols, \
+	wevent, wflags) \
+{	.id = snd_soc_dapm_pga, .name = wname, .reg = wreg, .shift = wshift, \
+	.invert = winvert, .kcontrols = wcontrols, .num_kcontrols = ARRAY_SIZE(wcontrols), \
+	.event = wevent, .event_flags = wflags}
+#define SOC_MIXER_E_ARRAY(wname, wreg, wshift, winvert, wcontrols, \
+	wevent, wflags) \
+{	.id = snd_soc_dapm_mixer, .name = wname, .reg = wreg, .shift = wshift, \
+	.invert = winvert, .kcontrols = wcontrols, .num_kcontrols = ARRAY_SIZE(wcontrols), \
+	.event = wevent, .event_flags = wflags}
+#define SOC_MIXER_NAMED_CTL_E_ARRAY(wname, wreg, wshift, winvert, \
+	wcontrols, wevent, wflags) \
+{       .id = snd_soc_dapm_mixer, .name = wname, .reg = wreg, .shift = wshift, \
+	.invert = winvert, .kcontrols = wcontrols, \
+	.num_kcontrols = ARRAY_SIZE(wcontrols), .event = wevent, .event_flags = wflags}
+
 /* events that are pre and post DAPM */
 #define SND_SOC_DAPM_PRE(wname, wevent) \
 {	.id = snd_soc_dapm_pre, .name = wname, .kcontrols = NULL, \
