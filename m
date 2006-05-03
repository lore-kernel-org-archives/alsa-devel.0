From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002094]: No sound from subwoofer
Date: Wed, 3 May 2006 20:24:39 +0200
Message-ID: <8d07cadab4621376ca2e4797d4f640f3@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 94CB721D
	for <alsa-devel@alsa-project.org>; Wed,  3 May 2006 20:24:39 +0200 (MEST)
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
Last Modified:              05-03-2006 20:24 CEST
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
 tiwai - 05-03-06 19:25 
----------------------------------------------------------------------
The codec is unknown.  Is it CM9738 or CM9739?

Upload the contents of /etc/asound.state and
/proc/asound/card0/codec97#0/* files.

Also, how did you test the surround outputs?  The standard test is
speaker-test program in alsa-utils package.  Run like below:

    % speaker-test -Dsurround51 -c6 -twav

----------------------------------------------------------------------
 oryn - 05-03-06 20:24 
----------------------------------------------------------------------
sorry its a CMI-9739 (submitted bug on friends pc)
speaker-test -Dsurround51 -c6 -twav results in:
Playback device is surround51
Stream parameters are 48000Hz, S16_LE, 6 channels
WAV file(s)
Playback open error: -16,Device or resource busy
Playback open error: -16,Device or resource busy
Playback open error: -16,Device or resource busy
Playback open error: -16,Device or resource busy
Playback open error: -16,Device or resource busy
Playback open error: -16,Device or resource busy
Playback open error: -16,Device or resource busy
Playback open error: -16,Device or resource busy
Playback open error: -16,Device or resource busy

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
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
