From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000614]: 2 x snd-usb-audio causes one or both USB dev to go mute after a day or two with heavy use
Date: Fri, 29 Oct 2004 09:19:27 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <baae34973703dbe6a00f408898fc8e94@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 473EC24F
	for <alsa-devel@alsa-project.org>; Fri, 29 Oct 2004 09:19:28 +0200 (MEST)
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
Status:                     assigned
Distribution:               Fedora Core 1
Kernel Version:             2.4
======================================================================
Date Submitted:             10-29-2004 07:41 CEST
Last Modified:              10-29-2004 09:19 CEST
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
 Clemens Ladisch - 10-29-04 09:19 
----------------------------------------------------------------------
I guess "no audio" means that there is data, but it's silence?

If reloading the driver doesn't help but replugging the device does, it
looks like a bug in the device.

It is possible that reloading not only the sound driver but the USB
modules too (hcd*, *hci*, usbcore) might help, because this can cause a
USB reset.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-29-04 07:41 cyrus7580      New Issue                                    
10-29-04 07:41 cyrus7580      Distribution              => Fedora Core 1   
10-29-04 07:41 cyrus7580      Kernel Version            => 2.4             
10-29-04 09:19 Clemens LadischNote Added: 0002288                          
======================================================================




-------------------------------------------------------
This Newsletter Sponsored by: Macrovision 
For reliable Linux application installations, use the industry's leading
setup authoring tool, InstallShield X. Learn more and evaluate 
today. http://clk.atdmt.com/MSI/go/ins0030000001msi/direct/01/
