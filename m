From: Peter Zubaj <pzad@pobox.sk>
Subject: [PATCH] Audigy SB0090 identification
Date: Thu, 31 Mar 2005 21:07:12 +0200
Message-ID: <424C4A60.7010806@pobox.sk>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090003070004080505030505"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gwen.pobox.sk (gwen.pobox.sk [212.5.216.21])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id AAB53213
	for <alsa-devel@alsa-project.org>; Thu, 31 Mar 2005 21:06:56 +0200 (MEST)
Received: from [192.168.1.20] (NAT-pool_1.gaya.sk [62.168.75.5] (may be forged))
	(authenticated bits=0)
	by gwen.pobox.sk (8.12.10/8.12.9/relay) with ESMTP id j2VJ6tKh023185
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT)
	for <alsa-devel@alsa-project.org>; Thu, 31 Mar 2005 21:06:55 +0200 (CEST)
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
--------------090003070004080505030505
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Description : This add identification of Audigy 1 model SB0090

Signed-off: Peter Zubaj <pzad@pobox.sk>

------------------------------------

I think Audigy 1 doesn't have spdif bug (this si why there is no 
.spdif_bug initialization). For me looks like this card identification 
will break AC3 pasthrough for all audigy 1 (I am not sure).

One question: All subsystem ids are 0xXXXX1102 except for Audigy 1 ES, 
is this good ?

Peter Zuba

--------------090003070004080505030505
Content-Type: text/x-patch;
 name="audigy_sb0090.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="audigy_sb0090.diff"

diff -u o/emu10k1_main.c n/emu10k1_main.c
--- o/emu10k1_main.c	2005-03-31 20:05:47.000000000 +0200
+++ n/emu10k1_main.c	2005-03-31 20:50:03.000000000 +0200
@@ -683,6 +683,11 @@
 	 .emu10k2_chip = 1,
 	 .ca0102_chip = 1,
 	 .spdif_bug = 1} ,
+	{.vendor = 0x1102, .device = 0x0004, .subsystem = 0x00531102,
+	 .driver = "Audigy", .name = "Audigy 1 [SB0090]", 
+	 .id = "Audigy",
+	 .emu10k2_chip = 1,
+	 .ca0102_chip = 1} ,
 	{.vendor = 0x1102, .device = 0x0004,
 	 .driver = "Audigy", .name = "Audigy 1 or 2 [Unknown]", 
 	 .id = "Audigy",

--------------090003070004080505030505--


-------------------------------------------------------
This SF.net email is sponsored by Demarc:
A global provider of Threat Management Solutions.
Download our HomeAdmin security software for free today!
http://www.demarc.com/Info/Sentarus/hamr30
