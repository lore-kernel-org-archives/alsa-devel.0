From: Peter Zubaj <pzad@pobox.sk>
Subject: Re: [PATCH] Audigy SB0090 identification
Date: Thu, 31 Mar 2005 22:23:49 +0200
Message-ID: <424C5C55.8000506@pobox.sk>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070002010609050104090004"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gwen.pobox.sk (gwen.pobox.sk [212.5.216.21])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id F2E58254
	for <alsa-devel@alsa-project.org>; Thu, 31 Mar 2005 22:23:32 +0200 (MEST)
Received: from [192.168.1.20] (NAT-pool_1.gaya.sk [62.168.75.5] (may be forged))
	(authenticated bits=0)
	by gwen.pobox.sk (8.12.10/8.12.9/relay) with ESMTP id j2VKNWKh027427
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT)
	for <alsa-devel@alsa-project.org>; Thu, 31 Mar 2005 22:23:32 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------070002010609050104090004
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Please, forget previous patch - it was not good. This one is ok.

Description : This add identification of Audigy 1 model SB0090 and fixes 
problems with ac97 codec (mic not working).

Signed-off: Peter Zubaj <pzad@pobox.sk>

------------------------------------

I think Audigy 1 doesn't have spdif bug (this si why there is no 
.spdif_bug initialization). For me looks like this card identification 
will break AC3 pasthrough for all audigy 1 (I am not sure).  AFAIK all 
audigy cards have ac97 except Audigy 2 Platinium EX and Audigy 2 
Notebook (this is not supported).

One question: All subsystem ids are 0xXXXX1102 except for Audigy 1 ES, 
is this good ?

Peter Zubaj

--------------070002010609050104090004
Content-Type: text/x-patch;
 name="audigy_sb0090.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="audigy_sb0090.diff"

diff -u o/emu10k1_main.c n/emu10k1_main.c
--- o/emu10k1_main.c	2005-03-31 20:05:47.000000000 +0200
+++ n/emu10k1_main.c	2005-03-31 22:05:52.000000000 +0200
@@ -619,12 +619,14 @@
 	 .id = "Audigy2",
 	 .emu10k2_chip = 1,
 	 .ca0108_chip = 1,
-	 .spk71 = 1} ,
+	 .spk71 = 1,
+	 .ac97_chip = 1} ,
 	{.vendor = 0x1102, .device = 0x0008, 
 	 .driver = "Audigy2", .name = "Audigy 2 Value [Unknown]", 
 	 .id = "Audigy2",
 	 .emu10k2_chip = 1,
-	 .ca0108_chip = 1} ,
+	 .ca0108_chip = 1,
+	 .ac97_chip = 1} ,
 	{.vendor = 0x1102, .device = 0x0004, .subsystem = 0x20071102,
 	 .driver = "Audigy2", .name = "Audigy 4 PRO [SB0380]", 
 	 .id = "Audigy2",
@@ -682,13 +684,21 @@
 	 .id = "Audigy",
 	 .emu10k2_chip = 1,
 	 .ca0102_chip = 1,
-	 .spdif_bug = 1} ,
+	 .spdif_bug = 1,
+	 .ac97_chip = 1} ,
+	{.vendor = 0x1102, .device = 0x0004, .subsystem = 0x00531102,
+	 .driver = "Audigy", .name = "Audigy 1 [SB0090]", 
+	 .id = "Audigy",
+	 .emu10k2_chip = 1,
+	 .ca0102_chip = 1,
+	 .ac97_chip = 1} ,
 	{.vendor = 0x1102, .device = 0x0004,
 	 .driver = "Audigy", .name = "Audigy 1 or 2 [Unknown]", 
 	 .id = "Audigy",
 	 .emu10k2_chip = 1,
 	 .ca0102_chip = 1,
-	 .spdif_bug = 1} ,
+	 .spdif_bug = 1,
+	 .ac97_chip = 1} ,
 	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x40011102,
 	 .driver = "EMU10K1", .name = "E-mu APS [4001]", 
 	 .id = "APS",

--------------070002010609050104090004--


-------------------------------------------------------
This SF.net email is sponsored by Demarc:
A global provider of Threat Management Solutions.
Download our HomeAdmin security software for free today!
http://www.demarc.com/Info/Sentarus/hamr30
