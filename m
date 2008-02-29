From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: [PATCH] hda: disable power management on fixed ports.
Date: Thu, 28 Feb 2008 20:49:42 -0500
Message-ID: <47C764B6.4080501@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp110.biz.mail.mud.yahoo.com (smtp110.biz.mail.mud.yahoo.com
	[68.142.201.179]) by alsa0.perex.cz (Postfix) with SMTP id 6799424434
	for <alsa-devel@alsa-project.org>; Fri, 29 Feb 2008 02:49:40 +0100 (CET)
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
Cc: Takashi Iwai <tiwai@suse.de>, "Tellman, Steven" <Steven.Tellman@idt.com>, Jose_De_La_Rosa@Dell.com, Mario_Limonciello@Dell.com
List-Id: alsa-devel@alsa-project.org

Power management can't be enabled on fixed ports, since the presence will always return false
and prevent output.

Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>
---
diff -r 54a51b975975 pci/hda/patch_sigmatel.c
--- a/pci/hda/patch_sigmatel.c	Thu Feb 28 12:46:32 2008 +0100
+++ b/pci/hda/patch_sigmatel.c	Thu Feb 28 20:39:28 2008 -0500
@@ -3015,11 +3015,15 @@ static int stac92xx_init(struct hda_code
 					? STAC_HP_EVENT : STAC_PWR_EVENT;
 		int pinctl = snd_hda_codec_read(codec, spec->pwr_nids[i],
 					0, AC_VERB_GET_PIN_WIDGET_CONTROL, 0);
+		int def_conf = snd_hda_codec_read(codec, spec->pwr_nids[i],
+					0, AC_VERB_GET_CONFIG_DEFAULT, 0);
 		/* outputs are only ports capable of power management
 		 * any attempts on powering down a input port cause the
 		 * referenced VREF to act quirky.
 		 */
 		if (pinctl & AC_PINCTL_IN_EN)
+			continue;
+		if (get_defcfg_connect(def_conf) != AC_JACK_PORT_FIXED)
 			continue;
 		enable_pin_detect(codec, spec->pwr_nids[i], event | i);
 		codec->patch_ops.unsol_event(codec, (event | i) << 26);
