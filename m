From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002023]: midi/joystick port disabled and no way to enable it
Date: Thu, 25 May 2006 21:53:35 +0200
Message-ID: <930df720d15f8138721ca3d8b64d0b9c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 8894617B
	for <alsa-devel@alsa-project.org>; Thu, 25 May 2006 21:53:35 +0200 (MEST)
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
Last Modified:              05-25-2006 21:53 CEST
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
 zanonmark - 05-25-06 19:31 
----------------------------------------------------------------------
Some additional considerations:

My MIDI cable was built this way:
(a) a 15-pins port on the pc side;
(b) (i) another 15-pins port and (ii) 2 5-pins ports on the keyboard
side.

1) As I told before, connecting pins 15 and 12 of the card gameport (a)
actually worked! It seems that the driver was ok. My apologies to the
whole ALSA team for the waste of time.

2) Instead, connecting pins 15 and 12 of (b-i) and typing the same "amidi"
commands returns in random characters displayed in the console. Shouldn't
I see the same results as in point 1)? Does it mean that I have some cable
problems?

Thanks,

MZ

----------------------------------------------------------------------
 gineera - 05-25-06 21:53 
----------------------------------------------------------------------
As I understand it, the midi connections are unlikely to be brought out on
the gameport of your connector cable (your b(i)).  Refer to midi org web
site, the 5-pin DIN midi connectors should have opto-isolators built in to
the cable connectors driving as a 'current loop', which makes it
unsuitable for splitting.

Does the keyboard have midi-thro'? If so connect midi out DIN plug to
keyboard midi in, and midi in plug to midi thro -then the signal should
loop back.  Try it both ways round as some cables have the plugs labelled
for which they should connect to, rather than which they come from.

Hope this might help.

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
05-25-06 18:33 zanonmark      Note Added: 0009962                          
05-25-06 19:31 zanonmark      Note Added: 0009963                          
05-25-06 21:53 gineera        Note Added: 0009964                          
======================================================================




-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
