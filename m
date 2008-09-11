From: "vasudha rao" <vasudha.jrao@gmail.com>
Subject: Re: Alsa-devel Digest, Vol 19, Issue 97
Date: Thu, 11 Sep 2008 19:37:01 +0530
Message-ID: <eeb9eca50809110707y262003aei6884abbe16ec8df3@mail.gmail.com>
References: <5BF78BCE8D9BF14A83F836BD9E3916BA23C5B5@blrms.slti.sanyo.co.in>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.177])
	by alsa0.perex.cz (Postfix) with ESMTP id C28882435D
	for <alsa-devel@alsa-project.org>;
	Thu, 11 Sep 2008 16:07:02 +0200 (CEST)
Received: by wa-out-1112.google.com with SMTP id m28so227218wag.8
	for <alsa-devel@alsa-project.org>; Thu, 11 Sep 2008 07:07:01 -0700 (PDT)
In-Reply-To: <5BF78BCE8D9BF14A83F836BD9E3916BA23C5B5@blrms.slti.sanyo.co.in>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Prithwee Narayan N S <prithweens@sanyo.co.in>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Since I got like,

$cat /proc/asound/devices
  2:        : timer
  3:        : sequencer
  4: [ 0- 0]: digital audio playback
  5: [ 0]   : control

I created nodes according to this like,

$ls -l /dev/snd/
total 0
crw-r--r--    1 root     root     116,   5 Jun 14 18:58 controlC0
crw-r--r--    1 root     root     116,  24 Jun 14 18:55 pcmC0D0c
crw-r--r--    1 root     root     116,   4 Jun 14 18:59 pcmC0D0p
crw-r--r--    1 root     root     116,   2 Jun 14 18:59 timer


Now when I played aplay,

$aplay alarm.wav
Playing WAVE '/home/alarm.wav' : Unsigned 8 bit, Rate 22050 Hz, Mono
<3>Bad pte = 5fc2d05f, process = aplay, vm_flags = 800fb, vaddr = 4001c000
Unable to handle kernel NULL pointer dereference at virtual address 00000003
pgd = c2a70000
[00000003] *pgd=22a30031, *pte=00000000, *ppte=00000000
Internal error: Oops: 1 [#2]
Modules linked in:
CPU: 0
PC is at snd_pcm_mmap_data_nopage+0xc4/0xe8
LR is at 0x4001d000
pc : [<c01bf854>]    lr : [<4001d000>]    Not tainted
sp : c2a4fe6c  ip : ffffffff  fp : c2a4fe80
r10: 4001d000  r9 : c002bba0  r8 : c2a4e000
r7 : c2e364c4  r6 : 00000000  r5 : c2a4fea0  r4 : c2a7ac00
r3 : 00000093  r2 : 00000013  r1 : 00002000  r0 : c0afa5c0
Flags: nzcv  IRQs off  FIQs on  Mode SVC_32  Segment user
Control: 5317F
Table: 22A70000  DAC: 00000015
Process aplay (pid: 912, stack limit = 0xc2a4e250)
Stack: (0xc2a4fe6c to 0xc2a50000)
fe60:                            00000000 c29b3544 c2a4fecc c2a4fe84
c0079c58
fe80: c01bf7a0 c2a71000 c002bbe0 5fc2d05f 00000000 00000000 c2a71000
00000000
fea0: 00000002 ffffffeb c03d0040 c2e364c4 c002bba0 c002bbd4 c2a4ffb0
4001d000
fec0: c2a4ff04 c2a4fed0 c003b3a4 c0079b2c 000227d0 00000000 00000017
ffffffff
fee0: c02cd04c 00000017 c2a4ffb0 4001d000 4032e000 400cb5fc c2a4ffac
c2a4ff08
ff00: c003b5c0 c003b2dc c2a4ff14 c2faddc0 ffffffe7 c0844123 00000000
c0035ec4
ff20: 400cb5fc c2a4ff40 c2a4ff34 c01c15b8 c01c10e4 c2a4ff5c c2a4ff44
c00943d0
ff40: c01c1594 c2faddc0 000227d0 00000004 c2a4ff84 c2a4ff60 c00946ac
c00943a4
ff60: 000003d8 00000000 c2faddc0 fffffff7 c0844123 00000036 c2a4ffa4
c2a4ff88
ff80: c009470c c0094428 00000000 ffffffff 4032e320 00000008 00000004
00000004
ffa0: 00000000 c2a4ffb0 c0035cc8 c003b594 00000000 4001d000 4032c000
ffffff00
ffc0: 00000400 4032e320 00000008 00000004 00000004 4032e000 400cb5fc
000004c8
ffe0: ffffff00 bebb29e0 ffffff00 4008ce20 20000010 ffffffff 4009e42c
4009e464
Backtrace:
[<c01bf790>] (snd_pcm_mmap_data_nopage+0x0/0xe8) from [<c0079c58>]
(__handle_mm_fault+0x13c/0x760)
 r5 = C29B3544  r4 = 00000000
[<c0079b1c>] (__handle_mm_fault+0x0/0x760) from [<c003b3a4>]
(do_page_fault+0xd8/0x20c)
[<c003b2cc>] (do_page_fault+0x0/0x20c) from [<c003b5c0>]
(do_DataAbort+0x3c/0xa0)
[<c003b584>] (do_DataAbort+0x0/0xa0) from [<c0035cc8>]
(ret_from_exception+0x0/0x10)
 r8 = 00000004  r7 = 00000004  r6 = 00000008  r5 = 4032E320
 r4 = FFFFFFFF
Code: 1590c00c e10f2000 e3823080 e121f003 (e59c3004)
 Segmentation fault


No sound ...:-((



Where I am doing wrong..??



On Thu, Sep 11, 2008 at 6:12 PM, Prithwee Narayan N S <
prithweens@sanyo.co.in> wrote:

>  Hi,
>
>
>
> Try the following nodes.
>
>
>
> # cat /proc/asound/devices
>
>   0: [ 0]   : control
>
>  16: [ 0- 0]: digital audio playback
>
>  24: [ 0- 0]: digital audio capture
>
>  33:        : timer
>
>
>
> / # ls -l /dev/snd/
>
> crw-rw----    1 0        101      116,   0 Jan  1 00:00 controlC0
>
> crw-rw----    1 0        101      116,  24 Jan  1 00:00 pcmC0D0c
>
> crw-rw----    1 0        101      116,  16 Jan  1 00:00 pcmC0D0p
>
> crw-rw----    1 0        101      116,  33 Jan  1 00:00 timer
>
>
>
> *aplay** -D hw:**0**,0 file.wav* or *aplay** -D plughw:0,0 file.wav*should play your WAV file provided you have the correct alsa.conf file.
>
>
>
> Regards,
>
> Prithwee Narayan.
>
>
>
> On Wed, Sep 10, 2008 at 6:16 PM, vasudha rao <vasudha.jrao@gmail.com>
> wrote:
>
> >
>
> > Hi ,
>
> >
>
> > I want to play and record audio file in my custom atmel 9263 board
>
> > running with linux(2.6.20).
>
> > when I tried to play aplay for a wave file, I got
>
> >
>
> > $aplay /home/alarm.wav
>
> > ALSA lib pcm.c:1707:(snd_pcm_open_noupdate) Unknown PCM default
>
> > aplay: main:446: audio open error: No such file or directory
>
> >
>
> > $aplay -l
>
> > aplay: device_list:187: no soundcards found...
>
> >
>
> > $cat /proc/asound/devices
>
> >  2:        : timer
>
> >  3:        : sequencer
>
> >  4: [ 0- 0]: digital audio playback
>
> >  5: [ 0]   : control
>
> >
>
> > Can you tel me where I am doing wrong..??
>
> >
>
> > Thanks in advance..
>
