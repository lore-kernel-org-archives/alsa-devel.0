From: Eugene Teo <eugene.teo@eugeneteo.net>
Subject: Fix sequencer missing negative bound check
Date: Thu, 16 Mar 2006 09:19:11 +0800
Message-ID: <20060316011911.GA20384__27225.9627389305$1142472031$gmane$org@eugeneteo.net>
Reply-To: Eugene Teo <eugene.teo@eugeneteo.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from kbsmtao2.starhub.net.sg (kbsmtao2.starhub.net.sg [203.116.2.167])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B34051E9
	for <alsa-devel@alsa-project.org>; Thu, 16 Mar 2006 02:19:14 +0100 (MET)
Received: from kerndev.kerndev ([202.156.189.118]) by kbsmtao2.starhub.net.sg
 (Sun Java System Messaging Server 6.2-3.04 (built Jul 15 2005))
 with ESMTPP id <0IW700FHI4ZXE8A0@kbsmtao2.starhub.net.sg> for
 alsa-devel@alsa-project.org; Thu, 16 Mar 2006 09:19:10 +0800 (SGT)
Content-disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

dev is missing a negative bound check.

Signed-off-by: Eugene Teo <eugene.teo@eugeneteo.net>

--- linux-2.6/sound/oss/sequencer.c~	2006-03-15 10:05:45.000000000 +0800
+++ linux-2.6/sound/oss/sequencer.c	2006-03-16 09:06:59.000000000 +0800
@@ -713,7 +713,7 @@
 	int i, l = 0;
 	unsigned char  *buf = &event_rec[2];
 
-	if ((int) dev > max_synthdev)
+	if (dev < 0 || dev >= max_synthdev)
 		return;
 	if (!(synth_open_mask & (1 << dev)))
 		return;

-- 
1024D/A6D12F80 print D51D 2633 8DAC 04DB 7265  9BB8 5883 6DAA A6D1 2F80
main(i) { putchar(182623909 >> (i-1) * 5&31|!!(i<7)<<6) && main(++i); }



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
