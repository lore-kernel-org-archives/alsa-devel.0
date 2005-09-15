From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000238]: spdif output fails with atiixp
Date: Fri, 16 Sep 2005 01:16:38 +0200
Message-ID: <c949598e827cd6052759ab3d267cff78@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 85A41101
	for <alsa-devel@alsa-project.org>; Fri, 16 Sep 2005 01:16:39 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=238> 
======================================================================
Reported By:                pkashou
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   238
Category:                   PCI - atiixp
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     feedback
Distribution:               Gentoo
Kernel Version:             gentoo-dev-sources 2.6.5 (running cvs alsa in
kernel)
======================================================================
Date Submitted:             04-27-2004 03:54 CEST
Last Modified:              09-16-2005 01:16 CEST
======================================================================
Summary:                    spdif output fails with atiixp
Description: 
When running ALSA 1.0.4rc2 included in 2.6.5 kernel, spdif output was
intermittant, almost complete static. Updating kernel alsa to latest cvs
caused spdif output to stop completely. 

dmesg reports no errors. Everything appears configured, but there is zero
output on the spdif line - no light through wire.

>aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: IXP [ATI IXP], device 0: ATI IXP AC97 [ATI IXP AC97]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: IXP [ATI IXP], device 1: ATI IXP IEC958 [ATI IXP IEC958]
  Subdevices: 1/1
  Subdevice #0: subdevice #0


>cat /proc/asound/devices
  1:       : sequencer
  0: [0- 0]: ctl
 17: [0- 1]: digital audio playback
 16: [0- 0]: digital audio playback
 24: [0- 0]: digital audio capture
 33:       : timer

>aplay -D hw:0,1 <whatever>.wav returns:
Playing WAVE 'audiodump.wav' : Signed 16 bit Little Endian, Rate 44100 Hz,
Stereo
Warning: rate is not accurate (requested = 44100Hz, got = 48000Hz) please,
try the plug plugin (-Dplug:hw:0,1)

Analog output is working correctly.

More info and logs on request.
======================================================================

----------------------------------------------------------------------
 jdthood - 09-14-05 16:18 
----------------------------------------------------------------------
Submitter: You were asked to provide additional information.

----------------------------------------------------------------------
 pkashou - 09-16-05 01:16 
----------------------------------------------------------------------
No, I was never able to get it working nor have I read anywhere that anyone
has it working.

Sorry I couldn't provide more details.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-27-04 03:54 pkashou        New Issue                                    
04-27-04 03:54 pkashou        Distribution              => Gentoo          
04-27-04 03:54 pkashou        Kernel Version            => gentoo-dev-sources
2.6.5 (running cvs alsa in kernel)
04-27-04 12:29 tiwai          Note Added: 0000960                          
04-27-04 13:41 pkashou        Note Added: 0000961                          
04-28-04 02:31 pkashou        File Added: asound.state                     
04-28-04 02:32 pkashou        Note Added: 0000968                          
04-30-04 11:34 tiwai          Note Added: 0000979                          
05-01-04 00:56 pkashou        Note Added: 0000985                          
05-01-04 00:56 pkashou        Note Edited: 0000985                         
05-01-04 01:00 pkashou        Note Edited: 0000985                         
05-01-04 01:02 pkashou        Note Edited: 0000985                         
05-01-04 10:33 tiwai          Note Added: 0000993                          
05-01-04 21:17 pkashou        Note Added: 0001001                          
05-24-04 15:02 pkashou        Note Added: 0001185                          
06-12-04 16:41 pkashou        Note Added: 0001301                          
06-30-04 16:32 tiwai          Note Added: 0001356                          
08-27-04 13:50 pkashou        Note Added: 0001642                          
08-27-04 19:34 tiwai          Note Added: 0001645                          
12-28-04 18:59 sw25481        Note Added: 0002986                          
01-03-05 18:08 sw25481        Note Edited: 0002986                         
01-03-05 18:09 sw25481        Issue Monitored: sw25481                     
01-03-05 18:12 sw25481        Note Added: 0003072                          
09-14-05 16:18 jdthood        Note Added: 0006179                          
09-14-05 16:18 jdthood        Status                   assigned => feedback
09-16-05 01:16 pkashou        Note Added: 0006235                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
