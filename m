From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001203]: mtpav driver locks X on 64 bit native system
Date: Tue, 25 Apr 2006 13:18:30 +0200
Message-ID: <7ac0f33f2a6aa357bcf71e33336bcb93@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 8247716B
	for <alsa-devel@alsa-project.org>; Tue, 25 Apr 2006 13:18:31 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1203> 
======================================================================
Reported By:                sonofzev
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1203
Category:                   GENERIC - mtpav
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     new
Distribution:               Gentoo 2004.3 - 64-bit native
Kernel Version:             2.6.9 or 2.6.11 or 2.6.12
======================================================================
Date Submitted:             06-19-2005 08:51 CEST
Last Modified:              04-25-2006 13:18 CEST
======================================================================
Summary:                    mtpav driver locks X on 64 bit native system
Description: 
Locks system completely when loading X if mtpav module is already loaded. 

If loading the module after loading X, the system completely lock when
firing up any sequencer app. 

This does not happen on my 32-bit Pentium 4 

======================================================================

----------------------------------------------------------------------
 sonofzev - 06-27-05 19:39 
----------------------------------------------------------------------
confirmed that I am using IRQ7 for my printer port.

----------------------------------------------------------------------
 sonofzev - 04-25-06 13:18 
----------------------------------------------------------------------
Still not working

have tested settings and was able to achieve successful playback only when
giving the system an incorrect IRQ (3). 

When pointing to the correct settings the system still locks up.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-19-05 08:51 sonofzev       New Issue                                    
06-19-05 08:51 sonofzev       Distribution              => Gentoo 2004.3 -
64-bit native
06-19-05 08:51 sonofzev       Kernel Version            => 2.6.9 or 2.6.11 or
2.6.12
06-19-05 16:05 sonofzev       Note Added: 0005089                          
06-19-05 16:24 sonofzev       Note Deleted: 0005089                        
06-20-05 13:47 sonofzev       Note Added: 0005097                          
06-21-05 11:25 tiwai          Note Added: 0005104                          
06-26-05 10:54 sonofzev       Note Added: 0005261                          
06-27-05 16:57 tiwai          Note Added: 0005281                          
06-27-05 19:39 sonofzev       Note Added: 0005286                          
06-27-05 19:40 sonofzev       Issue Monitored: sonofzev                    
04-25-06 13:18 sonofzev       Note Added: 0009488                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
