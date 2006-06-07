From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002192]: Very annoying acute sound
	recorded from line-in with M5455 chip
Date: Wed, 7 Jun 2006 22:30:50 +0200
Message-ID: <6eaa7caef2a9a7ab6ce55ee39691024a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 2B137160
	for <alsa-devel@alsa-project.org>;
	Wed,  7 Jun 2006 22:30:51 +0200 (MEST)
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


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2192> 
======================================================================
Reported By:                ccasteyde
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2192
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Slackware 10.1
Kernel Version:             2.6.17-rc6
======================================================================
Date Submitted:             06-07-2006 20:42 CEST
Last Modified:              06-07-2006 22:30 CEST
======================================================================
Summary:                    Very annoying acute sound recorded from line-in with
M5455 chip
Description: 
I'm using an ULi integrated sound chip, which reports as a M5455 device,
and which works very nice with the intel8x0 driver for playback, but
recording sound from line-in input gives corrupted sound with a very acute
background sound, except when source gives silence.
I have another motherboard (very older, and still with intel8x0 compatible
chip), and it gives the same result.
======================================================================

----------------------------------------------------------------------
 ccasteyde - 06-07-06 22:03 
----------------------------------------------------------------------
This was really very simple:
record -d /dev/dsp1

(I have another sound card, I presently use to record my sounds, and I
loaded the module to make intel8x0 as the second card). Then I pressed
space bar to start recording, space bar to stop. man page tells it
defaults to 44100Hz, and the second test I did was :
record -r 48000 -d /dev/dsp1

with -r option to tell it to record at 48kHz. This was successfull.

I don't think this is an application bug in any case. I have the same
problem with mencoder (mplayer), when recording TV signal:
mencoder -tv
driver=v4l2:device=/dev/video0:input=1:norm=$NORM:width=368:height=270:fp
s=25:adevice=/dev/dsp1 -ovc lavc -oac lavc -lavcopts
vcodec=mpeg4:vhq:vbitrate=1800:acodec=mp2 tv:// -o file.avi

this records a film with a very bad sound (same problem). However, if I
specify explicitly tells mencoder to record at 48kHz, everything works:

mencoder -tv
driver=v4l2:device=/dev/video0:input=1:norm=$NORM:width=368:height=270:fp
s=25:adevice=/dev/dsp1:audiorate=48000:amode=1 -ovc lavc -oac lavc
-lavcopts vcodec=mpeg4:vhq:vbitrate=1800:acodec=mp2 tv:// -o file.avi

Please note the audiorate option (I also added amode to be sure to record
in stereo, not wishing to leave default options anymore).

So the problem is more generic than a simple recording application.

----------------------------------------------------------------------
 rlrevell - 06-07-06 22:30 
----------------------------------------------------------------------
Does the problem only occur when using the OSS emulation layer?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-07-06 20:42 ccasteyde      New Issue                                    
06-07-06 20:42 ccasteyde      File Added: record000.wav.mp3                    
06-07-06 20:42 ccasteyde      Distribution              => Slackware 10.1  
06-07-06 20:42 ccasteyde      Kernel Version            => 2.6.17-rc6      
06-07-06 21:16 ccasteyde      Note Added: 0010091                          
06-07-06 21:24 rlrevell       Note Added: 0010092                          
06-07-06 22:03 ccasteyde      Note Added: 0010093                          
06-07-06 22:30 rlrevell       Note Added: 0010095                          
======================================================================
