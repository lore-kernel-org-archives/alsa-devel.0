From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000476]: ALSA driver does not work with VIA VT8233 [AC97 Audio Controller]
Date: Tue, 31 Aug 2004 20:16:51 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040831181651.0F7DC3F019@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 96181232
	for <alsa-devel@alsa-project.org>; Tue, 31 Aug 2004 20:16:51 +0200 (MEST)
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


A BUGNOTE has been added to this bug.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000476
======================================================================
Reported By:                babayaga
Assigned To:                
======================================================================
Project:                    ALSA - driver
Bug ID:                     476
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             08-31-2004 01:01 CEST
Last Modified:              08-31-2004 20:16 CEST
======================================================================
Summary:                    ALSA driver does not work with VIA VT8233 [AC97 Audio Controller]
Description: 
Please, see the full report at
http://qa.mandrakesoft.com/show_bug.cgi?id=10859
======================================================================

----------------------------------------------------------------------
 tiwai - 08-31-2004 12:27 CEST 
----------------------------------------------------------------------
Above all, try the latest ALSA driver.
If still not work, try dxs_support=2 module option for snd-via82xx.
Also, ac97_quirk=1 module option might help in such a case.

Make sure that the volume is unmuted and adjusted.  Attach
/etc/asound.state for debugging if the above doesn't work.
Also, don't load via82cxx_audio module at the same time.
You set it as sound-slot-0 in /etc/modprobe.conf, which might
cause conflicts.

----------------------------------------------------------------------
 babayaga - 08-31-2004 20:16 CEST 
----------------------------------------------------------------------
Tried that all - in vain. Attaching new conf-files, maybe, I am missing
smth?
Version of snd-via82xx is as supplied with kernel 2.6.8 (2.6.8.1-2mdk more
exactly) I do not know how to get the version otherwise...
What else can I do?
Thanks!

Bug History
Date Modified  Username       Field                    Change              
======================================================================
08-31-04 01:01 babayaga       New Bug                                      
08-31-04 12:27 tiwai          Bugnote Added: 0001670                       
08-31-04 20:10 babayaga       File Added: asound.state                     
08-31-04 20:11 babayaga       File Added: modprobe.conf                    
08-31-04 20:11 babayaga       File Added: modules.conf                     
08-31-04 20:16 babayaga       Bugnote Added: 0001674                       
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
