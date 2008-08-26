From: "nguyen tritai" <nguyentritai@gmail.com>
Subject: Re: Alsa-driver compile fail on Ubuntu powerpc
Date: Tue, 26 Aug 2008 16:15:05 +0700
Message-ID: <ce83e6480808260215t18abf90ai87046c6a771a3c24@mail.gmail.com>
References: <ce83e6480808140225q7481c888qb47b7008b1ba862d@mail.gmail.com>
	<s5h8wuz1zc0.wl%tiwai@suse.de>
	<ce83e6480808171952p69058dedo661fe9deaa07ca79@mail.gmail.com>
	<ce83e6480808180426i57f0347fic73adb9d44cc52ec@mail.gmail.com>
	<s5hvdxy5ycf.wl%tiwai@suse.de>
	<ce83e6480808250304t1ad72e89l494bc93d8ffdc178@mail.gmail.com>
	<s5hod3he2uu.wl%tiwai@suse.de>
	<ce83e6480808252149h13a2ce18y544701c4f3969406@mail.gmail.com>
	<s5hskss2rkx.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.247])
	by alsa0.perex.cz (Postfix) with ESMTP id B82CA1037F3
	for <alsa-devel@alsa-project.org>;
	Tue, 26 Aug 2008 11:15:06 +0200 (CEST)
Received: by rv-out-0708.google.com with SMTP id f25so1649737rvb.32
	for <alsa-devel@alsa-project.org>; Tue, 26 Aug 2008 02:15:05 -0700 (PDT)
In-Reply-To: <s5hskss2rkx.wl%tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi,

I'm not very familiar with git. Please feel free to help with "git pull".
I have already done "git clone" the latest kernel source 2.6.27-rc4
but I still can't merge sound-unstable-2.6.git with the kernel.

Thanks,
TaiNguyen


On Tue, Aug 26, 2008 at 1:55 PM, Takashi Iwai <tiwai@suse.de> wrote:

> At Tue, 26 Aug 2008 11:49:44 +0700,
> nguyen tritai wrote:
> >
> > Takashi,
> >
> > I'm using the alsa-driver from git  with the latest kernel.org 2.6.26 as
> you
> > suggested me.
>
> There are two different versions: stable and unstable trees.
> The fix for non-coherent platforms is currently only in the unstable
> version, and this can't be built externally via alsa-driver build
> stub (it could, but works only for x86).
>
> You need to build the  kernel by yourself to include some new
> functions, e.g. clone the latest Linus git tree (2.6.27-rc4*), then
> pull sound-unstable-2.6.git on that.
>
>
> thanks,
>
> Takashi
>
>
> > The issue is the same with alsa-driver stable v1.0.18rc1.
> > TaiNguyen
> >
> > On Mon, Aug 25, 2008 at 6:44 PM, Takashi Iwai <tiwai@suse.de> wrote:
> >
> >     At Mon, 25 Aug 2008 17:04:52 +0700,
> >     nguyen tritai wrote:
> >     >
> >     > Takashi,
> >     >
> >     > The issue is still present with the latest alsa-driver.
> >
> >     Which one did you take?  It must be sound-unstable tree.
> >
> >     Anyway, you should better to use sound-unstable-2.6 git tree together
> >     with the latest Linus tree.
> >
> >     Takashi
> >
> >     > Do you think that it's problem with 64 bit resource  with  pcm
> _mmap.
> >     > Here is dmesg :
> >     >
> >     > TASK = cf8b70c0[1579] 'aplay' THREAD: cfab4000
> >     > GPR00: f0f0f0f4 cfab5e20 cf8b70c0 c0ae7040 00000000 4814b000
> cfab2900
> >     00000000
> >     > GPR08: 00000000 00004000 00000000 f0f0f0f0 20008448 1002557c
> 10020000
> >     10020000
> >     > GPR16: 10010000 10024a58 00000008 10042050 100406d8 0ff80d50
> cfa41d40
> >     00000000
> >     > GPR24: 00000000 4814b000 00000000 cfa12948 00000000 4814b000
> cfab2900
> >     cfab5e38
> >     > NIP [d10d4814] snd_pcm_mmap_data_fault+0x78/0xec [snd_pcm]
> >     > LR [c0059fe8] __do_fault+0x64/0x428
> >     > Call Trace:
> >     > [cfab5e20] [c004b748] unlock_page+0x48/0x5c (unreliable)
> >     > [cfab5e30] [c0059fe8] __do_fault+0x64/0x428
> >     > [cfab5e80] [c000fd88] do_page_fault+0x2e8/0x540
> >     > [cfab5f40] [c000d2ec] handle_page_fault+0xc/0x80
> >     > Instruction dump:
> >     > 80090028 2f800000 419e0074 7c0903a6 4e800421 2c030000 41820048
> 80030000
> >     > 7c6b1b78 70094000 40820074 380b0004 <7d200028> 31290001 7d20012d
> >     40a2fff4
> >     > ---[ end trace 11885f716998bc3c ]---
> >     >
> >     > Please show me where the issue is from and can I do something to
> fix it
> >     ?
> >     >
> >     > Thanks
> >     > TaiNguyen
> >     >
> >     > On Mon, Aug 18, 2008 at 6:58 PM, Takashi Iwai <tiwai@suse.de>
> wrote:
> >     >
> >     >     At Mon, 18 Aug 2008 18:26:40 +0700,
> >     >     nguyen tritai wrote:
> >     >     >
> >     >     > Takashi,
> >     >     >
> >     >     > Now I can build and install driver for ca0106 sb Audigy but I
> got
> >     >     another
> >     >     > issue when play an example file.
> >     >     > >> aplay -vv child.wav
> >     >     > Playing WAVE '/root/child.wav' : Unsigned 8 bit, Rate 22050
> Hz,
> >     Mono
> >     >     > Plug PCM: Rate conversion PCM (48000, sformat=U8)
> >     >     > Its setup is:
> >     >     >   stream       : PLAYBACK
> >     >     >   access       : RW_INTERLEAVED
> >     >     >   format       : U8
> >     >     >   subformat    : STD
> >     >     >   channels     : 1
> >     >     >   rate         : 22050
> >     >     >   exact rate   : 22050 (22050/1)
> >     >     >   msbits       : 8
> >     >     >   buffer_size  : 3763
> >     >     >   period_size  : 470
> >     >     >   period_time  : 21333
> >     >     >   tstamp_mode  : NONE
> >     >     >   period_step  : 1
> >     >     >   avail_min    : 470
> >     >     >   period_event : 0
> >     >     >   start_threshold  : 3763
> >     >     >   stop_threshold   : 3763
> >     >     >   silence_threshold: 0
> >     >     >   silence_size : 0
> >     >     >   boundary     : 493223936
> >     >     > Slave: Route conversion PCM (sformat=S32_LE)
> >     >     >   Transformation table:
> >     >     >     0 <- 0
> >     >     >     1 <- 0
> >     >     > Its setup is:
> >     >     >   stream       : PLAYBACK
> >     >     >   access       : MMAP_INTERLEAVED
> >     >     >   format       : U8
> >     >     >   subformat    : STD
> >     >     >   channels     : 1
> >     >     >   rate         : 48000
> >     >     >   exact rate   : 48000 (48000/1)
> >     >     >   msbits       : 8
> >     >     >   buffer_size  : 8192
> >     >     >   period_size  : 1024
> >     >     >   period_time  : 21333
> >     >     >   tstamp_mode  : NONE
> >     >     >   period_step  : 1
> >     >     >   avail_min    : 1024
> >     >     >   period_event : 0
> >     >     >   start_threshold  : 8192
> >     >     >   stop_threshold   : 8192
> >     >     >   silence_threshold: 0
> >     >     >   silence_size : 0
> >     >     >   boundary     : 1073741824
> >     >     > Slave: Direct Stream Mixing PCM
> >     >     > Its setup is:
> >     >     >   stream       : PLAYBACK
> >     >     >   access       : MMAP_INTERLEAVED
> >     >     >   format       : S32_LE
> >     >     >   subformat    : STD
> >     >     >   channels     : 2
> >     >     >   rate         : 48000
> >     >     >   exact rate   : 48000 (48000/1)
> >     >     >   msbits       : 32
> >     >     >   buffer_size  : 8192
> >     >     >   period_size  : 1024
> >     >     >   period_time  : 21333
> >     >     >   tstamp_mode  : NONE
> >     >     >   period_step  : 1
> >     >     >   avail_min    : 1024
> >     >     >   period_event : 0
> >     >     >   start_threshold  : 8192
> >     >     >   stop_threshold   : 8192
> >     >     >   silence_threshold: 0
> >     >     >   silence_size : 0
> >     >     >   boundary     : 1073741824
> >     >     > Hardware PCM card 0 'CA0106' device 0 subdevice 0
> >     >     > Its setup is:
> >     >     >   stream       : PLAYBACK
> >     >     >   access       : MMAP_INTERLEAVED
> >     >     >   format       : S32_LE
> >     >     >   subformat    : STD
> >     >     >   channels     : 2
> >     >     >   rate         : 48000
> >     >     >   exact rate   : 48000 (48000/1)
> >     >     >   msbits       : 32
> >     >     >   buffer_size  : 8192
> >     >     >   period_size  : 1024
> >     >     >   period_time  : 21333
> >     >     >   tstamp_mode  : ENABLE
> >     >     >   period_step  : 1
> >     >     >   avail_min    : 1024
> >     >     >   period_event : 0
> >     >     >   start_threshold  : 1
> >     >     >   stop_threshold   : 1073741824
> >     >     >   silence_threshold: 0
> >     >     >   silence_size : 1073741824
> >     >     >   boundary     : 1073741824
> >     >     > #########         +                                |
> >     35%Segmentation
> >     >     fault
> >     >     >
> >     >     > Kernel dump message
> >     >     > >> dmesg
> >     >     > Unable to handle kernel paging request for data at address
> >     0x00000000
> >     >     > Faulting instruction address: 0xc0033fd4
> >     >     > Oops: Kernel access of bad area, sig: 11 [#7]
> >     >     > Canyonlands
> >     >     > Modules linked in: snd_seq_midi snd_ca0106 snd_rawmidi
> snd_seq_oss
> >     >     > snd_seq_midi_event snd_seq snd_seq_device snd_ac97_codec
> >     snd_pcm_oss
> >     >     > snd_mixer_oss snd_pcm snd_timer snd_page_alloc snd ac97_bus
> >     >     > NIP: c0033fd4 LR: c004ac94 CTR: e901a6c8
> >     >     > REGS: dfbf3d40 TRAP: 0300   Tainted: G      D
> >     >     (2.6.26-00015-gc0b03c1-dirty)
> >     >     > MSR: 00029000 <EE,ME>  CR: 48022444  XER: 20000000
> >     >     > DEAR: 00000000, ESR: 00000000
> >     >     > TASK = dfa57000[15245] 'aplay' THREAD: dfbf2000
> >     >     > GPR00: c004ac94 dfbf3df0 dfa57000 00000000 c0b2c180 00000000
> >     3f10c149
> >     >     00000000
> >     >     > GPR08: 00000000 00000000 9e370001 c030b10c 00000149 10025478
> >     1000bd14
> >     >     bff7ab68
> >     >     > GPR16: c0320000 c030ae74 c0320000 00000000 00000000 00000000
> >     00000000
> >     >     de14c340
> >     >     > GPR24: 4814b000 00000000 dfbf2000 de00c2c0 c0b2c180 00000000
> >     00000000
> >     >     c0b2c180
> >     >     > NIP [c0033fd4] __wake_up_bit+0x10/0x40
> >     >     > LR [c004ac94] unlock_page+0x48/0x5c
> >     >     > Call Trace:
> >     >     > [dfbf3e10] [c004ac94] unlock_page+0x48/0x5c
> >     >     > [dfbf3e20] [c005a2d8] __do_fault+0x254/0x618
> >     >     > [dfbf3e80] [c000faf0] do_page_fault+0x2d8/0x518
> >     >     > [dfbf3f40] [c000d134] handle_page_fault+0xc/0x80
> >     >     > Instruction dump:
> >     >     > 7d6b4a14 800b0280 812b0278 20000020 7c630430 54631838
> 7c634a14
> >     4e800020
> >     >     > 7c0802a6 9421ffe0 90810008 90010024 <80030000> 90a1000c
> 7f801800
> >     >     419e0014
> >     >     > ---[ end trace a0b9d3bfbd44991b ]---
> >     >     >
> >     >     > I tried with another example file.wav but the problem is the
> same.
> >     >     > The issue seems from accessing memory.
> >     >     > I'm using AMCC 460EX board with distribution Ubuntu-7.04
> >     >
> >     >     It's a known problem with non-coherent PPC architecture.
> >     >     Try my sound-unstable-2.6 git tree (or alsa-driver-unstable
> >     snapshot).
> >     >
> >     >     Takashi
> >     >
> >     >
> >
> >
>
