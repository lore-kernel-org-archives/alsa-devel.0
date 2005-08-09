From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001310]: Driver cant find firmware for Layla24
Date: Tue, 9 Aug 2005 11:42:11 +0200
Message-ID: <81a1ea6344658cb3cefd002e2d315d62@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id CB3DC1A4
	for <alsa-devel@alsa-project.org>; Tue,  9 Aug 2005 11:42:11 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1310> 
======================================================================
Reported By:                oxi
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1310
Category:                   PCI - echoaudio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Debian Sarge AMD64
Kernel Version:             2.6.12.3
======================================================================
Date Submitted:             08-04-2005 22:50 CEST
Last Modified:              08-09-2005 11:42 CEST
======================================================================
Summary:                    Driver cant find firmware for Layla24
Description: 
Hello,

After modprobe snd-layla24 ,
in dmesg|tail:

ACPI: PCI Interrupt 0000:00:0e.0[A] -> GSI 19 (level, low) -> IRQ 19
ALSA /usr/src/alsa-driver-1.0.9b/pci/echoaudio/echoaudio.c:41:
get_firmware(): Firmware not available (-2)
Echoaudio Layla24: probe of 0000:00:0e.0 failed with error -2

Same issue that another guy is experiencing with a Layla20:
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1244
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0001244 error with firmware with echo layla20
======================================================================

----------------------------------------------------------------------
 oxi - 08-08-05 23:07 
----------------------------------------------------------------------
Ok, I installed the echomixer, btw I must say its far much better than the
one for win, since you can redirect any i/os as you please with the amount
of dB you desire :))) I've read about that before... i think the mixing is
done in the card itself. Thats great.

The leftmost 8 signals in the VU meter are trembling, with their peaks
around -96dB, but i still cant make any audio program sound.

Alsaconf still doesnt recognise it.

Willing to hear from you, thanks.

----------------------------------------------------------------------
 pochini - 08-09-05 11:42 
----------------------------------------------------------------------
I can only hope that distros will ship with working hotplug scripts :)
With DSL apps you have to set an env variable, eg.:

export AUDIODEV=plughw:0,0,2

and they must be compiled with ALSA support. You can use the monitor mixer
on windos too, but echomixer has a much simpler interface. The moving
VU-meters is the background noise of the analog input channels. Did you
try aplay ? Did you remember to set the volume :) ?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-04-05 22:50 oxi            New Issue                                    
08-04-05 22:50 oxi            Distribution              => Debian Sarge AMD64
08-04-05 22:50 oxi            Kernel Version            => 2.6.12.3        
08-04-05 23:48 rlrevell       Note Added: 0005653                          
08-05-05 04:57 oxi            Note Added: 0005656                          
08-05-05 04:59 oxi            Issue Monitored: oxi                         
08-05-05 05:00 rlrevell       Note Added: 0005657                          
08-05-05 05:20 oxi            Note Added: 0005658                          
08-05-05 05:25 oxi            Note Added: 0005659                          
08-05-05 06:03 rlrevell       Note Added: 0005660                          
08-05-05 08:48 perex          Relationship added       related to 0001244  
08-05-05 13:26 oxi            Note Added: 0005666                          
08-05-05 15:09 hennewou       Note Added: 0005668                          
08-05-05 19:43 oxi            Note Added: 0005671                          
08-05-05 19:46 oxi            Note Edited: 0005671                         
08-05-05 20:36 rlrevell       Note Added: 0005675                          
08-05-05 23:10 hennewou       Note Added: 0005677                          
08-07-05 09:46 pochini        Note Added: 0005688                          
08-07-05 18:27 oxi            Note Added: 0005695                          
08-07-05 18:31 oxi            Note Added: 0005696                          
08-08-05 00:06 pochini        Note Added: 0005698                          
08-08-05 04:12 oxi            File Added: firmware.agent                    
08-08-05 04:32 oxi            Note Added: 0005700                          
08-08-05 09:22 pochini        Note Added: 0005703                          
08-08-05 21:40 oxi            Note Added: 0005712                          
08-08-05 22:23 oxi            Note Added: 0005713                          
08-08-05 23:07 oxi            Note Added: 0005715                          
08-09-05 11:42 pochini        Note Added: 0005720                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
