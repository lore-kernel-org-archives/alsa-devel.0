From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000614]: 2 x snd-usb-audio causes one or both USB dev to go mute after a day or two with heavy use
Date: Wed, 22 Mar 2006 03:11:55 +0100
Message-ID: <6e8e067334fda95669cc0246005cb2a6@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 8FBED100
	for <alsa-devel@alsa-project.org>; Wed, 22 Mar 2006 03:11:55 +0100 (MET)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=614> 
======================================================================
Reported By:                cyrus7580
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   614
Category:                   USB - usb-audio
Reproducibility:            sometimes
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               Fedora Core 1
Kernel Version:             2.4
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             10-29-2004 07:41 CEST
Last Modified:              03-22-2006 03:11 CET
======================================================================
Summary:                    2 x snd-usb-audio causes one or both USB dev to go
mute after a day or two with heavy use
Description: 
I use alsa on all my machines (15 plus) and don't usually have problems
with various combinations of snd-intel8x0, snd-ens1371, and snd-usb-audio.
However, on the one machine that I have with 2 x snd-usb-audio (as well as
1 x snd-intel8x0 and 1 x snd-ens1371), one of the USB devices will stop
recording audio after a day or two. The settings look ok in alsamixer, but
still no audio. I've tried rmmodding snd-usb-audio and reinserting, I've
tried rmmoding ALL sound stuff and reinserting, and I've tried muting and
unmuting... nothing works. The only thing that works is a total reboot,
which I have been doing almost daily. On my 3-5 machines with a single
usb-audio, they seem to work ok for long periods of time. Nothing like
this is happening. 

Point of clarification: they don't "stop" recording audio per se... That
is, there are no errors or crashes or dumps saying recording is not
possible. It's just that the audio files produced (semi-succesfully) have
no audio on them. 
======================================================================

----------------------------------------------------------------------
 jdthood - 09-14-05 15:55 
----------------------------------------------------------------------
> If reloading the driver doesn't help but replugging the device does, it
looks like a bug in the device.

So is the bug in the device or in ALSA?

----------------------------------------------------------------------
 rlrevell - 03-22-06 03:11 
----------------------------------------------------------------------
No response

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-29-04 07:41 cyrus7580      New Issue                                    
10-29-04 07:41 cyrus7580      Distribution              => Fedora Core 1   
10-29-04 07:41 cyrus7580      Kernel Version            => 2.4             
10-29-04 09:19 Clemens LadischNote Added: 0002288                          
09-14-05 15:55 jdthood        Note Added: 0006163                          
03-22-06 03:11 rlrevell       Status                   assigned => closed  
03-22-06 03:11 rlrevell       Note Added: 0008802                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
