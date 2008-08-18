From: "nguyen tritai" <nguyentritai@gmail.com>
Subject: Re: Alsa-driver compile fail on Ubuntu powerpc
Date: Mon, 18 Aug 2008 18:26:40 +0700
Message-ID: <ce83e6480808180426i57f0347fic73adb9d44cc52ec@mail.gmail.com>
References: <ce83e6480808140225q7481c888qb47b7008b1ba862d@mail.gmail.com>
	<s5h8wuz1zc0.wl%tiwai@suse.de>
	<ce83e6480808171952p69058dedo661fe9deaa07ca79@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.234])
	by alsa0.perex.cz (Postfix) with ESMTP id 5EA8C24416
	for <alsa-devel@alsa-project.org>;
	Mon, 18 Aug 2008 13:26:42 +0200 (CEST)
Received: by wr-out-0506.google.com with SMTP id 36so2108515wra.24
	for <alsa-devel@alsa-project.org>; Mon, 18 Aug 2008 04:26:41 -0700 (PDT)
In-Reply-To: <ce83e6480808171952p69058dedo661fe9deaa07ca79@mail.gmail.com>
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
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi,

Now I can build and install driver for ca0106 sb Audigy but I got another
issue when play an example file.
>> aplay -vv child.wav
Playing WAVE '/root/child.wav' : Unsigned 8 bit, Rate 22050 Hz, Mono
Plug PCM: Rate conversion PCM (48000, sformat=U8)
Its setup is:
  stream       : PLAYBACK
  access       : RW_INTERLEAVED
  format       : U8
  subformat    : STD
  channels     : 1
  rate         : 22050
  exact rate   : 22050 (22050/1)
  msbits       : 8
  buffer_size  : 3763
  period_size  : 470
  period_time  : 21333
  tstamp_mode  : NONE
  period_step  : 1
  avail_min    : 470
  period_event : 0
  start_threshold  : 3763
  stop_threshold   : 3763
  silence_threshold: 0
  silence_size : 0
  boundary     : 493223936
Slave: Route conversion PCM (sformat=S32_LE)
  Transformation table:
    0 <- 0
    1 <- 0
Its setup is:
  stream       : PLAYBACK
  access       : MMAP_INTERLEAVED
  format       : U8
  subformat    : STD
  channels     : 1
  rate         : 48000
  exact rate   : 48000 (48000/1)
  msbits       : 8
  buffer_size  : 8192
  period_size  : 1024
  period_time  : 21333
  tstamp_mode  : NONE
  period_step  : 1
  avail_min    : 1024
  period_event : 0
  start_threshold  : 8192
  stop_threshold   : 8192
  silence_threshold: 0
  silence_size : 0
  boundary     : 1073741824
Slave: Direct Stream Mixing PCM
Its setup is:
  stream       : PLAYBACK
  access       : MMAP_INTERLEAVED
  format       : S32_LE
  subformat    : STD
  channels     : 2
  rate         : 48000
  exact rate   : 48000 (48000/1)
  msbits       : 32
  buffer_size  : 8192
  period_size  : 1024
  period_time  : 21333
  tstamp_mode  : NONE
  period_step  : 1
  avail_min    : 1024
  period_event : 0
  start_threshold  : 8192
  stop_threshold   : 8192
  silence_threshold: 0
  silence_size : 0
  boundary     : 1073741824
Hardware PCM card 0 'CA0106' device 0 subdevice 0
Its setup is:
  stream       : PLAYBACK
  access       : MMAP_INTERLEAVED
  format       : S32_LE
  subformat    : STD
  channels     : 2
  rate         : 48000
  exact rate   : 48000 (48000/1)
  msbits       : 32
  buffer_size  : 8192
  period_size  : 1024
  period_time  : 21333
  tstamp_mode  : ENABLE
  period_step  : 1
  avail_min    : 1024
  period_event : 0
  start_threshold  : 1
  stop_threshold   : 1073741824
  silence_threshold: 0
  silence_size : 1073741824
  boundary     : 1073741824
#########         +                                | 35%Segmentation fault

Kernel dump message
>> dmesg
Unable to handle kernel paging request for data at address 0x00000000
Faulting instruction address: 0xc0033fd4
Oops: Kernel access of bad area, sig: 11 [#7]
Canyonlands
Modules linked in: snd_seq_midi snd_ca0106 snd_rawmidi snd_seq_oss
snd_seq_midi_event snd_seq snd_seq_device snd_ac97_codec snd_pcm_oss
snd_mixer_oss snd_pcm snd_timer snd_page_alloc snd ac97_bus
NIP: c0033fd4 LR: c004ac94 CTR: e901a6c8
REGS: dfbf3d40 TRAP: 0300   Tainted: G      D
(2.6.26-00015-gc0b03c1-dirty)
MSR: 00029000 <EE,ME>  CR: 48022444  XER: 20000000
DEAR: 00000000, ESR: 00000000
TASK = dfa57000[15245] 'aplay' THREAD: dfbf2000
GPR00: c004ac94 dfbf3df0 dfa57000 00000000 c0b2c180 00000000 3f10c149
00000000
GPR08: 00000000 00000000 9e370001 c030b10c 00000149 10025478 1000bd14
bff7ab68
GPR16: c0320000 c030ae74 c0320000 00000000 00000000 00000000 00000000
de14c340
GPR24: 4814b000 00000000 dfbf2000 de00c2c0 c0b2c180 00000000 00000000
c0b2c180
NIP [c0033fd4] __wake_up_bit+0x10/0x40
LR [c004ac94] unlock_page+0x48/0x5c
Call Trace:
[dfbf3e10] [c004ac94] unlock_page+0x48/0x5c
[dfbf3e20] [c005a2d8] __do_fault+0x254/0x618
[dfbf3e80] [c000faf0] do_page_fault+0x2d8/0x518
[dfbf3f40] [c000d134] handle_page_fault+0xc/0x80
Instruction dump:
7d6b4a14 800b0280 812b0278 20000020 7c630430 54631838 7c634a14 4e800020
7c0802a6 9421ffe0 90810008 90010024 <80030000> 90a1000c 7f801800 419e0014
---[ end trace a0b9d3bfbd44991b ]---


I tried with another example file.wav but the problem is the same.
The issue seems from accessing memory.
I'm using AMCC 460EX board with distribution Ubuntu-7.04
Feel free to help me.

Thanks,

TaiNguyen.

I tried with another wav

On Mon, Aug 18, 2008 at 9:52 AM, nguyen tritai <nguyentritai@gmail.com>wrote:

> Hi Takashi,
>
> Thank for your help. I checked in the config.log as you told me and see
> that the issue is from the linux-header .
> I'm now working on it.
>
> Thanks,
>
> TaiNguyen
>
>
> On Thu, Aug 14, 2008 at 8:49 PM, Takashi Iwai <tiwai@suse.de> wrote:
>
>> At Thu, 14 Aug 2008 16:25:24 +0700,
>> nguyen tritai wrote:
>> >
>> > Hi all,
>> >
>> > I'm trying to bring up audio on powerpc AMCC 440EPX board with the
>> soundcard
>> > Sound Blaster Audigy CA0106.
>> > The board is runing Ubuntu 7.04.
>> > I configured: ./configure --with-cards=ca0106 --with-sequencer=yes
>> > --with-kernel=/usr/src/linux
>> > Then I make and get issue:
>> >
>> > make[2]: Leaving directory `/root/alsa-driver-1.0.17/usb'
>> > make[2]: Entering directory `/root/alsa-driver-1.0.17/misc'
>> > make[2]: Leaving directory `/root/alsa-driver-1.0.17/misc'
>> > make[1]: Leaving directory `/root/alsa-driver-1.0.17'
>> > make -C /usr/src/linux SUBDIRS=/root/alsa-driver-1.0.17  CPP="gcc -E"
>> > CC="gcc" modules
>> > make[1]: Entering directory `/usr/src/linux'
>> >   CC [M]  /root/alsa-driver-1.0.17/acore/memory_wrapper.o
>> > make[1]: Leaving directory `/usr/src/linux'
>> > root@sequoia:~/alsa-driver-1.0.17# vim log
>> > In file included from
>> /root/alsa-driver-1.0.17/acore/memory_wrapper.c:25:
>> > /root/alsa-driver-1.0.17/include/adriver.h:278:1: warning: "GFP_DMA32"
>> > redefined
>> > In file included from include/linux/slab.h:14,
>> >                  from include/linux/percpu.h:5,
>> >                  from include/linux/rcupdate.h:41,
>> >                  from include/linux/pid.h:4,
>> >                  from include/linux/sched.h:76,
>> >                  from /root/alsa-driver-1.0.17/include/asm/elf.h:5,
>> >                  from include/linux/elf.h:7,
>> >                  from include/linux/module.h:14,
>> >                  from /root/alsa-driver-1.0.17/include/adriver.h:26,
>> >                  from
>> /root/alsa-driver-1.0.17/acore/memory_wrapper.c:25:
>> > include/linux/gfp.h:105:1: warning: this is the location of the previous
>> > definition
>>
>> This means that configure script didn't detect the things correctly.
>> Doesn't the snapshot version work, too?
>> If no, check config.log about the relevant part checking DMA32.
>>
>>
>> Takashi
>>
>
>
