From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000382]: line in doesn't give stereo sound
Date: Mon, 30 Aug 2004 10:20:41 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040830082041.60B9E3B024@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id C033920F
	for <alsa-devel@alsa-project.org>; Mon, 30 Aug 2004 10:20:41 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000382
======================================================================
Reported By:                labra
Assigned To:                
======================================================================
Project:                    ALSA - driver
Bug ID:                     382
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Gentoo
Kernel Version:             2.4.26
======================================================================
Date Submitted:             07-13-2004 13:51 CEST
Last Modified:              08-30-2004 10:20 CEST
======================================================================
Summary:                    line in doesn't give stereo sound
Description: 
The line in-plug doesn't give stereo sound anymore. Before with alsamixer I
was able to get stereo sound from line in by using "H/W In 0" and "H/W IN
1". Now only "H/W In 0" gives sound.
======================================================================

----------------------------------------------------------------------
 labra - 07-13-2004 13:59 CEST 
----------------------------------------------------------------------
The alsa-driver version with this feature/bug is 1.0.5a.

----------------------------------------------------------------------
 tiwai - 08-19-2004 19:10 CEST 
----------------------------------------------------------------------
Try 1.0.6a.  The capture source is chosen via 'Capture Source' control.
There are two controls for left and right, index 0 and 1, respectively.

Note that aureon on 1.0.6a has a bug that the master volume is
inverted.  Set master 0 to get the max volume.
(Already fixed on CVS version)

----------------------------------------------------------------------
 labra - 08-30-2004 10:20 CEST 
----------------------------------------------------------------------
Thank you! Updating to 1.0.6a helped to the problem! This bug can be closed
now...

Bug History
Date Modified  Username       Field                    Change              
======================================================================
07-13-04 13:51 labra          New Bug                                      
07-13-04 13:51 labra          Distribution              => Gentoo          
07-13-04 13:51 labra          Kernel Version            => 2.4.26          
07-13-04 13:59 labra          Bugnote Added: 0001413                       
07-13-04 13:59 labra          Bug Monitored: labra                         
08-19-04 19:10 tiwai          Bugnote Added: 0001591                       
08-30-04 10:20 labra          Bugnote Added: 0001665                       
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
