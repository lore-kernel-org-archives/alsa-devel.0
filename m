From: "Nori, Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: RE: [alsa-devel] [PATCH 2/3] ASoC: DaVinci: pcm, rename variables
 in prep for ping/pong
Date: Wed, 9 Sep 2009 17:38:42 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301DD74F519@dbde02.ent.ti.com>
References: <1251761505-11353-1-git-send-email-troy.kisky@boundarydevices.com>
	<1251761505-11353-2-git-send-email-troy.kisky@boundarydevices.com>
	<20090902220152.GB4495@sirena.org.uk>
	<4A9F0A8C.1040509@boundarydevices.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301DD6102A3@dbde02.ent.ti.com>
	<4AA0113D.9030605@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <4AA0113D.9030605-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Troy Kisky <troy.kisky-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org>
Cc: "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 04, 2009 at 00:25:57, Troy Kisky wrote:
> Nori, Sekhar wrote:
> > On Thu, Sep 03, 2009 at 05:45:08, Troy Kisky wrote:
> >> Mark Brown wrote:
> >>> On Mon, Aug 31, 2009 at 04:31:44PM -0700, Troy Kisky wrote:
> > [...]
> >>> I'll probably also apply the first patch since nobody else seems to c=
are
> >>> one way or another, but I would urge you to look at changing the defa=
ult
> >>> for the platform data to at most select the workaround only on CPUs t=
hat
> >>> have problems with channel swapping - it's going to cause confusion f=
or
> >>> people to have it on by default.
> >>>
> >> I think the ones without a problem use davinci-mcasp instead of davinc=
i-i2s
> >> but share davinci-pcm. So, I don't know of any machines to exclude in =
davinci-i2s.
> >> But if someone else knows, speak up.
> >>

[...]

>
> >
> > Using EDMA acount=3D4 instead of 2 (32-bit transfers) did fix that issu=
e on the
> > OSS drivers but I don't recall the problem morphing into an "always cha=
nnel
> > swapped" case.
> >
> > Have you tested your patch (1/3) with DM644x EVM? If not, we can do tha=
t and
> > see if it leads to channels being always swapped on that hardware as we=
ll.
>
> Yes, I have tested with dm644x, not evm. I haven't tried to hear the chan=
nel swap,
> but I have no doubt that it is.

I finally got around to testing your patch 1/3 on DM6446 EVM.

Without your patch, channel swap is quite easy to reproduce using audio
loopback:

arecord -fcd | aplay -fcd

The audio source is a PC which speaker balance set to an extreme.
By starting and stopping this command repeatedly, you can see the audio
moving from one channel to the other.

Applying your patch fixes this issue.

Also, I did not notice any permanent channel swap. Used aplay to play data
which was first left-only and then right-only. Plays the same way on a Linu=
x PC.

I will test on couple of other platform using davinci-i2s (DM355 etc) befor=
e
acking the patch.

However, with or without your patch, I noticed a segmentation fault for the
first time the 'arecord | aplay' loop is created. There is no fault the sec=
ond
time around. I haven't spent time debugging this yet.

root@arago:~# arecord -fcd | aplay -fcd
Recording WAVE 'stdin' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
Division by zero in kernel.
Backtrace:
[<c002b784>] (dump_backtrace+0x0/0x114) from [<c0248cf0>] (dump_stack+0x18/=
0x1c)
 r7:86a60000 r6:c77cdae0 r5:00000040 r4:00000000
[<c0248cd8>] (dump_stack+0x0/0x1c) from [<c002b8cc>] (__div0+0x18/0x20)
[<c002b8b4>] (__div0+0x0/0x20) from [<c014b0fc>] (Ldiv0+0x8/0x10)
[<c01bad64>] (davinci_pcm_enqueue_dma+0x0/0x110) from [<c01baea0>] (davinci=
_pcm_
prepare+0x2c/0x58)
[<c01bae74>] (davinci_pcm_prepare+0x0/0x58) from [<c01b5260>] (soc_pcm_prep=
are+0
x84/0x184)
 r7:c030df38 r6:c030d1b8 r5:c70d3900 r4:00000000
[<c01b51dc>] (soc_pcm_prepare+0x0/0x184) from [<c01aac3c>] (snd_pcm_do_prep=
are+0
x1c/0x34)
[<c01aac20>] (snd_pcm_do_prepare+0x0/0x34) from [<c01aa87c>] (snd_pcm_actio=
n_sin
gle+0x40/0x7c)
 r5:c70d3900 r4:c030cbc8
[<c01aa83c>] (snd_pcm_action_single+0x0/0x7c) from [<c01abd80>] (snd_pcm_ac=
tion_
nonatomic+0x58/0x70)
 r7:c70d3900 r6:00000002 r5:c030cbc8 r4:c70d3900
[<c01abd28>] (snd_pcm_action_nonatomic+0x0/0x70) from [<c01ae2cc>] (snd_pcm=
_comm
on_ioctl1+0x814/0x1308)
 r7:c70d3900 r6:0002a690 r5:0002a690 r4:c77b6c80
[<c01adab8>] (snd_pcm_common_ioctl1+0x0/0x1308) from [<c01af20c>] (snd_pcm_=
captu
re_ioctl1+0x44c/0x470)
[<c01aedc0>] (snd_pcm_capture_ioctl1+0x0/0x470) from [<c01af268>] (snd_pcm_=
captu
re_ioctl+0x38/0x3c)
 r7:c77b6c80 r6:00004140 r5:0002a690 r4:c77b6c80
[<c01af230>] (snd_pcm_capture_ioctl+0x0/0x3c) from [<c00a2680>] (vfs_ioctl+=
0x34/
0x94)
[<c00a264c>] (vfs_ioctl+0x0/0x94) from [<c00a2d44>] (do_vfs_ioctl+0x56c/0x5=
c8)
 r7:c77b6c80 r6:00000004 r5:c77b6c80 r4:c6b8c8a8
[<c00a27d8>] (do_vfs_ioctl+0x0/0x5c8) from [<c00a2de0>] (sys_ioctl+0x40/0x6=
4)
[<c00a2da0>] (sys_ioctl+0x0/0x64) from [<c0027ea0>] (ret_fast_syscall+0x0/0=
x2c)
 r7:00000036 r6:bec987d8 r5:0002a468 r4:000b567f
Division by zero in kernel.
Backtrace:
[<c002b784>] (dump_backtrace+0x0/0x114) from [<c0248cf0>] (dump_stack+0x18/=
0x1c)
 r7:86a62000 r6:c77cdae0 r5:00000040 r4:00000000
[<c0248cd8>] (dump_stack+0x0/0x1c) from [<c002b8cc>] (__div0+0x18/0x20)
[<c002b8b4>] (__div0+0x0/0x20) from [<c014b0fc>] (Ldiv0+0x8/0x10)
[<c01bad64>] (davinci_pcm_enqueue_dma+0x0/0x110) from [<c01baec0>] (davinci=
_pcm_
prepare+0x4c/0x58)
[<c01bae74>] (davinci_pcm_prepare+0x0/0x58) from [<c01b5260>] (soc_pcm_prep=
are+0
x84/0x184)
 r7:c030df38 r6:c030d1b8 r5:c70d3900 r4:00000000
[<c01b51dc>] (soc_pcm_prepare+0x0/0x184) from [<c01aac3c>] (snd_pcm_do_prep=
are+0
x1c/0x34)
[<c01aac20>] (snd_pcm_do_prepare+0x0/0x34) from [<c01aa87c>] (snd_pcm_actio=
n_sin
gle+0x40/0x7c)
 r5:c70d3900 r4:c030cbc8
[<c01aa83c>] (snd_pcm_action_single+0x0/0x7c) from [<c01abd80>] (snd_pcm_ac=
tion_
nonatomic+0x58/0x70)
 r7:c70d3900 r6:00000002 r5:c030cbc8 r4:c70d3900
[<c01abd28>] (snd_pcm_action_nonatomic+0x0/0x70) from [<c01ae2cc>] (snd_pcm=
_comm
on_ioctl1+0x814/0x1308)
 r7:c70d3900 r6:0002a690 r5:0002a690 r4:c77b6c80
[<c01adab8>] (snd_pcm_common_ioctl1+0x0/0x1308) from [<c01af20c>] (snd_pcm_=
captu
re_ioctl1+0x44c/0x470)
[<c01aedc0>] (snd_pcm_capture_ioctl1+0x0/0x470) from [<c01af268>] (snd_pcm_=
captu
re_ioctl+0x38/0x3c)
 r7:c77b6c80 r6:00004140 r5:0002a690 r4:c77b6c80
[<c01af230>] (snd_pcm_capture_ioctl+0x0/0x3c) from [<c00a2680>] (vfs_ioctl+=
0x34/
0x94)
[<c00a264c>] (vfs_ioctl+0x0/0x94) from [<c00a2d44>] (do_vfs_ioctl+0x56c/0x5=
c8)
 r7:c77b6c80 r6:00000004 r5:c77b6c80 r4:c6b8c8a8
[<c00a27d8>] (do_vfs_ioctl+0x0/0x5c8) from [<c00a2de0>] (sys_ioctl+0x40/0x6=
4)
[<c00a2da0>] (sys_ioctl+0x0/0x64) from [<c0027ea0>] (ret_fast_syscall+0x0/0=
x2c)
 r7:00000036 r6:bec987d8 r5:0002a468 r4:000b567f
Division by zero in kernel.
Playing WAVE 'stBacktrace: din' : Signed 16
 bit Little Endi[<c002b784>] an, Rate 44100 H(dump_backtrace+0x0/0x114) z, =
Stere
o
from [<c0248cf0>] (dump_stack+0x18/0x1c)
 r7:86a64000 r6:c77cdae0 r5:00000040 r4:00000000
[<c0248cd8>] (dump_stack+0x0/0x1c) from [<c002b8cc>] (__div0+0x18/0x20)
[<c002b8b4>] (__div0+0x0/0x20) from [<c014b0fc>] (Ldiv0+0x8/0x10)
[<c01bad64>] (davinci_pcm_enqueue_dma+0x0/0x110) from [<c01bb0bc>] (davinci=
_pcm_
dma_irq+0x58/0x80)
[<c01bb064>] (davinci_pcm_dma_irq+0x0/0x80) from [<c0031904>] (dma_irq_hand=
ler+0
xec/0x12c)
 r5:00000003 r4:00000004
[<c0031818>] (dma_irq_handler+0x0/0x12c) from [<c0068ee8>] (handle_IRQ_even=
t+0x4
4/0x114)
[<c0068ea4>] (handle_IRQ_event+0x0/0x114) from [<c006ab74>] (handle_edge_ir=
q+0x1
48/0x1b4)
 r7:c7007440 r6:00000010 r5:c02ff060 r4:c6baa000
[<c006aa2c>] (handle_edge_irq+0x0/0x1b4) from [<c0027070>] (_text+0x70/0x8c=
)
 r7:00000002 r6:00000800 r5:00000000 r4:00000010
[<c0027000>] (_text+0x0/0x8c) from [<c0027aac>] (__irq_svc+0x4c/0x90)
Exception stack(0xc6babdf0 to 0xc6babe38)
bde0:                                     00000001 00000000 c6baa000 400000=
13
be00: 00000800 c76f2800 00000800 c70d3900 00000000 00000800 00000000 c6babe=
8c
be20: c6baa000 c6babe38 c01b16f4 c01b1714 40000013 ffffffff
 r5:fec48000 r4:ffffffff
[<c01b1548>] (snd_pcm_lib_read1+0x0/0x30c) from [<c01b1934>] (snd_pcm_lib_r=
ead+0
x60/0x6c)
[<c01b18d4>] (snd_pcm_lib_read+0x0/0x6c) from [<c01aee8c>] (snd_pcm_capture=
_ioct
l1+0xcc/0x470)
 r6:bec98ab4 r5:bec98ab4 r4:00000000
[<c01aedc0>] (snd_pcm_capture_ioctl1+0x0/0x470) from [<c01af268>] (snd_pcm_=
captu
re_ioctl+0x38/0x3c)
 r7:c77b6c80 r6:800c4151 r5:bec98ab4 r4:c77b6c80
[<c01af230>] (snd_pcm_capture_ioctl+0x0/0x3c) from [<c00a2680>] (vfs_ioctl+=
0x34/
0x94)
[<c00a264c>] (vfs_ioctl+0x0/0x94) from [<c00a2d44>] (do_vfs_ioctl+0x56c/0x5=
c8)
 r7:c77b6c80 r6:00000004 r5:c77b6c80 r4:c6b8c8a8
[<c00a27d8>] (do_vfs_ioctl+0x0/0x5c8) from [<c00a2de0>] (sys_ioctl+0x40/0x6=
4)
[<c00a2da0>] (sys_ioctl+0x0/0x64) from [<c0027ea0>] (ret_fast_syscall+0x0/0=
x2c)
 r7:00000036 r6:00000000 r5:0002a4b8 r4:0002a468
arecord: pcm_read:1529: read error: Input/output error
root@arago:~#

Thanks,
Sekhar

>
> >
> > One feedback we have received on this solution is that it does not work=
 for
> > 24-bit audio. In which case, implementing the workaround described in t=
he
> > errata is the only way around.
>
> Yes, you cannot shift more than 32 bits at once, so 48 bits is out.
> Although 24 bit format would be easy to add, currently only 8, 16, and 32
> are supported by davinci-i2s.
>
> >
> > Thanks,
> > Sekhar
> >
> >
>
>
>
