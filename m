From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000450]: Line In only gives left channel - no stereo recording/listening
Date: Fri, 24 Sep 2004 13:42:09 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040924114209.B9EEC101DE@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 051A4288
	for <alsa-devel@alsa-project.org>; Fri, 24 Sep 2004 13:42:10 +0200 (MEST)
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


The following bug has been CLOSED
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000450
======================================================================
Reported By:                ZaphodB
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Bug ID:                     450
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               Debian unstable/testing/experimental
Kernel Version:             2.6.8.1
======================================================================
Date Submitted:             08-18-2004 02:04 CEST
Last Modified:              09-24-2004 13:42 CEST
======================================================================
Summary:                    Line In only gives left channel - no stereo recording/listening
Description: 
Whatever stunts i do with alsamixer, selecting Line IN as capture source
leaves me with one channel (left) on output hw/0 - hw/1 does neither
contains the right channel nor does setting the hw/1 output to hw/0
provide me with a stereo signal. Same with recording from Line, audacity
shows good input signal (waveform pattern) for the left channel but
absolutely nothing for right.
======================================================================

----------------------------------------------------------------------
 ZaphodB - 08-18-2004 02:08 CEST 
----------------------------------------------------------------------
forgot: stereo-recording from Line In with audacity works with WindowsXP
;-)

----------------------------------------------------------------------
 ZaphodB - 08-18-2004 02:17 CEST 
----------------------------------------------------------------------
sorry, overlooked BugID 0000382 reporting basically same bug.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
08-18-04 02:04 ZaphodB        New Bug                                      
08-18-04 02:04 ZaphodB        Distribution              => Debian unstable/testing/experimental
08-18-04 02:04 ZaphodB        Kernel Version            => 2.6.8.1         
08-18-04 02:08 ZaphodB        Bugnote Added: 0001573                       
08-18-04 02:17 ZaphodB        Bugnote Added: 0001574                       
08-19-04 19:08 tiwai          duplicate_id             0 => 382            
08-19-04 19:08 tiwai          Assigned To               => tiwai           
08-19-04 19:08 tiwai          Resolution               open => duplicate   
08-19-04 19:08 tiwai          Status                   new => resolved     
09-24-04 13:42 tiwai          Status                   resolved => closed  
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
