From: Peter Zubaj <pzad@pobox.sk>
Subject: [PATCH] - emu10k1 external tram size
Date: Sun, 20 Mar 2005 20:41:24 +0100
Message-ID: <423DD1E4.5020400@pobox.sk>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090508050901020207080000"
Received: from gwen.pobox.sk (gwen.pobox.sk [212.5.216.21])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id E5B4025D
	for <alsa-devel@alsa-project.org>; Sun, 20 Mar 2005 20:35:11 +0100 (MET)
Received: from [192.168.1.20] (NAT-pool_1.gaya.sk [62.168.75.5] (may be forged))
	(authenticated bits=0)
	by gwen.pobox.sk (8.12.10/8.12.9/relay) with ESMTP id j2KJZAKh018455
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT)
	for <alsa-devel@alsa-project.org>; Sun, 20 Mar 2005 20:35:11 +0100 (CET)
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
--------------090508050901020207080000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

This patch fixes wrong size reported by driver for external tram. It 
reports size in bytes and should report it in samples as for internal tram.

Signed off: Peter Zubaj <pzad@pobox.sk>

--------------090508050901020207080000
Content-Type: text/x-patch;
 name="etram_size.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="etram_size.diff"

diff -r -u o/alsa-kernel/pci/emu10k1/emufx.c n/alsa-kernel/pci/emu10k1/emufx.c
--- o/alsa-kernel/pci/emu10k1/emufx.c	2004-11-23 16:11:54.000000000 +0100
+++ n/alsa-kernel/pci/emu10k1/emufx.c	2005-03-20 20:31:29.000000000 +0100
@@ -2064,7 +2064,7 @@
 	memset(info, 0, sizeof(info));
 	info->card = emu->card_type;
 	info->internal_tram_size = emu->fx8010.itram_size;
-	info->external_tram_size = emu->fx8010.etram_pages.bytes;
+	info->external_tram_size = emu->fx8010.etram_pages.bytes / 2;
 	fxbus = fxbuses;
 	extin = emu->audigy ? audigy_ins : creative_ins;
 	extout = emu->audigy ? audigy_outs : creative_outs;
diff -r -u o/alsa-kernel/pci/emu10k1/emuproc.c n/alsa-kernel/pci/emu10k1/emuproc.c
--- o/alsa-kernel/pci/emu10k1/emuproc.c	2004-11-23 16:06:17.000000000 +0100
+++ n/alsa-kernel/pci/emu10k1/emuproc.c	2005-03-20 20:29:40.000000000 +0100
@@ -184,7 +184,7 @@
 	snd_iprintf(buffer, "Card                  : %s\n",
 		    emu->audigy ? "Audigy" : (emu->APS ? "EMU APS" : "Creative"));
 	snd_iprintf(buffer, "Internal TRAM (words) : 0x%x\n", emu->fx8010.itram_size);
-	snd_iprintf(buffer, "External TRAM (words) : 0x%x\n", (int)emu->fx8010.etram_pages.bytes);
+	snd_iprintf(buffer, "External TRAM (words) : 0x%x\n", (int)emu->fx8010.etram_pages.bytes / 2);
 	snd_iprintf(buffer, "\n");
 	snd_iprintf(buffer, "Effect Send Routing   :\n");
 	for (idx = 0; idx < NUM_G; idx++) {

--------------090508050901020207080000--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
