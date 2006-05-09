From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000758]: Full duplex is not working in OSS emulation.
Date: Tue, 9 May 2006 15:49:10 +0200
Message-ID: <187cf210f3316a5cb3938dfb5f1fe8f5@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id CC2031A9
	for <alsa-devel@alsa-project.org>; Tue,  9 May 2006 15:49:10 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=758> 
======================================================================
Reported By:                croiset
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   758
Category:                   PCI - RME 96
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Redhat 7.2
Kernel Version:             2.4.7
======================================================================
Date Submitted:             12-29-2004 10:15 CET
Last Modified:              05-09-2006 15:49 CEST
======================================================================
Summary:                    Full duplex is not working in OSS emulation.
Description: 
If I play something with one player, I am unable to record something on the
same device.
The same thing ispossible with the other cards I have.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0000521 Jack + Alsa not working in full duplex,...
======================================================================

----------------------------------------------------------------------
 croiset - 05-09-06 14:09 
----------------------------------------------------------------------
I do the same test with alsa driver 1.0.11.

I am able to record if I am not playing at the same time. If I am playing
I obtain the open error at the same place as before.

----------------------------------------------------------------------
 croiset - 05-09-06 15:49 
----------------------------------------------------------------------
We put some logs in rme96.c for debugging the problem.

We obtain this :

The function snd_rme96_capture_hw_params returns -EBUSY when we open the
analog capture device when the analog output device is already opened in
play mode because :

rme96->playback_periodsize = 2048
rme96->capture_frlog = 2
params_period_size(params)=2048

then the tsst in line 1052 (alsa 1.0.11) is valid and then returns -EBUSY

If the analog output device is not opened, when we capture, the values are
:
rme96->playback_periodsize = 0
rme96->capture_frlog = 2
params_period_size(params)=2048

then the test is not valid and the device is working.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-29-04 10:15 croiset        New Issue                                    
12-29-04 10:15 croiset        Distribution              => Redhat 7.2      
12-29-04 10:15 croiset        Kernel Version            => 2.4.7           
12-29-04 14:17 tiwai          Note Added: 0002998                          
12-29-04 14:54 croiset        Note Added: 0003000                          
12-29-04 17:39 tiwai          Note Added: 0003004                          
12-29-04 17:56 croiset        Note Added: 0003005                          
12-29-04 17:59 croiset        Note Added: 0003006                          
12-29-04 18:05 croiset        Note Edited: 0003006                         
12-29-04 18:18 croiset        Note Edited: 0003006                         
01-03-05 16:30 croiset        Note Added: 0003067                          
09-14-05 16:16 jdthood        Relationship added       related to 0000521  
12-30-05 23:08 rlrevell       Note Added: 0007278                          
01-02-06 09:12 croiset        Note Added: 0007368                          
05-09-06 14:09 croiset        Note Added: 0009657                          
05-09-06 15:49 croiset        Note Added: 0009659                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
