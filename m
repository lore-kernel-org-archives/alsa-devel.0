From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002023]: midi/joystick port disabled and no way to enable it
Date: Mon, 1 May 2006 10:38:42 +0200
Message-ID: <63bd3f83bebb4ded831fdbd7c15f1c09@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id BAED7150
	for <alsa-devel@alsa-project.org>; Mon,  1 May 2006 10:38:42 +0200 (MEST)
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
Last Modified:              05-01-2006 10:38 CEST
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
 zanonmark - 04-26-06 19:51 
----------------------------------------------------------------------
my mobo is an Asrock k7vt4a-pro, which has a mpu401 uart onboard (but I
can't use it because I miss a midi/joystick cable going from the onboard
controller to the back of the case), and I also have this snd-ens1371
compatible pci card which should work with midi as well... :)

thanks,

MZ

----------------------------------------------------------------------
 Raymond - 05-01-06 10:38 
----------------------------------------------------------------------
amidi -d

cat /proc/asound/card0/midi0

check Rx bytes 


http://sourceforge.net/mailarchive/forum.php?thread_id=5053665&forum_id=1751

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
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
