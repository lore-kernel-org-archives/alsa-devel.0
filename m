From: Hector Martin <hector@marcansoft.com>
Subject: [PATCH] HDA: simplify Aspire 8930G verb array
Date: Sun, 20 Dec 2009 22:51:18 +0100
Message-ID: <4B2E9C56.7030001@marcansoft.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080105070009020803020505"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.marcansoft.com (marcansoft.com [80.68.93.119])
	by alsa0.perex.cz (Postfix) with ESMTP id 5FEB0103822
	for <alsa-devel@alsa-project.org>; Sun, 20 Dec 2009 22:51:22 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------080105070009020803020505
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

This patch just simplifies the 8930G verb array a bit. Just use the
common ALC889 EAPD verb array to make things more consistent. The file
is already huge enough already.

-- 
Hector Martin (hector@marcansoft.com)
Public Key: http://www.marcansoft.com/marcan.asc


--------------080105070009020803020505
Content-Type: text/plain;
 name="aspire-8930g-simplify-verbs.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="aspire-8930g-simplify-verbs.patch"

Signed-off-by: Hector Martin <hector@marcansoft.com>

--- linux-2.6.32/sound/pci/hda/patch_realtek_orig.c	2009-12-20 19:31:08.940900751 +0100
+++ linux-2.6.32/sound/pci/hda/patch_realtek.c	2009-12-20 22:14:11.852025021 +0100
@@ -1665,9 +1670,6 @@
 /*  some bit here disables the other DACs. Init=0x4900 */
 	{0x20, AC_VERB_SET_COEF_INDEX, 0x08},
 	{0x20, AC_VERB_SET_PROC_COEF, 0x0000},
-/* Enable amplifiers */
-	{0x14, AC_VERB_SET_EAPD_BTLENABLE, 0x02},
-	{0x15, AC_VERB_SET_EAPD_BTLENABLE, 0x02},
 /* DMIC fix
  * This laptop has a stereo digital microphone. The mics are only 1cm apart
  * which makes the stereo useless. However, either the mic or the ALC889
@@ -9305,7 +9305,8 @@
 		.mixers = { alc889_acer_aspire_8930g_mixer,
 				alc883_chmode_mixer },
 		.init_verbs = { alc883_init_verbs, alc880_gpio1_init_verbs,
-				alc889_acer_aspire_8930g_verbs },
+				alc889_acer_aspire_8930g_verbs,
+				alc889_eapd_verbs},
 		.num_dacs = ARRAY_SIZE(alc883_dac_nids),
 		.dac_nids = alc883_dac_nids,
 		.num_adc_nids = ARRAY_SIZE(alc889_adc_nids),

--------------080105070009020803020505
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------080105070009020803020505--
