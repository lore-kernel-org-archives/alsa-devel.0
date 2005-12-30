From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001072]: 'Capture Source' and 'Mic Select' controls cannot be switched
Date: Fri, 30 Dec 2005 04:44:07 +0100
Message-ID: <053d6da31e72349b42224ba3a9e2fb06@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 39BA61A1
	for <alsa-devel@alsa-project.org>; Fri, 30 Dec 2005 04:44:07 +0100 (MET)
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
Last Modified:              12-30-2005 04:44 CET
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

$ cat /proc/asound/card0/codec97\#0/ac97\#0-0+regs | grep 0:1a
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

----------------------------------------------------------------------
 vsu - 04-24-05 13:21 
----------------------------------------------------------------------
The attached patch fixes the problem (bitmask calculation was buggy).

----------------------------------------------------------------------
 rlrevell - 12-30-05 04:44 
----------------------------------------------------------------------
Was this fixed in later ALSA releases?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-23-05 21:41 vsu            New Issue                                    
04-23-05 21:41 vsu            Distribution              => ALT Linux       
04-23-05 21:41 vsu            Kernel Version            => 2.6.11          
04-23-05 21:56 vsu            Note Added: 0004564                          
04-24-05 13:21 vsu            File Added: ac97-enum-fix.patch                   

04-24-05 13:21 vsu            Note Added: 0004565                          
12-30-05 04:44 rlrevell       Note Added: 0007221                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
