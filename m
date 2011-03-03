From: Mohammad Bahathir Hashim <bahathir@gmail.com>
Subject: [FIX]: No SPDIF out from MacBookPro 6, 2, since 2.6.36
Date: Thu, 3 Mar 2011 04:20:37 +0000 (UTC)
Message-ID: <ikn4uk$e4d$1@dough.gmane.org>
Reply-To: Mohammad Bahathir Hashim <bahathir@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 413C1103816
	for <alsa-devel@alsa-project.org>; Thu,  3 Mar 2011 05:20:58 +0100 (CET)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1Pv01x-0003TX-83
	for alsa-devel@alsa-project.org; Thu, 03 Mar 2011 05:20:49 +0100
Received: from 203.106.17.237 ([203.106.17.237])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 03 Mar 2011 05:20:49 +0100
Received: from bahathir by 203.106.17.237 with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 03 Mar 2011 05:20:49 +0100
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

Hi,

Problem : No SPDIF since 2.6.36
HW : MacBookPro 15" HiRes (mid-2010)
Audio : 00:1b.0 Audio device: Intel Corporation 5 Series/3400 Series
Chipset High Definition Audio (rev 06)
HDA codec : Cirrus CS4206

This simple patch will bypass the errata workaround for CS4207, and I
able to use the SPDIF (Toslink) out again.

Suggestion : Make a conditional expression to load the errata
verb/code if the driver detects CS4207.

Thank you.

--- orig/patch_cirrus.c	2011-03-03 11:56:31.726000009 +0800
+++ patch_cirrus.c	2011-03-03 12:05:38.556000063 +0800
@@ -1066,7 +1066,7 @@
 	struct cs_spec *spec = codec->spec;
 
 	/* init_verb sequence for C0/C1/C2 errata*/
-	snd_hda_sequence_write(codec, cs_errata_init_verbs);
+	/*snd_hda_sequence_write(codec, cs_errata_init_verbs);*/
 
 	snd_hda_sequence_write(codec, cs_coef_init_verbs);
