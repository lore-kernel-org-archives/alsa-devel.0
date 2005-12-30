From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001305]: some odd conditions cause gnomemeeting to crash on takeoff - they blame libasound
Date: Fri, 30 Dec 2005 23:53:09 +0100
Message-ID: <a90bae4e38f0a5f0adafd6780a19dbfa@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5CB15168
	for <alsa-devel@alsa-project.org>; Fri, 30 Dec 2005 23:53:09 +0100 (MET)
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
Last Modified:              12-30-2005 23:53 CET
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
#0  0x41498497 in waitpid () from /lib/libpthread.so.0
#1  0x400985c4 in libgnomeui_module_info_get () from
/usr/lib/libgnomeui-2.so.0
#2  0x41496be5 in __pthread_sighandler () from /lib/libpthread.so.0
#3  <signal handler called>
#4  0x4183beda in snd_ctl_close () from /usr/lib/libasound.so.2
#5  0x41bf9155 in PSoundChannelALSA::UpdateDictionary ()
   from /usr/lib/pwlib/devices/sound/alsa_pwplugin.so
#6  0x41bf919a in PSoundChannelALSA::GetDeviceNames ()
   from /usr/lib/pwlib/devices/sound/alsa_pwplugin.so
#7  0x41bf88a5 in PSoundChannelALSA_GetDeviceNames ()
   from /usr/lib/pwlib/devices/sound/alsa_pwplugin.so
#8  0x41340fea in PSoundChannel::GetDeviceNames ()
   from /usr/lib/libpt_linux_x86_r.so.1.8.3
#9  0x413411a9 in PSoundChannel::GetDeviceNames ()
   from /usr/lib/libpt_linux_x86_r.so.1.8.3
#10 0x41341229 in PSoundChannel::GetDefaultDevice ()
   from /usr/lib/libpt_linux_x86_r.so.1.8.3
#11 0x40fe98fe in H323EndPoint::H323EndPoint ()
   from /usr/lib/libh323_linux_x86_r.so.1.15.2
#12 0x0807c832 in GMH323EndPoint::GMH323EndPoint ()
#13 0x08079852 in GnomeMeeting::GnomeMeeting ()
#14 0x080941b2 in main ()

Thread 1 (Thread 16384 (LWP 16377)):
#0  0x41498497 in waitpid () from /lib/libpthread.so.0
No symbol table info available.
#1  0x400985c4 in libgnomeui_module_info_get () from
/usr/lib/libgnomeui-2.so.0
No symbol table info available.
#2  0x41496be5 in __pthread_sighandler () from /lib/libpthread.so.0
No symbol table info available.
#3  <signal handler called>
No symbol table info available.
#4  0x4183beda in snd_ctl_close () from /usr/lib/libasound.so.2
No symbol table info available.
#5  0x41bf9155 in PSoundChannelALSA::UpdateDictionary ()
   from /usr/lib/pwlib/devices/sound/alsa_pwplugin.so
No symbol table info available.
#6  0x41bf919a in PSoundChannelALSA::GetDeviceNames ()
   from /usr/lib/pwlib/devices/sound/alsa_pwplugin.so
No symbol table info available.
#7  0x41bf88a5 in PSoundChannelALSA_GetDeviceNames ()
   from /usr/lib/pwlib/devices/sound/alsa_pwplugin.so
No symbol table info available.
#8  0x41340fea in PSoundChannel::GetDeviceNames ()
   from /usr/lib/libpt_linux_x86_r.so.1.8.3
No symbol table info available.
#9  0x413411a9 in PSoundChannel::GetDeviceNames ()
   from /usr/lib/libpt_linux_x86_r.so.1.8.3
No symbol table info available.
#10 0x41341229 in PSoundChannel::GetDefaultDevice ()
   from /usr/lib/libpt_linux_x86_r.so.1.8.3
No symbol table info available.
#11 0x40fe98fe in H323EndPoint::H323EndPoint ()
   from /usr/lib/libh323_linux_x86_r.so.1.15.2
No symbol table info available.
#12 0x0807c832 in GMH323EndPoint::GMH323EndPoint ()
No symbol table info available.
#13 0x08079852 in GnomeMeeting::GnomeMeeting ()
No symbol table info available.
#14 0x080941b2 in main ()
No symbol table info available.
#0  0x41498497 in waitpid () from /lib/libpthread.so.0



======================================================================

----------------------------------------------------------------------
 schorpp - 08-03-05 08:58 
----------------------------------------------------------------------
i know this backtrace from debian-pre-sarge times a few months ago and also
had some problems with alsa 1.0.8.

use gm >= 1.2.1 and alsa >= 1.0.9 and update your system libs.

----------------------------------------------------------------------
 rlrevell - 12-30-05 23:53 
----------------------------------------------------------------------
Is this fixed in later releases?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-03-05 03:42 zsd            New Issue                                    
08-03-05 04:01 zsd            Note Added: 0005611                          
08-03-05 08:58 schorpp        Note Added: 0005612                          
12-30-05 23:53 rlrevell       Note Added: 0007302                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
