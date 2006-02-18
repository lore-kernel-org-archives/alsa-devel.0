From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001855]: no sound with openal
Date: Sat, 18 Feb 2006 20:24:41 +0100
Message-ID: <9905f332feb3f52a855edc6d6c03abdb@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 40A0018B
	for <alsa-devel@alsa-project.org>; Sat, 18 Feb 2006 20:24:41 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1855> 
======================================================================
Reported By:                eiz
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1855
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Debian
Kernel Version:             2.6.15.3
======================================================================
Date Submitted:             02-18-2006 20:24 CET
Last Modified:              02-18-2006 20:24 CET
======================================================================
Summary:                    no sound with openal
Description: 
when forcing ( define devices '(alsa native) ) in .openalrc
no sound at all and no error 
tested with openal own demo and ut2004

openal 0.2005080600-2.1 or openal-alsa-emu10k1-1.2
kernel 2.6.15.3

cat ~/.asoundrc
pcm.emu10k1 {
           type hw
           card 0
}
ctl.emu10k1 {
           type hw
           card 0
}

NOTES : 
- maybe useful tip : I noticed mmap call seems broken on amd64
- my surround51 device through spdiff is working very well with 
  aplay -c 6 -D surround51

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-18-06 20:24 eiz            New Issue                                    
02-18-06 20:24 eiz            File Added: openal-demo-strace.txt.gz             
      
02-18-06 20:24 eiz            Distribution              => Debian          
02-18-06 20:24 eiz            Kernel Version            => 2.6.15.3        
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
