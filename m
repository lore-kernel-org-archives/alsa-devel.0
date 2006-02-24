From: Doug McLain <doug@nostar.net>
Subject: patch for bug 1806
Date: Fri, 24 Feb 2006 18:49:40 -0500
Message-ID: <43FF9B94.6050909@nostar.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000201050705010904070304"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>, Alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------000201050705010904070304
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jaroslav,

I posted this patch to bug 1806 a while back, and have been awaiting a 
reply or commit.  It currently reports the Locked/No Signal text 
backwards in envy24control, since i was using an older version of 
envy24control when I wrote the original code.  The Locked/No Signal test 
was recently reversed in envy24control cvs, so the test in my code needs 
to be reversed as well.  Here is the patch, once again.

Doug
--
http://nostar.net/

--------------000201050705010904070304
Content-Type: text/x-patch;
 name="1010lt_wordclock_status_correction.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="1010lt_wordclock_status_correction.diff"

? 1010lt_wordclock_status_correction.diff
Index: pci/ice1712/delta.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/ice1712/delta.c,v
retrieving revision 1.25
diff -u -r1.25 delta.c
--- pci/ice1712/delta.c	10 Feb 2006 08:42:17 -0000	1.25
+++ pci/ice1712/delta.c	10 Feb 2006 21:30:27 -0000
@@ -412,7 +412,7 @@
 	if (snd_i2c_sendbytes(ice->cs8427, &reg, 1) != 1)
 		snd_printk(KERN_ERR "unable to send register 0x%x byte to CS8427\n", reg);
 	snd_i2c_readbytes(ice->cs8427, &reg, 1);
-	ucontrol->value.integer.value[0] = (reg ? 0 : 1);
+	ucontrol->value.integer.value[0] = (reg ? 1 : 0);
 	return 0;
 }
 

--------------000201050705010904070304--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
