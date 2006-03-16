From: Eugene Teo <eugene.teo@eugeneteo.net>
Subject: Fix sb_mixer use before validation
Date: Thu, 16 Mar 2006 08:54:54 +0800
Message-ID: <20060316005454.GA20151@eugeneteo.net>
Reply-To: Eugene Teo <eugene.teo@eugeneteo.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from kbsmtao2.starhub.net.sg (kbsmtao2.starhub.net.sg [203.116.2.167])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 15D60209
	for <alsa-devel@alsa-project.org>; Thu, 16 Mar 2006 01:54:56 +0100 (MET)
Received: from kerndev.kerndev ([202.156.189.118]) by kbsmtao2.starhub.net.sg
 (Sun Java System Messaging Server 6.2-3.04 (built Jul 15 2005))
 with ESMTPP id <0IW700FRG3VGEEA0@kbsmtao2.starhub.net.sg> for
 alsa-devel@alsa-project.org; Thu, 16 Mar 2006 08:54:52 +0800 (SGT)
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

I know that OSS is obsoleted by ALSA but here's a patch anyways.

Eugene

--
dev should be validated before it is being used as index to array.

Coverity bug #871

Signed-off-by: Eugene Teo <eugene.teo@eugeneteo.net>

--- linux-2.6/sound/oss/sb_mixer.c~	2006-03-15 10:05:45.000000000 +0800
+++ linux-2.6/sound/oss/sb_mixer.c	2006-03-16 08:28:48.000000000 +0800
@@ -273,14 +273,14 @@
 	int regoffs;
 	unsigned char val;
 
+	if ((dev < 0) || (dev >= devc->iomap_sz))
+		return -EINVAL;
+
 	regoffs = (*devc->iomap)[dev][LEFT_CHN].regno;
 
 	if (regoffs == 0)
 		return -EINVAL;
 
-	if ((dev < 0) || (dev >= devc->iomap_sz))
-	    return -EINVAL;
-
 	val = sb_getmixer(devc, regoffs);
 	change_bits(devc, &val, dev, LEFT_CHN, left);
 
-- 
1024D/A6D12F80 print D51D 2633 8DAC 04DB 7265  9BB8 5883 6DAA A6D1 2F80
main(i) { putchar(182623909 >> (i-1) * 5&31|!!(i<7)<<6) && main(++i); }



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
