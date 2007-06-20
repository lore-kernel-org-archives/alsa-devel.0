From: "Pharaoh ." <pharaoh137@gmail.com>
Subject: Re: pcm->private_data is NULL in alsa core!!
Date: Wed, 20 Jun 2007 16:46:30 +0530
Message-ID: <61445c750706200416y4654fcfcq8a064c645956f5e@mail.gmail.com>
References: <61445c750706160550i592b416as6c766532de830147@mail.gmail.com>
	<1182152265.9399.1195673497@webmail.messagingengine.com>
	<61445c750706180456i5228c8dbqbd168e5a3bbbe435@mail.gmail.com>
	<1182251430.29389.1195911445@webmail.messagingengine.com>
	<61445c750706190430i7d8f37b3g95326d7aee6c5056@mail.gmail.com>
	<1182263378.1273.1195944481@webmail.messagingengine.com>
	<61445c750706200318h6758cf78o64dfd3e6a88ea8bb@mail.gmail.com>
	<61445c750706200412i52e6666fjc7a5552972b18f7b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.177])
	by alsa0.perex.cz (Postfix) with ESMTP id 453F6244B6
	for <alsa-devel@alsa-project.org>;
	Wed, 20 Jun 2007 13:16:32 +0200 (CEST)
Received: by wa-out-1112.google.com with SMTP id m33so67704wag
	for <alsa-devel@alsa-project.org>; Wed, 20 Jun 2007 04:16:31 -0700 (PDT)
In-Reply-To: <61445c750706200412i52e6666fjc7a5552972b18f7b@mail.gmail.com>
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
To: Clemens Ladisch <cladisch@fastmail.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The problem still persists!! I get the following:

While insmoding :

.....................
Registering the sound card
pcm->private in snd_device_register_all is c1d7d310 //correct
Inside snd_pcm_dev_register, pcm is c1f05d44(correct), pcm->pvt_data
is 00000000(This shouldn't be NULL)
In snd_device_register, eac is c1d7d310 //correct
In snd_device_register, eac is c1d7d310
......................



# cat a.sh > dev/audio
pcm name is omap  alsa pcm
pcm id is OMAP PCM
pcm private is 00000000
PLAYBACK
Unable to handle kernel paging request at virtual address e591321c
pgd = c1fb4000
[e591321c] *pgd=00000000
Internal error: Oops: 5 [#1]
Modules linked in: omap_audio
CPU: 0
PC is at snd_pcm_oss_open+0x374/0x578
LR is at 0xc1f23e00
pc : [<c0192e14>]    lr : [<c1f23e00>]    Not tainted
sp : c1f23db4  ip : c0118cd0  fp : c1f23e60
r10: c1f22000  r9 : 00000004  r8 : c0118c10
r7 : 00000000  r6 : c199e1c8  r5 : c1f05df4  r4 : c1f23df0
r3 : 00000000  r2 : 00000000  r1 : e5913000  r0 : 00000000
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  Segment user
Control: 5317F
Table: 11FB4000  DAC: 00000015
Process sh (pid: 209, stack limit = 0xc1f22250)
Stack: (0xc1f23db4 to 0xc1f24000)
3da0:                                              c1f05e8c c1f05e74 0000000e
3dc0: 00000000 00000001 c1f05d44 c0374e3c c18e834c c0118c10 00000000 00000000
3de0: c0370580 c003c1f4 c1f05e8c c1f05e8c 00000000 00000000 00000000 00000000
3e00: 00000000 00000000 00000000 00000000 00000000 00000000 74006873 00726500
3e20: 00000000 00000000 c022d400 c005d088 c1d67b68 00000000 c028220c c1f22000
3e40: 00000000 00000003 c028306c c18e834c c0374e3c c1f23e90 c1f23e64 c0174cc0
3e60: c0192ab0 00000001 c1f22000 c1d37f08 c18e834c 00000000 00000001 c1f22000
3e80: c0374e3c c1f23ebc c1f23e94 c009145c c0174a2c 00000004 c0374e3c c18e834c
3ea0: c00912c0 c1e5feec c032a280 00000001 c1f23ee4 c1f23ec0 c008cb78 c00912d0
3ec0: c0374e3c c1f23f04 00000003 ffffff9c c0025024 c1955000 c1f23efc c1f23ee8
3ee0: c008ccbc c008c9c4 00000000 00000241 c1f23f68 c1f23f00 c008cd20 c008cc98
3f00: c1f23f04 c1e5feec c032a280 10bc8063 00000005 c1955004 00000300 00000000
3f20: 00000000 c033913c c1f22000 ffffffe8 c1f22000 c1955000 c1f23f68 c1f23f48
3f40: c008ceb8 c00a65dc 00000242 000001b6 c0374e3c 00000241 000001b6 c1f23f94
3f60: c1f23f6c c008d118 c008cce4 0003fe80 ffffffff 000ddd9c 000ddd24 00000005
3f80: c0025024 000e7460 c1f23fa4 c1f23f98 c008d1cc c008d0cc 00000000 c1f23fa8
3fa0: c0024e80 c008d1b8 ffffffff 000ddd9c 000ddd9c 00000241 000001b6 00000000
3fc0: ffffffff 000ddd9c 000ddd24 bed0ed24 bed0ed7c 00000003 000e7460 000ddd8c
3fe0: 00000fe0 bed0eb58 0002cdac 000704d4 60000010 000ddd9c 00000000 00000000
Backtrace:
[<c0192aa0>] (snd_pcm_oss_open+0x0/0x578) from [<c0174cc0>]
(soundcore_open+0x2a4/0x408)
[<c0174a1c>] (soundcore_open+0x0/0x408) from [<c009145c>]
(chrdev_open+0x19c/0x218)
[<c00912c0>] (chrdev_open+0x0/0x218) from [<c008cb78>]
(__dentry_open+0x1c4/0x2d4)
[<c008c9b4>] (__dentry_open+0x0/0x2d4) from [<c008ccbc>]
(nameidata_to_filp+0x34/0x4c)
[<c008cc88>] (nameidata_to_filp+0x0/0x4c) from [<c008cd20>]
(do_filp_open+0x4c/0x50)
 r4 = 00000241
[<c008ccd4>] (do_filp_open+0x0/0x50) from [<c008d118>] (do_sys_open+0x5c/0xec)
 r5 = 000001B6  r4 = 00000241
[<c008d0bc>] (do_sys_open+0x0/0xec) from [<c008d1cc>] (sys_open+0x24/0x28)
[<c008d1a8>] (sys_open+0x0/0x28) from [<c0024e80>] (ret_fast_syscall+0x0/0x2c)
Code: e59830a4 e3c33b02 e58830a4 e5981070 (e5d1321c)

On 6/20/07, Pharaoh . <pharaoh137@gmail.com> wrote:
> On 6/20/07, Pharaoh . <pharaoh137@gmail.com> wrote:
> > I think I have fixed the problem, atleast the value of
> > pcm->private_data doesn't get currupted anymore...After enabling
> > kernel debugging for semaphores/mutexes, I realised that code was
> > sleeping in a place where it was not supposed to. I dont know/didn't
> > check where exactly the memory was getting corrupted but after doing
> > appropriate lock/unlock the pcm->private_data seems looks healthy.
> >
> > But now when I do cat /dev/audio/ the machine just hangs!! Looking in to
> it.
> >
> > Clemens, I was holding mutexes in register_codec(), there it was
> > corrupting. Thanks for help.
> >
> > -pharaoh.
> >
> > On 6/19/07, Clemens Ladisch <cladisch@fastmail.net> wrote:
> > > Pharaoh . wrote:
> > > > in register codec 4 pvt data is c3d81180
> > > > Registering the sound card
> > > > in register codec 5 pvt data is c3998f20
> > > >
> > > > i.e. after registering the sound card the value changes/gets
> > > > corrupted, and c3998f20
> > > > is not the value I get everytime, so I am thinking it is corrrupted
> > > somehow.
> > >
> > > I'd guess the memory gets overwritten.
> > >
> > > > But back in probe, after above function are executed, i.e. after
> > > > register codec is over, I get the correct value for
> > > > eac->pcm->private_data i.e. c3d81180, but by now the value of
> > > > pcm->private_data is corrupted!
> > >
> > > This implies that eac->pcm != pcm.
> > >
> > > It seems quite a lot of memory gets corrupted.
> > > Try to check which one of the various "eac" and "pcm" pointers changes
> > > its value.
> > >
> > >
> > > HTH
> > > Clemens
> > >
> >
>
