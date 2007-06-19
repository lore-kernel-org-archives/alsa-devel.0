From: "Pharaoh ." <pharaoh137@gmail.com>
Subject: Re: pcm->private_data is NULL in alsa core!!
Date: Tue, 19 Jun 2007 17:00:46 +0530
Message-ID: <61445c750706190430i7d8f37b3g95326d7aee6c5056@mail.gmail.com>
References: <61445c750706160550i592b416as6c766532de830147@mail.gmail.com>
	<1182152265.9399.1195673497@webmail.messagingengine.com>
	<61445c750706180456i5228c8dbqbd168e5a3bbbe435@mail.gmail.com>
	<1182251430.29389.1195911445@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.183])
	by alsa0.perex.cz (Postfix) with ESMTP id 6613E243A1
	for <alsa-devel@alsa-project.org>;
	Tue, 19 Jun 2007 13:30:48 +0200 (CEST)
Received: by py-out-1112.google.com with SMTP id a29so3651963pyi
	for <alsa-devel@alsa-project.org>; Tue, 19 Jun 2007 04:30:47 -0700 (PDT)
In-Reply-To: <1182251430.29389.1195911445@webmail.messagingengine.com>
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

On 6/19/07, Clemens Ladisch <cladisch@fastmail.net> wrote:
> Pharaoh . wrote:
> > > > I have set the pcm->private_data = my_chip after registering the pcm
> ops,
> > > > ... but after I do snd_card_register(card) the pcm->private_data is
> > > > corrupted !!
>
> snd_card_omap_alsa_pcm() should be __devinit, and full duplex is implied
> when no other XXX_DUPLEX flag is set, but I couldn't find any obvious
> errors related to private_data.
>
> Does the changing of private_data really occur in snd_card_register(),
> i.e., the output you get is:
>
> | in register codec 4 pvt data is (something)
> | in register codec 5 pvt data is 0
>
> And the new value is NULL?
>
> snd_card_register() calls callbacks for all registered devices.  It
> could be possible that some callback registered by eac_register_mixer()
> does something, but I don't know what this function does.
>
>
> Regards,
> Clemens
>

Thanks Clemens for pondering over it.

> snd_card_omap_alsa_pcm() should be __devinit, and full duplex is implied
> when no other XXX_DUPLEX flag is set, but I couldn't find any obvious
> errors related to private_data.

I got it.

> Does the changing of private_data really occur in snd_card_register(),
> i.e., the output you get is:
>
> | in register codec 4 pvt data is (something)
> | in register codec 5 pvt data is 0
>
> And the new value is NULL?

I get the following outputs:

in register codec 2 pvt data is c3d81180
in register codec 3 pvt data is c3d81180
in register codec 4 pvt data is c3d81180
Registering the sound card
in register codec 5 pvt data is c3998f20

i.e. after registering the sound card the value changes/gets
corrupted, and c3998f20
is not the value I get everytime, so I am thinking it is corrrupted somehow.

But back in probe, after above function are executed, i.e. after
register codec is over, I get the correct value for
eac->pcm->private_data i.e. c3d81180, but by now the value of
pcm->private_data is corrupted! I am missing something here, I am
sure.

> snd_card_register() calls callbacks for all registered devices.  It
> could be possible that some callback registered by eac_register_mixer()
> does something, but I don't know what this function does.

eac_register_mixer was added later on, so I am sure it doesn't do
anything with pcm.
The error/fault predates the addition of this function and is
reproduced without it too.

When I open the device I get,

# cat /dev/audio
Inside snd_pcm_attach_substream
pcm name is omap alsa pcm   /*This is correct.*/
pcm id is OMAP PCM                /*This is correct.*/
pcm private is 00000000       /*This shouldn't be NULL !!*/
In RECORD
Copying the pvt_data            /* i.e. substream->private_data =
pcm->private_data;*/
pcm is not NULL
pvt data is NULL                   /*This shouldn't be NULL !!*/
Done Copying the pvt_data
Unable to handle kernel paging request at virtual address e5963230

pgd = c3e78000
[e5963230] *pgd=00000000
Internal error: Oops: 5 [#1]
Modules linked in: omap_audio
CPU: 0
PC is at snd_pcm_oss_open+0x338/0x52c
LR is at 0xc39afe14
pc : [<c01808f8>]    lr : [<c39afe14>]    Not tainted
sp : c39afdb4  ip : c008fbcc  fp : c39afe60
r10: c039c4a0  r9 : 00000004  r8 : 0000000d
r7 : c001fc00  r6 : c3dcc980  r5 : c39afe04  r4 : c008fb0c
r3 : 00000000  r2 : 00000000  r1 : e5963014  r0 : 00000000
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  Segment user
Control: 5317F
Table: 13E78000  DAC: 00000015
Process cat (pid: 218, stack limit = 0xc39ae250)
Stack: (0xc39afdb4 to 0xc39b0000)
fda0:                                              c001fce8 00000001 00000004
fdc0: c001fd18 c001fd24 c39ae000 00000001 c38ec198 c008fb0c 00000000 00000000
fde0: c03a2040 c003a8e8 c001fd24 c001fd24 00000000 00000000 00000000 00000000
fe00: 00000000 00000000 00000000 00000000 00000000 00000000 00746163 00726500
fe20: 00000000 00000000 c39afe00 c39afe38 c00892e8 c010cb0c c39ae000 c0267ff0
fe40: 00000003 00000000 00000003 c039c4a0 c0268df0 c39afe90 c39afe64 c0163954
fe60: c01805d0 c38ec198 c39ae000 c3d64a20 c38ec198 00000000 00000001 c39ae000
fe80: c039c4a0 c39afebc c39afe94 c00895cc c016372c 00000004 c00893e8 c039c4a0
fea0: c38ec198 c03542a0 c38f7724 00000001 c39afee4 c39afec0 c0084f50 c00893f8
fec0: c039c4a0 c39aff04 00000003 ffffff9c c0023fe4 c0397000 c39afefc c39afee8
fee0: c00850d8 c0084e1c 00000000 00000000 c39aff68 c39aff00 c0085130 c00850b4
ff00: c39aff04 c38f7724 c03542a0 00000000 00000000 c3e78000 00000101 00000001
ff20: 00000000 c0368a48 c0368a40 ffffffe8 c39ae000 c0397000 c39aff68 c39aff48
ff40: c00852f4 c009d9c0 00000001 00000000 c039c4a0 00000000 000001b6 c39aff94
ff60: c39aff6c c00854f0 c00850fc 000081e4 bed18f95 000e72a0 000cac34 00000005
ff80: c0023fe4 00000000 c39affa4 c39aff98 c00855a4 c00854ac 00000000 c39affa8
ffa0: c0023e40 c0085590 bed18f95 000e72a0 bed18f95 00000000 000001b6 00000000
ffc0: bed18f95 000e72a0 000cac34 00000008 000080c0 000081e4 00000000 bed18e64
ffe0: 00000001 bed18e1c 0004de1c 000704d4 20000010 bed18f95 00000000 00000000
Backtrace:
[<c01805c0>] (snd_pcm_oss_open+0x0/0x52c) from [<c0163954>]
(soundcore_open+0x238/0x3ec)
[<c016371c>] (soundcore_open+0x0/0x3ec) from [<c00895cc>]
(chrdev_open+0x1e4/0x208)
[<c00893e8>] (chrdev_open+0x0/0x208) from [<c0084f50>]
(__dentry_open+0x144/0x298)
[<c0084e0c>] (__dentry_open+0x0/0x298) from [<c00850d8>]
(nameidata_to_filp+0x34/0x48)
[<c00850a4>] (nameidata_to_filp+0x0/0x48) from [<c0085130>]
(do_filp_open+0x44/0x4c)
 r4 = 00000000
[<c00850ec>] (do_filp_open+0x0/0x4c) from [<c00854f0>] (do_sys_open+0x54/0xe4)
 r5 = 000001B6  r4 = 00000000
[<c008549c>] (do_sys_open+0x0/0xe4) from [<c00855a4>] (sys_open+0x24/0x28)
[<c0085580>] (sys_open+0x0/0x28) from [<c0023e40>] (ret_fast_syscall+0x0/0x2c)
Code: e59430a4 e3c33b02 e58430a4 e5941070 (e5d1321c)
 Segmentation fault
