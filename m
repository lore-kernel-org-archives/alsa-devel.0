From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000749]: Buzz from ALSA setup
Date: Sun, 26 Dec 2004 16:44:42 +0100
Message-ID: <59688609402286a2d8f67a641ea9bb89@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 8CD1C283
	for <alsa-devel@alsa-project.org>; Sun, 26 Dec 2004 16:44:42 +0100 (MET)
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


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=749> 
======================================================================
Reported By:                misnagid
Assigned To:                pzad
======================================================================
Project:                    ALSA - driver
Issue ID:                   749
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Fedora FC3
Kernel Version:             2.6.9
======================================================================
Date Submitted:             12-26-2004 15:37 CET
Last Modified:              12-26-2004 16:44 CET
======================================================================
Summary:                    Buzz from ALSA setup
Description: 
I get an almost constant buzz from speakers when I've tried to use ALSA. 
Have followed your directions from the online web page directions to the
letter.  Still buzz.
Have brought all sound levels up ising alsamixer and Kmix.  Of no help. 
Have tried everything I've seen about this problem.
OnBoard NVidia audio from Asus A7N8X-E Deluxe disabled.  Using emu10k1
driver for installed Creative Labs Audigy 2 soundcard. This is a brand new
successful in all other regards install of Fedora FC3.

======================================================================

----------------------------------------------------------------------
 misnagid - 12-26-04 16:31 
----------------------------------------------------------------------
Thanks for reply!!  alsamixer does not have those options.  But KMix does. 
When I do that, I get no sound at all.  Naturally, as everybody has
suggested, I have brought all the levels up.  But still no sound.

Thanks for your reply!  Any other ideas?  Would sure love some sound!

Yours,
Jerry

----------------------------------------------------------------------
 misnagid - 12-26-04 16:44 
----------------------------------------------------------------------
Maybe this might help?  When I try to select ALSA for Control Centre|Sound
and MultiMedia|Sound System|Hardware. Get Knotify KDE Crash Handler signal
11 SIGSEGV error. Backtrace says:
Using host libthread_db library "/lib/tls/libthread_db.so.1".
0x007167a2 in typeinfo for KNetwork::KServerSocket ()
   from /usr/lib/libkdecore.so.4
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=0  0x007167a2 in typeinfo
for KNetwork::KServerSocket ()
   from /usr/lib/libkdecore.so.4
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1  0x00539403 in ?? ()
from /usr/lib/libkdecore.so.4
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2  0x003f2edc in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3  0x0031e320 in ?? ()
from /usr/lib/libkparts.so.2
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=4  0x0000391f in ?? ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=5  0x00000000 in ?? ()

Thanks!!!
Jerr

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-26-04 15:37 misnagid       New Issue                                    
12-26-04 15:37 misnagid       Distribution              => Fedora FC3      
12-26-04 15:37 misnagid       Kernel Version            => 2.6.9           
12-26-04 15:58 pzad           Note Added: 0002935                          
12-26-04 16:31 misnagid       Note Added: 0002936                          
12-26-04 16:44 misnagid       Note Added: 0002937                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
