From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002217]: Problems with ASUS A6Km
Date: Mon, 26 Jun 2006 16:11:34 +0200
Message-ID: <07037ea790fcc19b2e8ef6fd831caa08@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 23E291A8
	for <alsa-devel@alsa-project.org>;
	Mon, 26 Jun 2006 16:11:35 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2217> 
======================================================================
Reported By:                mafm
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2217
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               
Kernel Version:             
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             06-18-2006 05:06 CEST
Last Modified:              06-26-2006 16:11 CEST
======================================================================
Summary:                    Problems with ASUS A6Km
Description: 
I have the same problems described here:
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1898 , but I'm
opening a new report because I can't find a way to add a comment there.

I tried that asus-a6km-fix.diff but it doesn't work, in fact it doesn't
appear to have any effect at all.
======================================================================

----------------------------------------------------------------------
 eNTi - 06-25-06 11:32 
----------------------------------------------------------------------
i obviously was mistaken. i must have looked in the wrong place???

after i applied the patch, it worked again, but i could have sworn, that
i've seen the patch applied before. sorry for the confusion.

then only 3 activated levers in alsamixer, are Master, PCM and External
Amplifier.

----------------------------------------------------------------------
 tiwai - 06-26-06 16:11 
----------------------------------------------------------------------
OK, then let's close this bug finally.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-18-06 05:06 mafm           New Issue                                    
06-18-06 16:51 ryswic         Issue Monitored: ryswic                      
06-19-06 15:49 mafm           Issue Monitored: mafm                        
06-19-06 15:50 mafm           Note Added: 0010315                          
06-20-06 19:46 tiwai          Note Added: 0010345                          
06-20-06 20:16 mafm           Note Added: 0010354                          
06-21-06 21:37 eNTi           Note Added: 0010405                          
06-21-06 22:24 rlrevell       Note Added: 0010406                          
06-21-06 22:33 mafm           Note Added: 0010407                          
06-21-06 22:48 eNTi           Note Added: 0010408                          
06-22-06 00:10 mafm           Note Added: 0010410                          
06-23-06 15:27 mafm           Note Added: 0010451                          
06-23-06 15:55 mafm           File Added: asus-a6km-fix.diff                    
06-23-06 16:23 mafm           Note Added: 0010454                          
06-24-06 09:12 eNTi           Note Added: 0010467                          
06-24-06 10:26 Raymond        Note Added: 0010470                          
06-24-06 10:30 Raymond        Note Edited: 0010470                         
06-24-06 14:32 mafm           Note Added: 0010473                          
06-24-06 15:17 hongqn         Issue Monitored: hongqn                      
06-25-06 11:32 eNTi           Note Added: 0010505                          
06-26-06 16:11 tiwai          Status                   new => resolved     
06-26-06 16:11 tiwai          Resolution               open => fixed       
06-26-06 16:11 tiwai          Assigned To               => tiwai           
06-26-06 16:11 tiwai          Note Added: 0010543                          
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
