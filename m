From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002076]: arecord gives silence
Date: Mon, 8 May 2006 12:14:27 +0200
Message-ID: <fb079c807d9335e357ed888359ca8367@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 8D7AD196
	for <alsa-devel@alsa-project.org>; Mon,  8 May 2006 12:14:27 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2076> 
======================================================================
Reported By:                jaime
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2076
Category:                   PCI - cs46xx
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             04-26-2006 16:28 CEST
Last Modified:              05-08-2006 12:14 CEST
======================================================================
Summary:                    arecord gives silence
Description: 
IBM Thinkpad T21 with Cirrus Logic CS 4614/22/24 [CrystalClear SoundFusion
Audio Accelerator] (rev 01).

alsamixer correctly mixes the inputs over to the line out (I can hear
microphone in and line in successfully mixed) but arecord gives silence.

I've tried using a usb soundcard on the same machine, and everything works
fine there, so I think this is only the snd-cs46xx driver.

I'm not sure what other info is useful - please let me know. Thank you.

======================================================================

----------------------------------------------------------------------
 jaime - 05-04-06 12:11 
----------------------------------------------------------------------
Takashi.

I've got it working by "toggling capture" (enabling recording) for the ADC
channel (in addition to making sure that recording is enabled on both the
Mic channel and the "Capture" channel).

Seeing how alsaconf sets up the volume sliders and unmutes certain
channels so that users can immediately get sound out of their machines,
would it also be a good idea to make alsaconf set capture enabled on the
ADC channel (and perhaps set the levels up a little) so that users can
also immediately use software that needs audio capture? (I do realize that
this can all be done using amixer or alsamixer, but I think one of the
points of alsaconf is to set levels and so make users' lives a little
easier).

I've also got another qustion: with
arecord -v -v -Dhw:0,0 -f cd test.wav
I get a volume meter which works and the wave file is good.

But when I use:
arecord -v -v -f cd test.wav
I just get:

Recording WAVE...
Plug PCM: Rate conversion PCM (48000, sformat=S16_LE)
Its setup is...
Slave: Direct Snoop PCM
Its setup is...
Hardware PCM Card 0 'Sound Fusion CS46xx' device 0 subdevice 0
Its setup is...

and then everything stops. There's no volume meter (like previously) and
the wav file is only 44 bytes long.

Would you prefer me to put this new problem into a new bug report?

Thank you.

----------------------------------------------------------------------
 atler - 05-08-06 12:14 
----------------------------------------------------------------------
It also seems to be the case in this bugreport:
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1822

Recording with 'arecord -v -v -Dhw:0,0 -f cd test.wav' works fine.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-26-06 16:28 jaime          New Issue                                    
05-02-06 18:11 tiwai          Note Added: 0009568                          
05-04-06 12:11 jaime          Note Added: 0009613                          
05-08-06 12:14 atler          Note Added: 0009645                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
