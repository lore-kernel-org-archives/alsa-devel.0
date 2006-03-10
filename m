From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001905]: rhythmbox hangs in a dmix poll loop
Date: Fri, 10 Mar 2006 19:22:51 +0100
Message-ID: <a516c91d7510d2daa238e7126b047ebe@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 483C419A
	for <alsa-devel@alsa-project.org>; Fri, 10 Mar 2006 19:22:51 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1905> 
======================================================================
Reported By:                jdthood
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   1905
Category:                   0_general
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             03-10-2006 19:22 CET
Last Modified:              03-10-2006 19:22 CET
======================================================================
Summary:                    rhythmbox hangs in a dmix poll loop
Description: 
In Debian bug report 356049 the submitter writes the following:

Just hitting next a few times (via the tray icon) I managed to hang
rhythmbox
completely. It turns out that it is in asound2:
0x0e50336c in poll () from /lib/tls/libc.so.6
(gdb) bt
#0  0x0e50336c in poll () from /lib/tls/libc.so.6
#1  0x0df37264 in snd_pcm_direct_check_interleave () from
/usr/lib/libasound.so. 2
#2  0x0df37574 in snd_pcm_direct_server_create () from
/usr/lib/libasound.so.2
#3  0x0df2fdb4 in snd_pcm_dmix_open () from /usr/lib/libasound.so.2
#4  0x0df30394 in _snd_pcm_dmix_open () from /usr/lib/libasound.so.2
#5  0x0def1eac in snd_pcm_free () from /usr/lib/libasound.so.2
#6  0x0def2438 in snd_pcm_free () from /usr/lib/libasound.so.2
#7  0x0def277c in snd_pcm_open_slave () from /usr/lib/libasound.so.2
#8  0x0df18c08 in _snd_pcm_plug_open () from /usr/lib/libasound.so.2
#9  0x0def1eac in snd_pcm_free () from /usr/lib/libasound.so.2
#10 0x0def27c4 in snd_pcm_open_slave () from /usr/lib/libasound.so.2
#11 0x0df37830 in _snd_pcm_asym_open () from /usr/lib/libasound.so.2
#12 0x0def1eac in snd_pcm_free () from /usr/lib/libasound.so.2
#13 0x0def2438 in snd_pcm_free () from /usr/lib/libasound.so.2
#14 0x0dfaae80 in ?? () from /usr/lib/gstreamer-0.10/libgstalsa.so
#15 0x0e00641c in gst_audio_sink_get_type () from
/usr/lib/libgstaudio-0.10.so.0
#16 0x0e00bf94 in gst_ring_buffer_open_device () from
/usr/lib/libgstaudio-0.10. so.0
#17 0x0e009c88 in gst_base_audio_sink_create_ringbuffer () from
/usr/lib/libgsta udio-0.10.so.0
#18 0x0f68b5a8 in gst_element_continue_state () from
/usr/lib/libgstreamer-0.10. so.0
#19 0x0f68bd00 in gst_element_lost_state () from
/usr/lib/libgstreamer-0.10.so.0
#20 0x0f68a5e4 in gst_element_set_state () from
/usr/lib/libgstreamer-0.10.so.0
#21 0x0d174158 in gst_auto_audio_sink_get_type () from
/usr/lib/gstreamer-0.10/l ibgstautodetect.so
#22 0x0f68b5a8 in gst_element_continue_state () from
/usr/lib/libgstreamer-0.10. so.0
#23 0x0f68bd00 in gst_element_lost_state () from
/usr/lib/libgstreamer-0.10.so.0
#24 0x0f68a5e4 in gst_element_set_state () from
/usr/lib/libgstreamer-0.10.so.0
#25 0x0f6797bc in gst_bin_iterate_sorted () from
/usr/lib/libgstreamer-0.10.so.0
#26 0x0f68b5a8 in gst_element_continue_state () from
/usr/lib/libgstreamer-0.10. so.0
#27 0x0f68bd00 in gst_element_lost_state () from
/usr/lib/libgstreamer-0.10.so.0
#28 0x0f68a5e4 in gst_element_set_state () from
/usr/lib/libgstreamer-0.10.so.0
#29 0x0f6797bc in gst_bin_iterate_sorted () from
/usr/lib/libgstreamer-0.10.so.0
#30 0x0d7156d4 in gst_gconf_audio_sink_get_type () from
/usr/lib/gstreamer-0.10/ libgstgconfelements.so
#31 0x0f68b5a8 in gst_element_continue_state () from
/usr/lib/libgstreamer-0.10. so.0
#32 0x0f68bd00 in gst_element_lost_state () from
/usr/lib/libgstreamer-0.10.so.0
#33 0x0f68a5e4 in gst_element_set_state () from
/usr/lib/libgstreamer-0.10.so.0
#34 0x0f6797bc in gst_bin_iterate_sorted () from
/usr/lib/libgstreamer-0.10.so.0
#35 0x0f68b5a8 in gst_element_continue_state () from
/usr/lib/libgstreamer-0.10. so.0
#36 0x0f68bd00 in gst_element_lost_state () from
/usr/lib/libgstreamer-0.10.so.0
#37 0x0f68a5e4 in gst_element_set_state () from
/usr/lib/libgstreamer-0.10.so.0
#38 0x0d9afed4 in ?? () from /usr/lib/gstreamer-0.10/libgstplaybin.so
#39 0x0d9b0388 in ?? () from /usr/lib/gstreamer-0.10/libgstplaybin.so
#40 0x0d9b2e84 in gst_play_base_bin_get_type () from
/usr/lib/gstreamer-0.10/lib gstplaybin.so
#41 0x0e75df14 in g_cclosure_marshal_VOID__VOID () from
/usr/lib/libgobject-2.0. so.0
#42 0x0e74e2b0 in g_closure_invoke () from /usr/lib/libgobject-2.0.so.0
#43 0x0e7622e8 in g_signal_stop_emission () from
/usr/lib/libgobject-2.0.so.0
#44 0x0e763558 in g_signal_emit_valist () from
/usr/lib/libgobject-2.0.so.0
#45 0x0e76399c in g_signal_emit () from /usr/lib/libgobject-2.0.so.0
#46 0x0f6881e0 in gst_element_no_more_pads () from
/usr/lib/libgstreamer-0.10.so .0
#47 0x0da69a24 in ?? () from /usr/lib/gstreamer-0.10/libgstdecodebin.so
#48 0x0e75df14 in g_cclosure_marshal_VOID__VOID () from
/usr/lib/libgobject-2.0. so.0
#49 0x0e74e2b0 in g_closure_invoke () from /usr/lib/libgobject-2.0.so.0
#50 0x0e7622e8 in g_signal_stop_emission () from
/usr/lib/libgobject-2.0.so.0
#51 0x0e763558 in g_signal_emit_valist () from
/usr/lib/libgobject-2.0.so.0
#52 0x0e76399c in g_signal_emit () from /usr/lib/libgobject-2.0.so.0
#53 0x0f6881e0 in gst_element_no_more_pads () from
/usr/lib/libgstreamer-0.10.so .0
#54 0x0da34560 in ?? () from /usr/lib/gstreamer-0.10/libgstogg.so
#55 0x0da34b80 in ?? () from /usr/lib/gstreamer-0.10/libgstogg.so
#56 0x0da38588 in ?? () from /usr/lib/gstreamer-0.10/libgstogg.so
#57 0x0f6bcc64 in gst_task_get_type () from
/usr/lib/libgstreamer-0.10.so.0
#58 0x0e5fad3c in g_thread_pool_free () from /usr/lib/libglib-2.0.so.0
#59 0x0e5f8170 in g_static_private_free () from /usr/lib/libglib-2.0.so.0
#60 0x0f3d88e8 in start_thread () from /lib/tls/libpthread.so.0
#61 0x0f3d88e8 in start_thread () from /lib/tls/libpthread.so.0
Previous frame inner to this frame (corrupt stack?)

strace reveals:
poll([{fd=27, events=POLLIN|POLLERR|POLLHUP}], 1, 500) = 0
semop(0x70003, 0x2, 0, 0x31e3d8f0)      = 0
shmctl(3014675, IPC_64|IPC_STAT, 0x31e3d900) = 0
semop(0x70003, 0x1, 0, 0x31e3d8ea)      = 0
poll([{fd=27, events=POLLIN|POLLERR|POLLHUP}], 1, 500) = 0
semop(0x70003, 0x2, 0, 0x31e3d8f0)      = 0
shmctl(3014675, IPC_64|IPC_STAT, 0x31e3d900) = 0
semop(0x70003, 0x1, 0, 0x31e3d8ea)      = 0
[continue exactly like this over and over]

fd 27 is some socket:
$ ll /proc/5148/fd
total 2
lrwx------ 1 johannes johannes 64 2006-03-08 18:02 27 -> socket:[13214]
lrwx------ 1 johannes johannes 64 2006-03-08 18:02 28 ->
/dev/snd/pcmC0D0p

Even any other program hangs when I now try to play:
$ strace aplay audiodump.wav
[...]
semget(5678293, 1, IPC_CREAT|0660)      = 458755
semctl(458755, 0, IPC_64|IPC_STAT, 0x7f9dff80) = 0
semctl(458755, 0, IPC_64|IPC_SET, 0x7f9dff80) = 0
semop(0x70003, 0x2, 0, 0x7f9e0036)      = 0
shmget(5678293, 384, IPC_CREAT|0660)    = 3014675
shmat(3014675, 0, 0)                    = 0x3001c000
mlock(0x3001c000, 384)                  = 0
shmctl(3014675, IPC_64|IPC_STAT, 0x7f9dff98) = 0
semop(0x70003, 0x1, 0, 0x7f9e0030)      = 0
socket(PF_FILE, SOCK_STREAM, 0)         = 3
connect(3, {sa_family=AF_FILE,
path="/tmp/alsa-dmix-3544-1141837026-823504"}, 39) = 0
recvmsg(3,
[hung here]

After killing rhythmbox, all works fine again.

-- System Information:
Debian Release: testing/unstable
  APT prefers unstable
  APT policy: (500, 'unstable'), (1, 'experimental')
Architecture: powerpc (ppc)
Shell:  /bin/sh linked to /bin/bash
Kernel: Linux 2.6.16-rc4-f52ee1
Locale: LANG=en_US.UTF-8, LC_CTYPE=en_US.UTF-8 (charmap=UTF-8)

Versions of packages libasound2 depends on:
ii  libc6                         2.3.6-3    GNU C Library: Shared
libraries an

libasound2 recommends no packages.

-- no debconf information

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-10-06 19:22 jdthood        New Issue                                    
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
