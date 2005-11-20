From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Subject: snd_pcm_lib_malloc_pages
Date: Sun, 20 Nov 2005 23:12:05 +0000
Message-ID: <1132528326.9292.23.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from sc-outsmtp1.homechoice.co.uk (sc-outsmtp1.homechoice.co.uk [81.1.65.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 8178219C
	for <alsa-devel@alsa-project.org>; Mon, 21 Nov 2005 00:12:27 +0100 (MET)
Received: from bossclass (bossclass [192.168.62.105])
	by localhost.localdomain (8.13.4/8.13.1) with ESMTP id jAKNC68v030907
	for <alsa-devel@alsa-project.org>; Sun, 20 Nov 2005 23:12:13 GMT
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

I am trying to write to a driver on the Dreamcast (SH4) - as far as I
can see there are no ALSA drivers extant for this processor. Does that
mean I should assume this function is implemented or unimplemented on
SH? On a scan through the code I can see no obvious reason why it
wouldn't be working (ie no processor specific code) but there must be
some degree of processor/bus specific code.

Adrian



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
