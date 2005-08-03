From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001305]: some odd conditions cause gnomemeeting to crash on takeoff - they blame libasound
Date: Wed, 3 Aug 2005 08:58:57 +0200
Message-ID: <32e7bca8ec224db49097923e919fed8b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D318114E
	for <alsa-devel@alsa-project.org>; Wed,  3 Aug 2005 08:58:57 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1305> 
======================================================================
Reported By:                zsd
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   1305
Category:                   1_pcm - digital audio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             08-03-2005 03:42 CEST
Last Modified:              08-03-2005 08:58 CEST
======================================================================
Summary:                    some odd conditions cause gnomemeeting to crash on
takeoff - they blame libasound
Description: 
Here is what I reported to the gnomemeeting people:

Steps to reproduce the crash:
1. start it

Expected Results:
It should run

How often does this happen?
Every time

Admittedly, this was vague, and I finally tracked it down (see "Steps to
reproduce" below).

But first, here was the gnomemeeting traceback:

Backtrace was generated from '/usr/bin/gnomemeeting'

(no debugging symbols found)...Using host libthread_db library
"/lib/libthread_db.so.1".
(no debugging symbols found)...(no debugging symbols found)...(no
debugging symbols found)...(no debugging symbols found)...(no debugging
symbols found)...(no debugging symbols found)...(no debugging symbols
found)...(no debugging symbols found)...(no debugging symbols
found)...(no debugging symbols found)...(no debugging symbols
found)...(no debugging symbols found)...(no debugging symbols
found)...(no debugging symbols found)...(no debugging symbols
found)...(no debugging symbols found)...(no debugging symbols
found)...(no debugging symbols found)...(no debugging symbols
found)...(no debugging symbols found)...(no debugging symbols
found)...(no debugging symbols found)...(no debugging symbols
found)...(no debugging symbols found)...(no debugging symbols
found)...(no debugging symbols found)...(no debugging symbols
found)...(no debugging symbols found)...(no debugging symbols
found)...(no debugging symbols found)...[Thread debugging using
libthread_db enabled]
[New Thread 16384 (LWP 16377)]
0x41498497 in waitpid () from /lib/libpthread.so.0
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=0  0x41498497 in waitpid
() from /lib/libpthread.so.0
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1  0x400985c4 in
libgnomeui_module_info_get () from
/usr/lib/libgnomeui-2.so.0
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2  0x41496be5 in
__pthread_sighandler () from /lib/libpthread.so.0
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3  <signal handler
called>
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=4  0x4183beda in
snd_ctl_close () from /usr/lib/libasound.so.2
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=5  0x41bf9155 in
PSoundChannelALSA::UpdateDictionary ()
   from /usr/lib/pwlib/devices/sound/alsa_pwplugin.so
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=6  0x41bf919a in
PSoundChannelALSA::GetDeviceNames ()
   from /usr/lib/pwlib/devices/sound/alsa_pwplugin.so
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=7  0x41bf88a5 in
PSoundChannelALSA_GetDeviceNames ()
   from /usr/lib/pwlib/devices/sound/alsa_pwplugin.so
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=8  0x41340fea in
PSoundChannel::GetDeviceNames ()
   from /usr/lib/libpt_linux_x86_r.so.1.8.3
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=9  0x413411a9 in
PSoundChannel::GetDeviceNames ()
   from /usr/lib/libpt_linux_x86_r.so.1.8.3
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=10 0x41341229 in
PSoundChannel::GetDefaultDevice ()
   from /usr/lib/libpt_linux_x86_r.so.1.8.3
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=11 0x40fe98fe in
H323EndPoint::H323EndPoint ()
   from /usr/lib/libh323_linux_x86_r.so.1.15.2
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=12 0x0807c832 in
GMH323EndPoint::GMH323EndPoint ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=13 0x08079852 in
GnomeMeeting::GnomeMeeting ()
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=14 0x080941b2 in main ()

Thread 1 (Thread 16384 (LWP 16377)):
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=0  0x41498497 in waitpid
() from /lib/libpthread.so.0
No symbol table info available.
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1  0x400985c4 in
libgnomeui_module_info_get () from
/usr/lib/libgnomeui-2.so.0
No symbol table info available.
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2  0x41496be5 in
__pthread_sighandler () from /lib/libpthread.so.0
No symbol table info available.
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3  <signal handler
called>
No symbol table info available.
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=4  0x4183beda in
snd_ctl_close () from /usr/lib/libasound.so.2
No symbol table info available.
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=5  0x41bf9155 in
PSoundChannelALSA::UpdateDictionary ()
   from /usr/lib/pwlib/devices/sound/alsa_pwplugin.so
No symbol table info available.
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=6  0x41bf919a in
PSoundChannelALSA::GetDeviceNames ()
   from /usr/lib/pwlib/devices/sound/alsa_pwplugin.so
No symbol table info available.
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=7  0x41bf88a5 in
PSoundChannelALSA_GetDeviceNames ()
   from /usr/lib/pwlib/devices/sound/alsa_pwplugin.so
No symbol table info available.
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=8  0x41340fea in
PSoundChannel::GetDeviceNames ()
   from /usr/lib/libpt_linux_x86_r.so.1.8.3
No symbol table info available.
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=9  0x413411a9 in
PSoundChannel::GetDeviceNames ()
   from /usr/lib/libpt_linux_x86_r.so.1.8.3
No symbol table info available.
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=10 0x41341229 in
PSoundChannel::GetDefaultDevice ()
   from /usr/lib/libpt_linux_x86_r.so.1.8.3
No symbol table info available.
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=11 0x40fe98fe in
H323EndPoint::H323EndPoint ()
   from /usr/lib/libh323_linux_x86_r.so.1.15.2
No symbol table info available.
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=12 0x0807c832 in
GMH323EndPoint::GMH323EndPoint ()
No symbol table info available.
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=13 0x08079852 in
GnomeMeeting::GnomeMeeting ()
No symbol table info available.
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=14 0x080941b2 in main ()
No symbol table info available.
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=0  0x41498497 in waitpid
() from /lib/libpthread.so.0



======================================================================

----------------------------------------------------------------------
 zsd - 08-03-05 04:01 
----------------------------------------------------------------------
The following didn't get into the bug report above... here is info on how
to reproduce the bug:

I have discovered a set of conditions which cause this bug to manifest
itself.

First, after submitting the bug report I discovered that gnomemeeting was
working if I used a USB webcam that used the ov511 module and DID NOT have
a
built-in mic.  I usually use a Logitech webcam (which uses pwc+pwcx
modules
under 2.4.xx) but which also has a built in mic (which uses the
snd-usb-audio).

Next I discovered that when I created a new user on my computer which was
NOT in
the "audio" group, gnomemeeting did not crash and burn on takeoff when
using the
Logitech web cam.  However, the config druid did not register the USB mic
as an
option.

After a lot of searching, I discovered that /dev/snd/pcmC1D0c was missing
(presumably clobbered by udev in a 2.6.1x kernel I use some times) and
that
restoring this file brought the world back to its previous blissful
state.

It is interesting that being in the audio group is a significant
difference
here, because even with the audio devices (/dev/snd/*, /dev/dsp*,
/dev/mixer*,
...) chmod'ed to 666, the user w/o "audio" could run gnomemeeting, while
the
user with "audio" could not.

Obviously, the missing file is a local config problem that was my fault (I
could
gripe about udev, but that's another story), however, 
(a) the connection with me being in the audio group is mysterious, and
(b) a more gracefull error message (or actually working regardless) would
be nicer.

----------------------------------------------------------------------
 schorpp - 08-03-05 08:58 
----------------------------------------------------------------------
i know this backtrace from debian-pre-sarge times a few months ago and also
had some problems with alsa 1.0.8.

use gm >= 1.2.1 and alsa >= 1.0.9 and update your system libs.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-03-05 03:42 zsd            New Issue                                    
08-03-05 04:01 zsd            Note Added: 0005611                          
08-03-05 08:58 schorpp        Note Added: 0005612                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
