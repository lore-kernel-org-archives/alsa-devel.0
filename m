From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002023]: midi/joystick port disabled and no way to enable it
Date: Fri, 12 May 2006 03:58:53 +0200
Message-ID: <3049ebc2e11a92b1c91b9421da665eef@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B11B018F
	for <alsa-devel@alsa-project.org>; Fri, 12 May 2006 03:58:53 +0200 (MEST)
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
Last Modified:              05-12-2006 03:58 CEST
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
 zanonmark - 05-07-06 13:33 
----------------------------------------------------------------------
entering:
 amidi -d
 cat /proc/asound/card0/midi0
and playing returns nothing;

entering:
 cat /proc/asound/card0/midi0
returns:

root@ubuntu:/home/marco# cat /proc/asound/card0/midi0
ES1371

Output 0
  Tx bytes     : 0
Input 0
  Rx bytes     : 0
  Buffer size  : 4096
  Avail        : 0
  Overruns     : 0

even if I keep on playing and re-entering that command...

Thanks,

MZ

----------------------------------------------------------------------
 Raymond - 05-12-06 03:58 
----------------------------------------------------------------------
If you are not intend to use the onboard midi, you may need to disable it
in BIOS setup

BTW, what is the model of your ens1371 ?  lspci -vvn

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
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
