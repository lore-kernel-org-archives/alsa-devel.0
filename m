From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001733]: Intel HDA Modem ?
Date: Sun, 23 Apr 2006 01:12:18 +0200
Message-ID: <210e7e8c2e6021e007995fe9836d15e7@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E2CF1110
	for <alsa-devel@alsa-project.org>; Sun, 23 Apr 2006 01:12:18 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1733> 
======================================================================
Reported By:                chrmue
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1733
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Distribution:               SuSE Linux 10.0
Kernel Version:             2.6.13-15
Resolution:                 fixed
Fixed in Version:           1.0.11
======================================================================
Date Submitted:             01-11-2006 07:23 CET
Last Modified:              04-23-2006 01:12 CEST
======================================================================
Summary:                    Intel HDA Modem ?
Description: 
I want to use my HDA Softmodem in Linux, is there any development on a HDA
Modem Module ?

cat /proc/asound/card0/codec#1 gives me:
Codec: Generic 11c1 ID 3026
Address: 1
Vendor Id: 0x11c13026
Subsystem Id: 0x11c13026
Revision Id: 0x70500

In Windows it is called "Agere Systems HDA Modem" (Conexant ?)

If there is development on this i would like to participate to get it
going, because i dont't want to have a windows-installation on my Notebook
(Acer TravelMate 8104) just for getting my mails at my parents house,
where there is only analog telephone.
======================================================================

----------------------------------------------------------------------
 rlrevell - 04-23-06 01:06 
----------------------------------------------------------------------
Please open a new bug report for different hardware

----------------------------------------------------------------------
 rlrevell - 04-23-06 01:12 
----------------------------------------------------------------------
Submitter reports this bug is fixed

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-11-06 07:23 chrmue         New Issue                                    
01-11-06 07:23 chrmue         Distribution              => SuSE Linux 10.0 
01-11-06 07:23 chrmue         Kernel Version            => 2.6.13-15       
01-11-06 07:42 rlrevell       Note Added: 0007559                          
01-11-06 23:32 sashak         File Added: hda-modem-si3054-11c13026.patch       
            
01-11-06 23:35 sashak         Note Added: 0007571                          
01-12-06 00:00 sashak         Note Added: 0007574                          
01-12-06 00:02 sashak         Issue Monitored: sashak                      
01-12-06 05:35 chrmue         Note Added: 0007581                          
01-13-06 00:16 sashak         Note Added: 0007598                          
01-16-06 20:19 chrmue         Note Added: 0007692                          
01-16-06 20:22 chrmue         Issue Monitored: chrmue                      
03-03-06 15:43 lrupn          Note Added: 0008341                          
03-03-06 15:44 lrupn          Issue Monitored: lrupn                       
03-10-06 23:44 kratz00        Note Added: 0008413                          
03-11-06 15:19 kratz00        Note Added: 0008416                          
03-11-06 19:03 rlrevell       Note Added: 0008421                          
03-11-06 19:23 kratz00        Note Added: 0008423                          
03-11-06 19:33 rlrevell       Note Added: 0008424                          
03-11-06 23:08 sashak         Note Added: 0008427                          
03-12-06 11:22 kratz00        Note Added: 0008431                          
03-15-06 00:42 chrmue         Note Added: 0008525                          
03-15-06 11:35 tiwai          Note Added: 0008530                          
03-15-06 21:42 kratz00        Note Added: 0008573                          
03-15-06 21:42 kratz00        Issue Monitored: kratz00                     
03-16-06 02:17 sashak         Note Added: 0008581                          
03-16-06 19:44 kratz00        Note Added: 0008619                          
04-23-06 01:04 fdoffizi01     Note Added: 0009436                          
04-23-06 01:06 rlrevell       Note Added: 0009437                          
04-23-06 01:12 rlrevell       Status                   assigned => resolved
04-23-06 01:12 rlrevell       Fixed in Version          => 1.0.11          
04-23-06 01:12 rlrevell       Resolution               open => fixed       
04-23-06 01:12 rlrevell       Note Added: 0009438                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
