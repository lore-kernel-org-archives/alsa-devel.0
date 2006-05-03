From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002094]: No sound from subwoofer
Date: Wed, 3 May 2006 20:33:34 +0200
Message-ID: <919b2d4491cf0d93c7f031daec5e6e9e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 519AE21D
	for <alsa-devel@alsa-project.org>; Wed,  3 May 2006 20:33:34 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2094> 
======================================================================
Reported By:                oryn
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2094
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               debian
Kernel Version:             2.6.15.5
======================================================================
Date Submitted:             05-03-2006 00:02 CEST
Last Modified:              05-03-2006 20:33 CEST
======================================================================
Summary:                    No sound from subwoofer
Description: 
The subwoofer has stopped working, it used to work on 1.0.9 as rear-left.
And before that it even used to be LFE.
I used a .asoundrc script to funnel L+R > rear-left.
I have tried removing the .asoundrc script and running speaker-test -c6
and I only get sound from front-left and front-right.

I don't know if there is something to do with the new intel-hda patch as
thats the sound system that the "NEW" asus W1000 uses.

======================================================================

----------------------------------------------------------------------
 oryn - 05-03-06 20:31 
----------------------------------------------------------------------
cat /proc/asound/card0/codec97#0/ac97#0-0+regs 
0:00 = 0000
0:02 = 0000
0:04 = 8000
0:06 = 0000
0:08 = 0000
0:0a = 0006
0:0c = 801f
0:0e = 801f
0:10 = 9f1f
0:12 = 9f1f
0:14 = 9f1f
0:16 = 0000
0:18 = 0000
0:1a = 0000
0:1c = 0000
0:1e = 0000
0:20 = 0000
0:22 = 0000
0:24 = 0000
0:26 = 000f
0:28 = 05c6
0:2a = 05f4
0:2c = 0000
0:2e = 0000
0:30 = 0000
0:32 = 0000
0:34 = 0000
0:36 = 0000
0:38 = 0000
0:3a = 2824
0:3c = 0000
0:3e = 0000
0:40 = 0000
0:42 = 0000
0:44 = 0000
0:46 = 0000
0:48 = 0000
0:4a = 0000
0:4c = 0000
0:4e = 0000
0:50 = 0000
0:52 = 0000
0:54 = 0000
0:56 = 0000
0:58 = 0000
0:5a = 0000
0:5c = 0000
0:5e = 0612
0:60 = 0000
0:62 = 0000
0:64 = 6008
0:66 = 0004
0:68 = 0000
0:6a = 0000
0:6c = 0000
0:6e = 0000
0:70 = 0100
0:72 = 0020
0:74 = 0000
0:76 = 0000
0:78 = 0000
0:7a = 0000
0:7c = 434d
0:7e = 4961

----------------------------------------------------------------------
 oryn - 05-03-06 20:33 
----------------------------------------------------------------------
I don't have /etc/asound.state I think debian takes care of that somewhere
else.
Sorry for all the notes, my stupid browser doesn't want to brows the /proc
directory.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-03-06 00:02 oryn           New Issue                                    
05-03-06 00:02 oryn           Distribution              => debian          
05-03-06 00:02 oryn           Kernel Version            => 2.6.15.5        
05-03-06 11:46 tiwai          Note Added: 0009587                          
05-03-06 16:45 oryn           Note Added: 0009595                          
05-03-06 19:25 tiwai          Note Added: 0009599                          
05-03-06 20:24 oryn           Note Added: 0009602                          
05-03-06 20:28 oryn           Note Added: 0009603                          
05-03-06 20:31 oryn           Note Added: 0009604                          
05-03-06 20:33 oryn           Note Added: 0009605                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
