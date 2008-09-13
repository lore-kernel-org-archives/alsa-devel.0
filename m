From: robbat2@gentoo.org
Subject: [PATCH] ALSA: HDA: patch_analog: Fix SPDIF output on
	AD1989B
Date: Sat, 13 Sep 2008 16:55:00 -0700
Message-ID: <1221350101-11772-4-git-send-email-robbat2@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.isohunt.com (b01.ext.isohunt.com [208.71.112.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 1CBC5245E2
	for <alsa-devel@alsa-project.org>;
	Sun, 14 Sep 2008 02:01:44 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org, "Robin H. Johnson" <robbat2@gentoo.org>
List-Id: alsa-devel@alsa-project.org

From: Robin H. Johnson <robbat2@gentoo.org>

The SPDIF pins for AD1989 are not enabled by default. Set OUT bit so that they
actually work. Also initialize the HDMI SPDIF at the same time.

Signed-off-by: Robin H. Johnson <robbat2@gentoo.org>

diff --git a/sound/pci/hda/patch_analog.c b/sound/pci/hda/patch_analog.c
index b037324..42b1a23 100644
--- a/sound/pci/hda/patch_analog.c
+++ b/sound/pci/hda/patch_analog.c
@@ -2255,8 +2255,12 @@ static struct hda_verb ad1988_spdif_init_verbs[] = {
 
 /* AD1989 has no ADC -> SPDIF route */
 static struct hda_verb ad1989_spdif_init_verbs[] = {
-	/* SPDIF out pin */
+	/* SPDIF-1 out pin */
+	{0x1b, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT },
 	{0x1b, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE | 0x27}, /* 0dB */
+	/* SPDIF-2/HDMI out pin */
+	{0x1d, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT },
+	{0x1d, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE | 0x27}, /* 0dB */
 	{ }
 };
 
-- 
1.6.0.1
