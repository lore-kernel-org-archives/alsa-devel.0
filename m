From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001072]: 'Capture Source' and 'Mic Select' controls cannot be switched
Date: Sat, 23 Apr 2005 21:41:07 +0200
Message-ID: <979c241d697a26307d485ea8642582e8@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 33819217
	for <alsa-devel@alsa-project.org>; Sat, 23 Apr 2005 21:41:08 +0200 (MEST)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1072> 
======================================================================
Reported By:                vsu
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1072
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               ALT Linux
Kernel Version:             2.6.11
======================================================================
Date Submitted:             04-23-2005 21:41 CEST
Last Modified:              04-23-2005 21:41 CEST
======================================================================
Summary:                    'Capture Source' and 'Mic Select' controls cannot be
switched
Description: 
With ALSA CVS snapshots from 2005-04-09 and 2005-04-23 it is not possible
to select capture source.  I have tried alsamixer, amixer, and even
"alsactl restore" (by editing the state file directly), but no matter what
is done, the 'Capture Source' control is still set to 'Mic':

        control.26 {
                comment.access 'read write'
                comment.type ENUMERATED
                comment.count 2
                comment.item.0 Mic
                comment.item.1 CD
                comment.item.2 Video
                comment.item.3 Aux
                comment.item.4 Line
                comment.item.5 Mix
                comment.item.6 'Mix Mono'
                comment.item.7 Phone
                iface MIXER
                name 'Capture Source'
                value.0 Mic
                value.1 Mic
        }

However, the AC'97 register 0x1a which should be controlled by this
control has value which corresponds to 'Phone', not 'Mic':

$ cat
/proc/asound/card0/codec97\https://bugtrack.alsa-project.org/alsa-bug/view.php?id=0/ac97\https://bugtrack.alsa-project.org/alsa-bug/view.php?id=0-0+regs
| grep 0:1a
0:1a = 0707

Changing the register value directly by writing into the proc file
produces the desired result - the recording source changes, however, the
mixer control stays nonfunctional.

I also noticed that the 'Mic Select' control is fixed to 'Mic1' and cannot
be changed.

With alsa-driver-1.0.8 both controls work. Updating first alsa-lib, then
alsa-utils from 1.0.8 to the 2005-04-23 CVS snapshot did not change this
behavior.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-23-05 21:41 vsu            New Issue                                    
04-23-05 21:41 vsu            Distribution              => ALT Linux       
04-23-05 21:41 vsu            Kernel Version            => 2.6.11          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
