From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001903]: Recording of USB sound doesn't work
Date: Fri, 10 Mar 2006 20:56:26 +0100
Message-ID: <7f55aca37c4417e4a06f9ce9a8d63baf@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 6013D163
	for <alsa-devel@alsa-project.org>; Fri, 10 Mar 2006 20:56:26 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1903> 
======================================================================
Reported By:                nbaggus
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   1903
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     feedback
Distribution:               gentoo
Kernel Version:             2.6.15-gentoo-r1
======================================================================
Date Submitted:             03-10-2006 01:38 CET
Last Modified:              03-10-2006 20:56 CET
======================================================================
Summary:                    Recording of USB sound doesn't work
Description: 
arecord gives the next error message on:

$ arecord -D hw:2 -t wav -f S16_LE -d 10 file.wav
Recording WAVE 'file.wav' : Signed 16 bit Little Endian, Rate 8000 Hz,
Mono
arecord: pcm_read:1303: read error: Input/output error
$ 

after about 10 seconds. The recorded sound is a kind of metalic click in
silence. at playback the duration is between 1 and 2 seconds.
======================================================================

----------------------------------------------------------------------
 nbaggus - 03-10-06 20:13 
----------------------------------------------------------------------
Both the logitech and the Voip phone use the snd_usb_audio and friends.

The voipphone is a Usb-p1K phone from yealink (yealink.ko driver).
yealink.ko handles ringtone on/off; keypad & display, snd_usb_audio
handles sound.
The logitech is a logitech usb headphone set.
(Kensington equip. is a mouse).

connection is USB through EHCI or OHCI interface 
The system used is a promedion cybermaxx laptop. (One OHCI port, 3 EHCI
ports.)

There are no messages in dmesg or system log. accept for adding the
devices when plugging them in. 
Sound output does function sound input fails.



----------------------------------------------------------------------
 nbaggus - 03-10-06 20:56 
----------------------------------------------------------------------
Additional info...

The logitech headset does work on an intel Pentium 4/ 2.4 GHz DELL pc.
(Same os version, but alsa-driver 1.0.10)
On the AMD mobility XP though it doesn't work. All software is in i686
more compiled.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-10-06 01:38 nbaggus        New Issue                                    
03-10-06 01:38 nbaggus        Distribution              => gentoo          
03-10-06 01:38 nbaggus        Kernel Version            => 2.6.15-gentoo-r1
03-10-06 08:53 Clemens LadischNote Added: 0008401                          
03-10-06 08:53 Clemens LadischStatus                   assigned => feedback
03-10-06 13:47 nbaggus        Note Added: 0008402                          
03-10-06 20:13 nbaggus        Note Edited: 0008402                         
03-10-06 20:56 nbaggus        Note Added: 0008411                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
