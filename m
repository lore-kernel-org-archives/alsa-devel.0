From: Tanu Kaskinen <tanuk@iki.fi>
Subject: Segfaults in snd_pcm_area_silence() when using softvol
Date: Wed, 17 Oct 2012 14:54:52 +0300
Message-ID: <1350474892.6596.24.camel@x230>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 23871265201
 for <alsa-devel@alsa-project.org>; Wed, 17 Oct 2012 13:54:56 +0200 (CEST)
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
 by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 5C03320773
 for <alsa-devel@alsa-project.org>; Wed, 17 Oct 2012 07:54:55 -0400 (EDT)
Received: from [10.20.14.36] (unknown [195.16.210.229])
 by mail.messagingengine.com (Postfix) with ESMTPA id BF1474827BF
 for <alsa-devel@alsa-project.org>; Wed, 17 Oct 2012 07:54:54 -0400 (EDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

A bug was reported to pulseaudio about a segfault in alsa-lib code when
using softvol: https://bugs.freedesktop.org/show_bug.cgi?id=51060 . It
has been observed by several people, and this mail was prompted by the
last bug comment, which rightly recommends getting in touch with the
alsa developers:


> I've had this problem too and the problem only occurs with
> -ftree-vectorize.
> 
> It looks to me as if this is a gcc bug, as it produces a "movdqa" or
> "vmovdqa" instruction which is used with an unaligned pointer.
> 
> Now, I have no clue why gcc assumes the pointer would be an aligned
> one, maybe it is even right and something else is wrong, but I haven't
> spent too much time digging into this.
> 
> (note that it still happens with gcc 4.7 and the current 4.8
> development one)
> 
> Also, this bug should probably be brought up with the alsa guys as
> well, as I don't think pulseaudio is at fault here.


Here's the stack trace for your convenience (see the linked bug for more
details)

#0  snd_pcm_area_silence (dst_area=0x7fffe875bb00, dst_offset=<optimized out>, samples=2, 
    format=SND_PCM_FORMAT_S16_LE) at pcm.c:2549
#1  0x00007fffe87b4398 in snd_pcm_areas_silence (dst_areas=0x5555557fa100, 
    dst_offset=891, channels=2, frames=439, format=SND_PCM_FORMAT_S16_LE) at pcm.c:2662
#2  0x00007fffe87f9bdb in softvol_convert_stereo_vol (svol=0x555555813cf0, 
    dst_areas=0x5555557fa0e0, dst_offset=891, src_areas=0x5555557fa0e0, 
    src_offset=<optimized out>, channels=2, frames=439) at pcm_softvol.c:286
#3  0x00007fffe87fae58 in snd_pcm_softvol_write_areas (pcm=0x55555581db60, 
    areas=0x5555557fa0e0, offset=891, size=439, slave_areas=0x5555557fa0e0, 
    slave_offset=891, slave_sizep=0x7fffe875bcd0) at pcm_softvol.c:607
#4  0x00007fffe87c6fc7 in snd_pcm_plugin_mmap_commit (pcm=0x55555581db60, 
    offset=<optimized out>, size=439) at pcm_plugin.c:424
#5  0x00007fffe87b9676 in snd_pcm_mmap_commit (pcm=<optimized out>, 
    offset=<optimized out>, frames=<optimized out>) at pcm.c:6584
#6  0x00007fffe8a74876 in mmap_write (on_timeout=false, polled=false, 
    sleep_usec=<synthetic pointer>, u=0x5555557e6d40) at modules/alsa/alsa-sink.c:636
#7  thread_func (userdata=0x5555557e6d40) at modules/alsa/alsa-sink.c:1694
#8  0x00007ffff722c039 in internal_thread_func (userdata=0x55555587ef80)
    at pulsecore/thread-posix.c:83
#9  0x00007ffff4a24e2c in ?? () from /lib64/libpthread.so.0
#10 0x00007ffff3ccc1dd in clone () from /lib64/libc.so.6

-- 
Tanu
