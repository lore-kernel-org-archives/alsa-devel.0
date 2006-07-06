From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002200]: PCM channel doesn't exist!
Date: Thu, 6 Jul 2006 15:52:43 +0200
Message-ID: <8b0a374dcf599c5a5022c9f88dd53fae@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 9DAF118D
	for <alsa-devel@alsa-project.org>;
	Thu,  6 Jul 2006 15:52:43 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2200> 
======================================================================
Reported By:                quetzyg
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2200
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Distribution:               Slackware
Kernel Version:             2.6.16.20 (but any version >= 2.6.16 should be
enough to reproduce this)
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             06-11-2006 17:50 CEST
Last Modified:              07-06-2006 15:52 CEST
======================================================================
Summary:                    PCM channel doesn't exist!
Description: 
Since the early release candidates of ALSA 1.0.11, up to the final version,
I seem to have lost the PCM channel from alsamixer.
======================================================================

----------------------------------------------------------------------
 quetzyg - 07-05-06 23:26 
----------------------------------------------------------------------
It seems that PCM doesn't like my asound.conf. I remove it, and now the PCM
sound controler works fine.

----------------------------------------------------------------------
 tiwai - 07-06-06 15:52 
----------------------------------------------------------------------
OK, then let's close this bug.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-11-06 17:50 quetzyg        New Issue                                    
06-11-06 17:50 quetzyg        Distribution              => Slackware       
06-11-06 17:50 quetzyg        Kernel Version            => 2.6.16.20 (but any
version >= 2.6.16 should be enough to reproduce this)
06-11-06 17:51 quetzyg        Issue Monitored: quetzyg                     
06-27-06 12:47 quetzyg        Note Added: 0010587                          
06-27-06 12:52 tiwai          Note Added: 0010589                          
06-27-06 12:59 quetzyg        Note Added: 0010590                          
06-29-06 17:46 tiwai          Note Added: 0010675                          
06-29-06 18:45 quetzyg        File Added: alsactl.out                      
06-29-06 18:46 quetzyg        File Added: lspci.out                        
06-29-06 18:51 quetzyg        Note Added: 0010692                          
07-05-06 23:26 quetzyg        Note Added: 0010843                          
07-06-06 15:52 tiwai          Status                   assigned => resolved
07-06-06 15:52 tiwai          Resolution               open => fixed       
07-06-06 15:52 tiwai          Note Added: 0010863                          
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
