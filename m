From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000760]: alsa 32-bit emulation hangs computer
Date: Fri, 4 Feb 2005 18:02:16 +0100
Message-ID: <2907b29f514b7bc0bd18605e2ba70f9d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 19AD21ED
	for <alsa-devel@alsa-project.org>; Fri,  4 Feb 2005 18:02:17 +0100 (MET)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=760> 
======================================================================
Reported By:                bugfood
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   760
Category:                   OTHERS
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     closed
Distribution:               Debian 64-bit, &quot;gcc-3.4 flavor&quot;
Kernel Version:             2.6.10, 64-bit
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             12-30-2004 07:28 CET
Last Modified:              02-04-2005 18:02 CET
======================================================================
Summary:                    alsa 32-bit emulation hangs computer
Description: 
I'm working on setting up the 64-bit port of Debian on my computer. So far
so good, except that running 32-bit alsa programs within a chroot causes
the computer to hang and become almost completely unresponsive; all I can
do is use magic SysRq to reboot. There are no messages from the kernel in
/var/log/messages or reported to the console.

64-bit alsa programs work fine
64-bit oss programs work fine
32-bit oss programs work fine

I've tested with an SB Live and with my motherboard's onboard i810 audio -
both have the same problem.


======================================================================

----------------------------------------------------------------------
 tiwai - 12-30-04 15:04 
----------------------------------------------------------------------
It's fixed in the recent ALSA.  Try ALSA 1.0.8rc1.

----------------------------------------------------------------------
 bugfood - 12-31-04 06:57 
----------------------------------------------------------------------
Thanks tiwai. I didn't realize there was a new version out yet. I compiled
and installed alsa-driver 1.0.8rc1, and the problem is fixed.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-30-04 07:28 bugfood        New Issue                                    
12-30-04 07:28 bugfood        File Added: config-2.6.10                    
12-30-04 07:28 bugfood        Distribution              => Debian 64-bit,
"gcc-3.4 flavor"
12-30-04 07:28 bugfood        Kernel Version            => 2.6.10, 64-bit  
12-30-04 15:04 tiwai          Note Added: 0003021                          
12-31-04 06:57 bugfood        Note Added: 0003025                          
01-03-05 12:10 tiwai          Status                   new => resolved     
01-03-05 12:10 tiwai          Resolution               open => fixed       
01-03-05 12:10 tiwai          Assigned To               => tiwai           
01-03-05 12:10 tiwai          Assigned To              tiwai =>            
01-07-05 02:32 chutzimir      Issue Monitored: chutzimir                    
02-04-05 18:02 tiwai          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
