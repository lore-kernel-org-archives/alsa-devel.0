From: Mikael Magnusson <mikaelmagnusson@glocalnet.net>
Subject: [PATCH 2/5] emu10k1 SB Live: Master volume and front channels via
 fxbus 8,9
Date: Mon, 21 Feb 2005 20:45:04 +0100
Message-ID: <421A3A40.9060007@glocalnet.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080202070703070705020606"
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 08A7815A
	for <alsa-devel@alsa-project.org>; Mon, 21 Feb 2005 20:45:06 +0100 (MET)
Received: from mulder.hem.za.org (unknown [84.217.26.207])
	by gate.perex.cz (Perex's E-mail Delivery System) with ESMTP id AE46457F53
	for <alsa-devel@alsa-project.org>; Mon, 21 Feb 2005 20:45:05 +0100 (MET)
Received: from skinner.hem.za.org ([192.168.0.2])
	by mulder.hem.za.org with esmtp (Exim 4.34)
	id 1D3JUO-0000Zx-Rw
	for alsa-devel@alsa-project.org; Mon, 21 Feb 2005 20:45:04 +0100
Received: from localhost ([127.0.0.1])
	by skinner.hem.za.org with esmtp (Exim 4.34)
	id 1D3JUO-0001aM-IQ
	for alsa-devel@alsa-project.org; Mon, 21 Feb 2005 20:45:04 +0100
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
--------------080202070703070705020606
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

rename_master.patch

Renames "Master Playback Volume" to "Master Front Playback Volume" which 
reflects that it only controls the front output, and renames "Master 
Digital Playback Volume" to "Master Playback Volume".

Signed-Off-By: Mikael Magnusson <mikma@users.sourceforge.net>

--------------080202070703070705020606
Content-Type: text/x-patch;
 name="rename_master.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rename_master.patch"

--- alsa-kernel/pci/emu10k1/emumixer.c	16 Feb 2005 10:25:36 -0000	1.30
+++ alsa-kernel/pci/emu10k1/emumixer.c	21 Feb 2005 13:34:05 -0000
@@ -748,6 +748,10 @@
 		"Surround Digital Playback Volume", "Surround Playback Volume",
 		"Center Digital Playback Volume", "Center Playback Volume",
 		"LFE Digital Playback Volume", "LFE Playback Volume",
+		"Master Playback Volume", "Master Front Playback Volume",
+		"Master Playback Switch", "Master Front Playback Switch",
+		"Master Digital Playback Volume", "Master Playback Volume",
+		"Master Digital Playback Switch", "Master Playback Switch",
 		NULL
 	};
 	static char *audigy_remove_ctls[] = {

--------------080202070703070705020606--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
