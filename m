From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000310]: Alsa freeze on shutdown in kernel 2.6.6
Date: Wed,  8 Sep 2004 18:20:25 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040908162025.5A9C113002@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 2FA7A217
	for <alsa-devel@alsa-project.org>; Wed,  8 Sep 2004 18:20:28 +0200 (MEST)
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


The following bug has been RESOLVED.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_advanced_page.php?bug_id=0000310
======================================================================
Reported By:                hjheins
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Bug ID:                     310
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     resolved
Distribution:               Mandrake 10.0 modified
Kernel Version:             2.6.6
Resolution:                 fixed
======================================================================
Date Submitted:             05-27-2004 14:07 CEST
Last Modified:              09-08-2004 18:20 CEST
======================================================================
Summary:                    Alsa freeze on shutdown in kernel 2.6.6
Description: 
On shutdown, the alsa module does not shut down, it hangs.
if I'm quick enough, I can break the operation with <ctrl>+<c>, and
shutdown goes ok. If I don't break. The shutdown sequence hangs on the
Alsa module.
======================================================================

----------------------------------------------------------------------
 tiwai - 05-28-2004 17:04 CEST 
----------------------------------------------------------------------
does it happen if you stop ALSA manually (e.g. calling
/etc/init.d/alsasound stop)?

----------------------------------------------------------------------
 hjheins - 05-28-2004 20:04 CEST 
----------------------------------------------------------------------
Manually stopping seems to work.
But when I do that I get:

#service alsa stop
Doing alsactl to store mixer settings...                        [  OK  ]
Shutting down ALSA sound driver (version 1.0.4rc2): but first, terminating
(SIGTERM) pid 3019 ...

After that starting and stopping happens without problems.
Also, when I do this, restart alsa afterwards, and then stop the machine
alltogether, the freeze doesn't occur.

----------------------------------------------------------------------
 hjheins - 05-28-2004 20:43 CEST 
----------------------------------------------------------------------
Hmm,

forget that last remark..
It also freezes on halt or reboot after a restart of the alsa service.

Hendrik-Jan

----------------------------------------------------------------------
 hjheins - 06-04-2004 18:13 CEST 
----------------------------------------------------------------------
I just installed Alsa drivers 1.05a and that seems to work ok.

----------------------------------------------------------------------
 hjheins - 06-08-2004 17:37 CEST 
----------------------------------------------------------------------
Final remark:

It seems to have been related to the init script.
Apparently before I used an older init script that wouldn't work with alsa
1.0.4 or 1.0.5.
Currently I use the script that comes with alsa 1.0.5 and that works fine.

----------------------------------------------------------------------
 perex - 09-08-2004 18:20 CEST 
----------------------------------------------------------------------
New version solved problem.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
05-27-04 14:07 hjheins        New Bug                                      
05-27-04 14:07 hjheins        Distribution              => Mandrake 10.0 modified
05-27-04 14:07 hjheins        Kernel Version            => 2.6.6           
05-28-04 17:04 tiwai          Bugnote Added: 0001267                       
05-28-04 20:04 hjheins        Bugnote Added: 0001272                       
05-28-04 20:43 hjheins        Bugnote Added: 0001273                       
06-04-04 18:13 hjheins        Bugnote Added: 0001291                       
06-08-04 17:37 hjheins        Bugnote Added: 0001295                       
09-08-04 18:20 perex          Bugnote Added: 0001738                       
09-08-04 18:20 perex          Assigned To               => perex           
09-08-04 18:20 perex          Resolution               open => fixed       
09-08-04 18:20 perex          Status                   new => resolved     
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
