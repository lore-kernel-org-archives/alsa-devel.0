From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000021]: HDSP 9652 not recognized on boot 80-90% of the time
Date: Tue, 1 Feb 2005 22:10:22 +0100
Message-ID: <5187fca05c286d446ec2882ea7412650@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 3FAD218F
	for <alsa-devel@alsa-project.org>; Tue,  1 Feb 2005 22:10:23 +0100 (MET)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=21> 
======================================================================
Reported By:                Mark Knecht
Assigned To:                charbonnel
======================================================================
Project:                    ALSA - driver
Issue ID:                   21
Category:                   PCI - RME HDSP
Reproducibility:            random
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               Gentoo
Kernel Version:             2.4.22-rc2 &amp; others
Resolution:                 unable to duplicate
Fixed in Version:           
======================================================================
Date Submitted:             01-31-2004 23:13 CET
Last Modified:              02-01-2005 22:10 CET
======================================================================
Summary:                    HDSP 9652 not recognized on boot 80-90% of the time
Description: 
The HDSP 9652 is not recognized 80-90% of the time on boot. Restarting Alsa
in an xterm produces the same messages. Out of at least 20 boots this
afternoon only one has found the device. 
======================================================================

----------------------------------------------------------------------
 Mark Knecht - 02-01-05 21:41 
----------------------------------------------------------------------
Hi Thomas,
   I'll just report that I haven't seen this problem for a very long time.
Alsa and basic hdsp 9652 support for me is very good these days. I drive
my Pro Tools hardware everyday with the HDSP 9652 and things work great
here.

- Mark

----------------------------------------------------------------------
 charbonnel - 02-01-05 22:10 
----------------------------------------------------------------------
Unable to duplicate with current alsa versions.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-31-04 23:13 Mark Knecht    New Issue                                    
01-31-04 23:14 Mark Knecht    Note Added: 0000081                          
01-31-04 23:17 Mark Knecht    Note Added: 0000083                          
02-01-04 08:21 perex          Assigned To               => charbonnel      
02-01-04 08:21 perex          Status                   new => assigned     
02-01-04 08:21 perex          Category                 PCI - RME Digi9652/9636
=> PCI - RME HDSP
02-01-04 13:11 charbonnel     File Added: hdsp9652.patch                    
02-01-04 13:12 charbonnel     Note Added: 0000089                          
02-01-04 13:36 Mark Knecht    Note Added: 0000090                          
02-01-04 13:52 Mark Knecht    Note Added: 0000091                          
02-01-04 14:01 charbonnel     File Added: hdsp9652_2.patch                    
02-01-04 14:02 charbonnel     Note Added: 0000092                          
02-01-04 14:15 Mark Knecht    Note Added: 0000093                          
02-01-04 14:16 Mark Knecht    Note Edited: 0000093                         
02-01-04 14:18 Mark Knecht    Note Added: 0000094                          
02-01-04 14:53 charbonnel     Note Added: 0000095                          
02-01-04 15:05 Mark Knecht    Note Added: 0000096                          
02-01-04 15:42 charbonnel     File Added: hdsp9652_3.patch                    
02-01-04 15:43 charbonnel     Note Added: 0000097                          
02-01-04 17:55 Mark Knecht    Note Added: 0000099                          
02-01-04 17:59 Mark Knecht    Note Added: 0000100                          
02-01-04 18:00 Mark Knecht    Note Edited: 0000099                         
02-01-04 18:09 charbonnel     Note Added: 0000101                          
02-02-04 04:01 Mark Knecht    Note Added: 0000103                          
02-02-04 04:01 Mark Knecht    File Added: alsa-driver-1.0.2a.ebuild             
      
02-02-04 04:03 Mark Knecht    Note Edited: 0000103                         
02-02-04 04:04 Mark Knecht    Note Edited: 0000103                         
02-08-04 23:04 Mark Knecht    Note Added: 0000206                          
03-09-04 18:48 perex          Status                   assigned => resolved
03-09-04 18:48 perex          Resolution               open => suspended   
03-09-04 18:48 perex          Assigned To              charbonnel => perex 
03-09-04 18:48 perex          Note Added: 0000556                          
03-09-04 21:20 Mark Knecht    Status                   resolved => feedback
03-09-04 21:20 Mark Knecht    Resolution               suspended => reopened
03-09-04 21:21 Mark Knecht    Note Added: 0000558                          
03-12-04 12:50 perex          Assigned To              perex => charbonnel 
03-15-04 12:14 perex          Status                   feedback => assigned
05-08-04 03:36 charbonnel     Note Added: 0001067                          
05-08-04 06:14 Mark Knecht    Note Added: 0001068                          
05-08-04 06:14 nquit          Note Added: 0001069                          
05-09-04 21:30 charbonnel     Note Added: 0001073                          
05-09-04 23:08 Mark Knecht    Note Added: 0001074                          
05-09-04 23:53 nquit          Note Added: 0001075                          
05-09-04 23:58 nquit          Note Added: 0001076                          
05-12-04 11:32 charbonnel     Note Added: 0001091                          
02-01-05 21:12 charbonnel     Note Added: 0003464                          
02-01-05 21:41 Mark Knecht    Note Added: 0003468                          
02-01-05 22:10 charbonnel     Status                   assigned => resolved
02-01-05 22:10 charbonnel     Resolution               reopened => unable to
duplicate
02-01-05 22:10 charbonnel     Note Added: 0003473                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
