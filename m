From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001662]: No audio output in a laptop with hda-intel....
Date: Sun, 8 Jan 2006 13:54:13 +0100
Message-ID: <ffcb0fb874c61c88668fce88091334fe@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 7B181135
	for <alsa-devel@alsa-project.org>; Sun,  8 Jan 2006 13:54:14 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1662> 
======================================================================
Reported By:                shl
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1662
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo Linux
Kernel Version:             2.6.13.4
======================================================================
Date Submitted:             12-20-2005 11:18 CET
Last Modified:              01-08-2006 13:54 CET
======================================================================
Summary:                    No audio output in a laptop with hda-intel....
Description: 
Hy, I managed to install the hda-intel on my laptop but my big problem is
:
The speakers inside the laptop work correctly but everytime I try to plug
a headset or some external speaker in the output used normally for it, I'd
the same result : no sound in the laptop'speakers AND no sound at all in
the external speakers. So after looking a long long time about that
problem, I didn't find anything. So maybe the function is not yet
implemented ? If it's the case, is it possible to do it because it'll be
very usefull for a lot of people ! Thanks for advance and don't hesitate
to send me a mail if I missed something ...


======================================================================

----------------------------------------------------------------------
 shl - 12-23-05 02:04 
----------------------------------------------------------------------
In fact after looking a too much long time, I finally found the solution
...
But I'd some luck cause in not some very documented in the alsa.org'help
about hda-intel ; it's around the options hda-intel model=z71v needed in
the /etc/modules.d/alsa file to detect correctly the type of card... After
that, a update-module is recommended... So I'll put this point in the
official doc, I think it could be usefull for a lot and it can too avoid
some other people from wasting time ! Thanks however for the great work of
Alsa team developper and finally sorry for the disturbment. A happy user
:)

----------------------------------------------------------------------
 JeanJean - 01-08-06 13:54 
----------------------------------------------------------------------
Sorry i dont understand solution, what did you have done ?
I have Asus A6Vc with  Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) High Definition Audio Controller As sound card and have the same
problem

JeanJean

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-20-05 11:18 shl            New Issue                                    
12-20-05 11:18 shl            Distribution              => Gentoo Linux    
12-20-05 11:18 shl            Kernel Version            => 2.6.13.4        
12-20-05 11:19 shl            Issue Monitored: shl                         
12-20-05 11:19 shl            Issue End Monitor: shl                       
12-23-05 01:59 shl            Issue Monitored: shl                         
12-23-05 02:04 shl            Note Added: 0007130                          
01-08-06 13:54 JeanJean       Note Added: 0007525                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
