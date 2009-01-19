From: Will Wagner <will_wagner@carallon.com>
Subject: aplay hang with 1.0.18
Date: Mon, 19 Jan 2009 12:07:26 +0000
Message-ID: <49746CFE.2010203@carallon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from carallon.f9.co.uk (carallon.force9.co.uk [80.229.37.120])
	by alsa0.perex.cz (Postfix) with ESMTP id E538B1037EC
	for <alsa-devel@alsa-project.org>; Mon, 19 Jan 2009 13:08:15 +0100 (CET)
Received: from [127.0.0.1] by carallon.f9.co.uk (MDaemon PRO v9.6.5)
	with ESMTP id md50000336141.msg
	for <alsa-devel@alsa-project.org>; Mon, 19 Jan 2009 12:07:30 +0000
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi All,

I am seeing a problem with aplay hanging when trying to play a wav file. The problem is 
that it is trying to use an mmap function even though mmap was not initialised. The call 
stack is:

#0  snd_pcm_mmap_begin (pcm=0x400764a0, areas=0x400772c4,
offset=0x40061e1c,
     frames=0x40082f78) at pcm.c:6402
#1  0x40081eb4 in snd_pcm_plugin_write_areas (pcm=0x2b0e8,
areas=0xbeb20950,
     offset=0, size=2048) at pcm_plugin.c:278
#2  0x4006ab20 in snd1_pcm_write_areas (pcm=0x2b0e8, areas=0xbeb20950,
     offset=0, size=2048, func=0x40081e30 <snd_pcm_plugin_write_areas>)
     at pcm.c:6654
#3  0x40082578 in snd_pcm_plugin_writei (pcm=0x2b0e8, buffer=0x2b6c8,
     size=2048) at pcm_plugin.c:361
#4  0x4005e384 in _snd_pcm_writei (pcm=0x21db8, buffer=0x2b6c8,
size=2048)
     at pcm_local.h:516
#5  0x4005e2f8 in snd_pcm_writei (pcm=0x21db8, buffer=0x2b6c8,
size=2048)
     at pcm.c:1243
#6  0x0001045c in pcm_write (data=0x2b6c8 "^", count=2048) at
aplay.c:1432
#7  0x000135b8 in playback_go (fd=5, loaded=0, count=424600, rtype=2,
     name=0xbeb20dd5 "/sdcard/test.wav") at aplay.c:2171
#8  0x00013a0c in playback (name=0xbeb20dd5 "/sdcard/test.wav") at
aplay.c:2231
#9  0x0000c38c in main (argc=2, argv=0xbeb20cd4) at aplay.c:641

It gets here even though the mmap_flag was not set. This then causes an infinite loop as 
no mmap areas have been defined.

My setup was working with version 1.0.16. What could have changed to break this? Is it 
something wrong with my config?

Thanks,

Will.

-- 
------------------------------------------------------------------------
Will Wagner                                     will_wagner@carallon.com
Development Manager                      Office Tel: +44 (0)20 7371 2032
Carallon Ltd, Studio G20, Shepherds Building, Rockley Rd, London W14 0DA
------------------------------------------------------------------------
