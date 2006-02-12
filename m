From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001420]: Dell's modified SoundBlaster Live! 5.1 OEM card does not work with emu10k1x driver on Fedora Core 3 and 4
Date: Sun, 12 Feb 2006 17:11:16 +0100
Message-ID: <0cd519b2e3177eed4701b56af1bbd110@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B7D82143
	for <alsa-devel@alsa-project.org>; Sun, 12 Feb 2006 17:11:16 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1420> 
======================================================================
Reported By:                inkbrush
Assigned To:                fmoraes
======================================================================
Project:                    ALSA - driver
Issue ID:                   1420
Category:                   PCI - emu10k1x
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             2.6.11-1.1369_FC4
======================================================================
Date Submitted:             09-14-2005 18:47 CEST
Last Modified:              02-12-2006 17:11 CET
======================================================================
Summary:                    Dell's modified SoundBlaster Live! 5.1 OEM card does
not work with emu10k1x driver on Fedora Core 3 and 4
Description: 
I initially installed Fedora Core 3 on my Dell Pentium machine that came
with factory installed SoundBlaster Live! 5.1, which is a modified version
of Creative's actual SB card. The sound would not work at all. Gnome's
soundcard detection would list the model of the card as emu10k1x while
listing the module as emu10k1. Clicking "play test sound" did not produce
any sound. When opening the volume control, I would get the error message
that the device does not exist. (Sorry, I do not remember the exact
message) 

Following alsa web site's instructions for installing emu10k1x did not
resolve the problem either. I kept getting some error messages along the
way-one of which was dev/midi does not exist. No sound came out and The
module was still listed as emu10k1. 

I tried another solution, which gave me only s half success. I reinstalled
FC3 fresh and ran update rather than following alsa's instructions. Doing
this corrected the soundcard detection, so that it listed the module as
emu10k1x. The volume control and alsamixer also worked following the
reinstall. Clicking the test sound button produced beautiful sound.
However, no actual playback sound was coming out when I tried opening a
wave file and loading an audio CD. I made sure to unmute thevolume
control, but still no sound.

I installed FC4, but it gives me the same results as the above paragraph.
Again, I made sure to unmute the sound with volume control and alsamixer.

It seems that other people are reporting similar problems
www.fedoraforum.org and other web sites. This particular model of
soundcard and the model of the PC it came in is relatively old -about two
years for mine- but it's still a pretty common soundcard. I would
appreciate a great deal if somebody could resolve this problem.

I am a total Linux newbie with little experience in computers, but if
there's anything I can do, such as send in pieces of the relevant system
code, I would gladly do it. Thank you.
======================================================================

----------------------------------------------------------------------
 fmoraes - 02-12-06 17:11 
----------------------------------------------------------------------
As I remember, the hardware database of FC3/4 had the driver listed wrong.
Can you do an lsmod as root and make sure that the snd-emu10k1x driver is
loaded correctly?

If not, then the HAL database is the culprit and you need to modify it to
correct the error in it. The file is located in
/usr/share/hwdata/pcitable. Look for the line:

0x1102	0x0006	"snd-emu10k1x"

If it says snd-emu10k1, then it is incorrect and it is a Fedora bug.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-14-05 18:47 inkbrush       New Issue                                    
09-14-05 18:47 inkbrush       Kernel Version            => 2.6.11-1.1369_FC4
02-12-06 17:11 fmoraes        Note Added: 0008029                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
