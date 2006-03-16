From: Eugene Teo <eugene.teo@eugeneteo.net>
Subject: Re: Fix sequencer missing negative bound check
Date: Thu, 16 Mar 2006 11:23:18 +0800
Message-ID: <20060316032318.GA21534__34071.093684952$1142479525$gmane$org@eugeneteo.net>
References: <20060316011911.GA20384@eugeneteo.net>
 <200603160307.k2G37KLX007666@turing-police.cc.vt.edu>
Reply-To: Eugene Teo <eugene.teo@eugeneteo.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from kbsmtao2.starhub.net.sg (kbsmtao2.starhub.net.sg [203.116.2.167])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 4A10C20E
	for <alsa-devel@alsa-project.org>; Thu, 16 Mar 2006 04:24:15 +0100 (MET)
Received: from kerndev.kerndev ([202.156.189.118]) by kbsmtao2.starhub.net.sg
 (Sun Java System Messaging Server 6.2-3.04 (built Jul 15 2005))
 with ESMTPP id <0IW700FPMAQTE9H0@kbsmtao2.starhub.net.sg> for
 alsa-devel@alsa-project.org; Thu, 16 Mar 2006 11:23:17 +0800 (SGT)
In-reply-to: <200603160307.k2G37KLX007666@turing-police.cc.vt.edu>
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
Cc: alsa-devel@alsa-project.org, Valdis.Kletnieks@vt.edu
List-Id: alsa-devel@alsa-project.org

<quote sender="Valdis.Kletnieks@vt.edu">
> On Thu, 16 Mar 2006 09:19:11 +0800, Eugene Teo said:
> > dev is missing a negative bound check.
> > 
> > Signed-off-by: Eugene Teo <eugene.teo@eugeneteo.net>
[snipped]
> static void seq_sysex_message(unsigned char *event_rec)
> {
>         int dev = event_rec[1];
>         int i, l = 0;
>         unsigned char  *buf = &event_rec[2];
> 
>         if ((int) dev > max_synthdev)
>                 return;
[snipped]
> that 'int dev' came out of an 'unsigned char *' - as such, I doubt you
> can get a negative value.  If anything, it should be 'unsigned int dev'.

Yes, thanks for pointing it out.

--
'int dev' came out of an 'unsigned char *' - as such, it will not get
a negative value. Thanks Valdis.

Signed-off-by: Eugene Teo <eugene.teo@eugeneteo.net>

--- linux-2.6/sound/oss/sequencer.c~	2006-03-15 10:05:45.000000000 +0800
+++ linux-2.6/sound/oss/sequencer.c	2006-03-16 11:15:31.000000000 +0800
@@ -709,7 +709,7 @@
 
 static void seq_sysex_message(unsigned char *event_rec)
 {
-	int dev = event_rec[1];
+	unsigned int dev = event_rec[1];
 	int i, l = 0;
 	unsigned char  *buf = &event_rec[2];
 
-- 
1024D/A6D12F80 print D51D 2633 8DAC 04DB 7265  9BB8 5883 6DAA A6D1 2F80
main(i) { putchar(182623909 >> (i-1) * 5&31|!!(i<7)<<6) && main(++i); }



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
