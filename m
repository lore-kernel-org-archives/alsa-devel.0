From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002023]: midi/joystick port disabled and no way to enable it
Date: Mon, 17 Apr 2006 07:19:07 +0200
Message-ID: <6a4c6f25c2496cc8685d36a46eb1a318@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B5AEB1A8
	for <alsa-devel@alsa-project.org>; Mon, 17 Apr 2006 07:19:07 +0200 (MEST)
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
Last Modified:              04-17-2006 07:19 CEST
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
 rlrevell - 04-17-06 06:56 
----------------------------------------------------------------------
Is snd-mpu401 loaded?

----------------------------------------------------------------------
 Raymond - 04-17-06 07:19 
----------------------------------------------------------------------
joystick_port=1  auto-scan or assign io port address :- 0x200, .....


config SND_ENS1371
	tristate "(Creative) Ensoniq AudioPCI 1371/1373"
	depends on SND
	select SND_RAWMIDI
	select SND_AC97_CODEC
	help
	  Say Y here to include support for Ensoniq AudioPCI ES1371 chips and
	  Sound Blaster PCI 64 or 128 soundcards.

	  To compile this driver as a module, choose M here: the module
	  will be called snd-ens1371.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-16-06 12:18 zanonmark      New Issue                                    
04-16-06 12:18 zanonmark      Distribution              => Ubuntu 5.10     
04-16-06 12:18 zanonmark      Kernel Version            => 2.6.12-10       
04-17-06 06:56 rlrevell       Note Added: 0009301                          
04-17-06 07:19 Raymond        Note Added: 0009303                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
