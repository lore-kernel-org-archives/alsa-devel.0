From: Tim Goetze <tim@quitte.de>
Subject: snd_pcm_close hangs
Date: Thu, 30 May 2002 17:14:03 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.21.0205301633140.699-100000@summer.quitte>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from post.webmailer.de (natwar.webmailer.de [192.67.198.70])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id RAA16481
	for <alsa-devel@alsa-project.org>; Thu, 30 May 2002 17:21:45 +0200
Received: from localhost (A37b0.pppool.de [213.6.55.176])
	by post.webmailer.de (8.9.3/8.8.7) with ESMTP id RAA09414
	for <alsa-devel@alsa-project.org>; Thu, 30 May 2002 17:21:07 +0200 (MEST)
Received: from localhost ([127.0.0.1] ident=tim)
	by localhost with esmtp (Exim 3.12 #1 (Debian))
	id 17DRcq-0002uL-00
	for <alsa-devel@alsa-project.org>; Thu, 30 May 2002 17:14:04 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

hi all,

both emu8k and ice1712 pcm drivers hang forever in ioctl(2) when
closing a playback stream if the stream has been linked to the 
same card's capture, has been prepared and written data to, but was
never started:

Program received signal SIGINT, Interrupt.
0x403b8fa4 in ioctl () from /lib/libc.so.6
(gdb) bt
#0  0x403b8fa4 in ioctl () from /lib/libc.so.6
#1  0x40580abc in __DTOR_END__ () from /usr/lib/libasound.so.2
#2  0x4053bde9 in snd_pcm_drain (pcm=0x81c6ae8) at pcm.c:813
#3  0x4053b649 in snd_pcm_close (pcm=0x81c6ae8) at pcm.c:552
#4  0x40462d79 in AlsaStream::~AlsaStream (this=0x81bf6a8,
__in_chrg=0)
    at AlsaStream.cc:41
#5  0x4049ef01 in AlsaOut::~AlsaOut (this=0x81bf6a8, __in_chrg=3)
    at PyType.h:110
...

this is a minor bug i guess, but it can be annoying. 

cvs is current, access is MMAP_INTERLEAVED. do you need more info?

tim



_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
