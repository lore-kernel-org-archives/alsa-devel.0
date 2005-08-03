From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001305]: some odd conditions cause gnomemeeting to crash on takeoff - they blame libasound
Date: Wed, 3 Aug 2005 03:42:53 +0200
Message-ID: <4fce04ed7bbeeef4c6f2e3826e092a0e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5DFC8146
	for <alsa-devel@alsa-project.org>; Wed,  3 Aug 2005 03:42:53 +0200 (MEST)
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


The following issue has been SUBMITTED.
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
Last Modified:              08-03-2005 03:42 CEST
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

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-03-05 03:42 zsd            New Issue                                    
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
