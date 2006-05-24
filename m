From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002023]: midi/joystick port disabled and no way to enable it
Date: Wed, 24 May 2006 14:32:50 +0200
Message-ID: <59ea7037fbe972d9dfe9e240c9d6f3bf@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id CFB97175
	for <alsa-devel@alsa-project.org>; Wed, 24 May 2006 14:32:50 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2023> 
======================================================================
Reported By:                zanonmark
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2023
Category:                   PCI - ens1371
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Ubuntu 5.10
Kernel Version:             2.6.12-10
======================================================================
Date Submitted:             04-16-2006 12:18 CEST
Last Modified:              05-24-2006 14:32 CEST
======================================================================
Summary:                    midi/joystick port disabled and no way to enable it
Description: 
I have a MIDI keyboard and I'd like to connect it to the midi/joystick port
of the soundcard.

Unfortunately, while PCM works fine and /dev/midi is created, I see no
MIDI communication through /dev/midi.
/proc/asound/AudioPCI/audiopci reports that the joystick port is
disabled.

It is probably a bug on the Ubuntu side (did they forget to compile the
driver correctly?), but I'd like to see a parameter for enabling the
joystick port "on the fly": other drivers have one (e.g.: "joystick=1"),
but snd_ens1371 has not, so:
1) it is not possible to reload (rmmod and modprobe) the driver with that
parameter enabling the midi/joystick port manually,
2) it is not possible to save (alsactl store), modify and reload (alsactl
restore) the soundcard settings, because I see no such parameter to
modify.

So, will you please include such a parameter in the next version of the
driver?

Thanks a lot,

Marco.

======================================================================

----------------------------------------------------------------------
 zanonmark - 05-23-06 20:02 
----------------------------------------------------------------------
Excuse me, I didn't understand: how can I connect the sound card's output
with its input? the 15-pins jack would "use" the whole port,

also, I don't know whether this makes sense, but i tried:
 amidi -d -p hw:0
on one console, and:
 amidi -p hw:0 -S "F0 43 10 4C 00 00 7E 00 F7"
on another console, and I could not see anything in the first one:
shouldn't I see the dump of those characters?

Thanks for your patience :)

MZ

----------------------------------------------------------------------
 Clemens Ladisch - 05-24-06 14:32 
----------------------------------------------------------------------
With "output" and "input", I meant the MIDI jacks of your gameport-MIDI
adapter.
If it has built in cables, you cannot connect one to the other.

In this case, you can just connect pins 12 and 15 of the gameport with a
wire (view with a monospaced font):
  8             1
-------------------
\ o o o o o o o o /
 \ o o o o o o o /
  -+-----+-------
 15|     |     9
   \_____/


Your amidi commands should work _if_ the output is connected to the input.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-16-06 12:18 zanonmark      New Issue                                    
04-16-06 12:18 zanonmark      Distribution              => Ubuntu 5.10     
04-16-06 12:18 zanonmark      Kernel Version            => 2.6.12-10       
04-17-06 06:56 rlrevell       Note Added: 0009301                          
04-17-06 07:19 Raymond        Note Added: 0009303                          
04-17-06 19:59 zanonmark      Note Added: 0009319                          
04-18-06 10:54 Raymond        Note Added: 0009328                          
04-18-06 13:18 Raymond        Note Edited: 0009328                         
04-18-06 16:28 Clemens LadischNote Added: 0009338                          
04-19-06 20:05 zanonmark      Note Added: 0009354                          
04-19-06 21:49 rlrevell       Note Added: 0009356                          
04-20-06 03:39 Raymond        Note Added: 0009363                          
04-22-06 13:36 zanonmark      Note Added: 0009433                          
04-24-06 15:47 Raymond        Note Added: 0009452                          
04-24-06 15:57 zanonmark      Note Added: 0009460                          
04-25-06 03:25 Raymond        Note Added: 0009484                          
04-25-06 10:55 zanonmark      Note Added: 0009486                          
04-26-06 10:54 Raymond        Note Added: 0009505                          
04-26-06 19:51 zanonmark      Note Added: 0009522                          
05-01-06 10:38 Raymond        Note Added: 0009553                          
05-07-06 13:33 zanonmark      Note Added: 0009641                          
05-12-06 03:58 Raymond        Note Added: 0009771                          
05-12-06 19:44 zanonmark      Note Added: 0009788                          
05-13-06 05:19 Raymond        Note Added: 0009794                          
05-19-06 03:44 Raymond        Note Added: 0009872                          
05-20-06 11:30 zanonmark      Note Added: 0009883                          
05-21-06 04:49 Raymond        Note Added: 0009896                          
05-23-06 11:26 zanonmark      Note Added: 0009930                          
05-23-06 19:09 Clemens LadischNote Added: 0009946                          
05-23-06 20:02 zanonmark      Note Added: 0009950                          
05-24-06 14:32 Clemens LadischNote Added: 0009956                          
======================================================================




-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
