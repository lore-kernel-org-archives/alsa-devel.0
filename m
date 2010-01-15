From: Lee Trager <lee.trager@hp.com>
Subject: [PATCH]  Fix automute issue on HP T5735
Date: Fri, 15 Jan 2010 11:56:19 -0500
Message-ID: <1263574579.2368.88.camel@ltrager-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from g4t0017.houston.hp.com (g4t0017.houston.hp.com [15.201.24.20])
	by alsa0.perex.cz (Postfix) with ESMTP id 07B3F1037F3
	for <alsa-devel@alsa-project.org>; Fri, 15 Jan 2010 19:32:55 +0100 (CET)
Received: from g4t0018.houston.hp.com (g4t0018.houston.hp.com [16.234.32.27])
	by g4t0017.houston.hp.com (Postfix) with ESMTP id 637423869E
	for <alsa-devel@alsa-project.org>; Fri, 15 Jan 2010 18:32:54 +0000 (UTC)
Received: from [16.120.182.143] (ltrager-laptop.americas.hpqcorp.net
	[16.120.182.143])
	by g4t0018.houston.hp.com (Postfix) with ESMTP id 2F4901005C
	for <alsa-devel@alsa-project.org>; Fri, 15 Jan 2010 18:32:54 +0000 (UTC)
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
List-Id: alsa-devel@alsa-project.org

The following patch fixes an issue where when you plug something into
the headphone jack the internal speaker does not automute. This also
will close alsa bug #0004766

Lee

--- alsa-driver-orig/alsa-kernel/pci/hda/patch_realtek.c	2009-08-28
07:41:39.000000000 -0400
+++ alsa-driver/alsa-kernel/pci/hda/patch_realtek.c	2009-10-13
14:24:40.000000000 -0400
@@ -10028,7 +10028,9 @@
 	struct alc_spec *spec = codec->spec;
 
 	spec->autocfg.hp_pins[0] = 0x15;
-	spec->autocfg.speaker_pins[0] = 0x0c; /* HACK: not actually a pin */
+	spec->autocfg.speaker_pins[0] = 0x14;
+
+	alc_automute_amp(codec);
 }
 
 static struct snd_kcontrol_new alc262_hp_t5735_mixer[] = {
