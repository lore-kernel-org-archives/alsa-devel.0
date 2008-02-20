From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: [PATCH] hda: STAC927x power management
Date: Wed, 20 Feb 2008 17:00:39 -0500
Message-ID: <47BCA307.4000608@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp103.biz.mail.re2.yahoo.com (smtp103.biz.mail.re2.yahoo.com
	[68.142.229.217]) by alsa0.perex.cz (Postfix) with SMTP id 0396C24557
	for <alsa-devel@alsa-project.org>; Wed, 20 Feb 2008 23:01:08 +0100 (CET)
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
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Fix issue on STAC927x codecs that first DAC was getting powered down even if was being used.

Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>
---
diff -r 30701aaf404c pci/hda/patch_sigmatel.c
--- a/pci/hda/patch_sigmatel.c	Wed Feb 20 12:13:29 2008 +0100
+++ b/pci/hda/patch_sigmatel.c	Wed Feb 20 14:16:59 2008 -0700
@@ -2893,7 +2893,8 @@ static void stac92xx_power_down(struct h
 	/* power down inactive DACs */
 	hda_nid_t *dac;
 	for (dac = spec->dac_list; *dac; dac++)
-		if (!is_in_dac_nids(spec, *dac))
+		if (!is_in_dac_nids(spec, *dac) &&
+			spec->multiout.hp_nid != *dac)
 			snd_hda_codec_write_cache(codec, *dac, 0,
 					AC_VERB_SET_POWER_STATE, AC_PWRST_D3);
 }
