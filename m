From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: [PATCH] ASoC: Amstrad Delta minor cleanups
Date: Wed, 21 Oct 2009 04:40:55 +0200
Message-ID: <200910210440.56628.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from d1.icnet.pl (d1.icnet.pl [212.160.220.21])
	by alsa0.perex.cz (Postfix) with ESMTP id DAE78103805
	for <alsa-devel@alsa-project.org>;
	Wed, 21 Oct 2009 04:41:43 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

Here is a patch that corrects small omissions I have found in my code.

Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>

---
--- linux-2.6.32-rc5/sound/soc/omap/ams-delta.c.orig	2009-10-16 02:41:50.000000000 +0200
+++ linux-2.6.32-rc5/sound/soc/omap/ams-delta.c	2009-10-21 03:33:17.000000000 +0200
@@ -40,7 +40,7 @@
 
 
 /* Board specific DAPM widgets */
- const struct snd_soc_dapm_widget ams_delta_dapm_widgets[] = {
+static const struct snd_soc_dapm_widget ams_delta_dapm_widgets[] = {
 	/* Handset */
 	SND_SOC_DAPM_MIC("Mouthpiece", NULL),
 	SND_SOC_DAPM_HP("Earpiece", NULL),
@@ -81,7 +81,7 @@ static const char *ams_delta_audio_mode[
 						(1 << AMS_DELTA_SPEAKER))
 #define AMS_DELTA_SPEAKERPHONE	(AMS_DELTA_HANDSFREE | (1 << AMS_DELTA_AGC))
 
-unsigned short ams_delta_audio_mode_pins[] = {
+static const unsigned short ams_delta_audio_mode_pins[] = {
 	AMS_DELTA_MIXED,
 	AMS_DELTA_HANDSET,
 	AMS_DELTA_HANDSFREE,
