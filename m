From: Mike Crash <mike@mikecrash.com>
Subject: [PATCH] hda: support for S/PDIF out on ASUS M2V
Date: Sun, 24 Jun 2007 11:06:40 +0200
Message-ID: <467E3420.9060303@mikecrash.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000305000200050207010406"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail2.coprosys.cz (mail2.coprosys.cz [81.92.155.2])
	by alsa0.perex.cz (Postfix) with ESMTP id AA5F8244BF
	for <alsa-devel@alsa-project.org>;
	Sun, 24 Jun 2007 11:06:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mail2.coprosys.cz (Postfix) with ESMTP id 63FC948BBE
	for <alsa-devel@alsa-project.org>;
	Sun, 24 Jun 2007 11:07:58 +0200 (CEST)
Received: from mail2.coprosys.cz ([127.0.0.1])
	by localhost (mail2 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 04084-10 for <alsa-devel@alsa-project.org>;
	Sun, 24 Jun 2007 11:07:58 +0200 (CEST)
Received: from [192.168.168.137] (cbrod.comtes.cz [81.92.150.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail2.coprosys.cz (Postfix) with ESMTP id DDB6048BB6
	for <alsa-devel@alsa-project.org>;
	Sun, 24 Jun 2007 11:07:57 +0200 (CEST)
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

This is a multi-part message in MIME format.
--------------000305000200050207010406
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit

Added support for S/PDIF digital output on ASUS M2V motheboard - added 
new model "3stack-660-digout" and ALC660VD_3ST_DIG

Apply to 1.0.14 driver file patch_realtek.c

Signed-off-by: Mike Crash <mike@mikecrash.com>


--------------000305000200050207010406
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

*** patch_realtek.c	2007-06-04 09:28:54.000000000 +0200
--- patch_realtek2.c	2007-06-16 21:46:14.000000000 +0200
*************** enum {
*** 117,118 ****
--- 117,119 ----
  	ALC660VD_3ST,
+ 	ALC660VD_3ST_DIG,
  	ALC861VD_3ST,
*************** static const char *alc861vd_models[ALC86
*** 9466,9467 ****
--- 9467,9469 ----
  	[ALC660VD_3ST]		= "3stack-660",
+ 	[ALC660VD_3ST_DIG]= "3stack-660-digout",
  	[ALC861VD_3ST]		= "3stack",
*************** static struct snd_pci_quirk alc861vd_cfg
*** 9477,9479 ****
  	SND_PCI_QUIRK(0x1043, 0x1339, "Asus G1", ALC660VD_3ST),
! 	SND_PCI_QUIRK(0x1043, 0x81e7, "ASUS", ALC660VD_3ST),
  	SND_PCI_QUIRK(0x10de, 0x03f0, "Realtek ALC660 demo", ALC660VD_3ST),
--- 9479,9481 ----
  	SND_PCI_QUIRK(0x1043, 0x1339, "Asus G1", ALC660VD_3ST),
! 	SND_PCI_QUIRK(0x1043, 0x81e7, "ASUS", ALC660VD_3ST_DIG),
  	SND_PCI_QUIRK(0x10de, 0x03f0, "Realtek ALC660 demo", ALC660VD_3ST),
*************** static struct alc_config_preset alc861vd
*** 9501,9502 ****
--- 9503,9517 ----
  	},
+ 	[ALC660VD_3ST_DIG] = {
+ 		.mixers = { alc861vd_3st_mixer },
+ 		.init_verbs = { alc861vd_volume_init_verbs,
+ 				 alc861vd_3stack_init_verbs },
+ 		.num_dacs = ARRAY_SIZE(alc660vd_dac_nids),
+ 		.dac_nids = alc660vd_dac_nids,
+ 		.dig_out_nid = ALC861VD_DIGOUT_NID,
+ 		.num_adc_nids = ARRAY_SIZE(alc861vd_adc_nids),
+ 		.adc_nids = alc861vd_adc_nids,
+ 		.num_channel_mode = ARRAY_SIZE(alc861vd_3stack_2ch_modes),
+ 		.channel_mode = alc861vd_3stack_2ch_modes,
+ 		.input_mux = &alc861vd_capture_source,
+ 	},
  	[ALC861VD_3ST] = {

--------------000305000200050207010406
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------000305000200050207010406--
