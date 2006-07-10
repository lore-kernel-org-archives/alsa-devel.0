From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001378]: Surround Channel and Surround
	mixer doesn't work with a CM9761chip
Date: Mon, 10 Jul 2006 18:01:43 +0200
Message-ID: <51eb7e79289038aac11cae66b4a5f02a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id F332F244
	for <alsa-devel@alsa-project.org>;
	Mon, 10 Jul 2006 18:01:43 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1378> 
======================================================================
Reported By:                midnight
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1378
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               Debian Sid
Kernel Version:             2.6.12.5
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             08-30-2005 11:33 CEST
Last Modified:              07-10-2006 18:01 CEST
======================================================================
Summary:                    Surround Channel and Surround mixer doesn't work
with a CM9761chip
Description: 
The sound works fine on the center, LFE an front channels but I have no
sound on the rear channel. also, I can't change the volume of the surround
mixer in alsamixer (I can juste mute/unmute it).

I use the surround51 device to play my test sound and my test sound is a 6
channels one.

I use the via82xx module

thanks
======================================================================

----------------------------------------------------------------------
 tiwai - 10-20-05 14:55 
----------------------------------------------------------------------
... or try 1.0.10rc2.

----------------------------------------------------------------------
 midnight - 11-03-05 12:26 
----------------------------------------------------------------------
all seams to work fine with the last CVS.


Thank you very much for your help and support.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-30-05 11:33 midnight       New Issue                                    
08-30-05 11:33 midnight       Distribution              => Debian Sid      
08-30-05 11:33 midnight       Kernel Version            => 2.6.12.5        
09-07-05 11:20 midnight       Note Added: 0006053                          
09-07-05 15:32 tiwai          Note Added: 0006054                          
09-08-05 01:10 midnight       Note Added: 0006069                          
09-08-05 18:58 tiwai          Note Added: 0006076                          
09-08-05 19:00 midnight       Note Added: 0006077                          
09-08-05 19:12 tiwai          Note Added: 0006080                          
09-08-05 19:58 midnight       Note Added: 0006081                          
09-08-05 20:42 tiwai          Note Added: 0006082                          
09-08-05 20:44 tiwai          Note Added: 0006083                          
09-08-05 23:20 midnight       Note Added: 0006084                          
09-09-05 12:47 tiwai          Note Added: 0006096                          
09-09-05 14:16 midnight       File Added: ac97#0-0                         
09-09-05 14:16 midnight       File Added: asound.state                     
09-09-05 14:21 midnight       Note Added: 0006097                          
09-09-05 14:29 tiwai          Note Added: 0006098                          
09-09-05 14:54 midnight       Note Added: 0006099                          
09-09-05 16:32 tiwai          Note Added: 0006100                          
09-09-05 19:50 midnight       Note Added: 0006104                          
09-09-05 20:14 tiwai          Note Added: 0006105                          
09-09-05 23:41 midnight       Note Added: 0006106                          
09-13-05 18:27 tiwai          Note Added: 0006155                          
09-18-05 12:05 midnight       Note Added: 0006270                          
09-18-05 15:59 midnight       Note Edited: 0006270                         
09-24-05 14:34 midnight       Note Added: 0006370                          
10-05-05 19:04 tiwai          Note Added: 0006439                          
10-10-05 23:26 midnight       Note Added: 0006450                          
10-11-05 16:27 tiwai          Note Added: 0006451                          
10-20-05 14:55 tiwai          Note Added: 0006506                          
11-03-05 12:24 midnight       Issue Monitored: midnight                    
11-03-05 12:26 midnight       Note Added: 0006602                          
11-13-05 12:02 midnight       Issue End Monitor: midnight                    
07-10-06 18:01 Adrian Bunk    Status                   new => resolved     
07-10-06 18:01 Adrian Bunk    Resolution               open => fixed       
======================================================================




-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
