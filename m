From: Chow Raymond <usher_raymond82@yahoo.com>
Subject: Re: Compulab sound device
Date: Wed, 24 Aug 2005 03:32:51 -0700 (PDT)
Message-ID: <20050824103251.32939.qmail@web54604.mail.yahoo.com>
References: <s5hoe7p583k.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hoe7p583k.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>, Lee Revell <rlrevell@joe-job.com>
Cc: Chow Raymond <usher_raymond82@yahoo.com>, Liam Girdwood <liam.girdwood@wolfsonmicro.com>, Clemens Ladisch <clemens@ladisch.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

The problem that I encountered.

MODPOST
*** Warning: "dma_mmap_writecombine"
[sound/arm/snd-pxa2xx-pcm.ko] undefined!
*** Warning: "pxa_set_cken"
[sound/arm/snd-pxa2xx-ac97.ko] undefined!
*** Warning: "snd_ac97_get_short_name"
[sound/arm/snd-pxa2xx-ac97.ko] undefined!

Currently im tackling the warning for
dma_mmap_writecombine. I realised that the above
warning message is due to dma_mmap_writecombine symbol
is not exported. Found out it is true when i edit
arch/arm/mm/consistent.c. There is no
dma_mmap_writecombine function. Found out that struct
dma_mmap is not defined too. Thus, I back port that
particular file based on kernel 2.6.12. I do not face
the above warning after make modules. However, when i
try to insmod, i've encounter this.

Unable to handle kernel NULL pointer dereference at
virtual address 00000000
[00000000] *pgd=3Da34f3011, *pte=3D00000000,
*ppte=3D00000000
Internal error: Oops: 0 [#1]
Modules linked in: snd_pxa2xx_pcm snd_ac97_codec
snd_pcm_oss snd_mixer_oss snd_e
CPU: 0
PC is at 0x0
LR is at sys_init_module+0x1a4/0x308
pc : [<00000000>]    lr : [<c0051e34>]    Not tainted
sp : c35d3f88  ip : 60000013  fp : c35d3fa4
r10: befffe47  r9 : c35d2000  r8 : c0026364
r7 : 00000000  r6 : c022123c  r5 : bf0540a0  r4 :
c0221254
r3 : 60000013  r2 : bf0540a0  r1 : 00000001  r0 :
00000000
Flags: nzcv  IRQs on  FIQs on  Mode SVC_32  Segment
user
Control: 397F  Table: A3470000  DAC: 00000015
Process insmod (pid: 517, stack limit =3D 0xc35d20fc)
Stack: (0xc35d3f88 to 0xc35d4000)
3f80:                   0000909c 00000002 befffd54
00000080 00000000 c35d3fa8
3fa0: c00261e0 c0051c9c 0000909c c002e3d8 40137008
00027f9b 00012008 00027f9b
3fc0: 0000909c 00000002 befffd54 00012008 00000002
00009210 befffe47 befffd30
3fe0: 400e9010 befffcf8 00008fec 400e901c 60000010
40137008 00000000 00000000
Backtrace:
[<c0051c90>] (sys_init_module+0x0/0x308) from
[<c00261e0>] (ret_fast_syscall+0x)
 r7 =3D 00000080  r6 =3D BEFFFD54  r5 =3D 00000002  r4 =3D
0000909C
Code: bad PC value.a
Segmentation fault


Segmentation fault? I just added a structure and a
function and i do not expect a segmentation fault.
Therefore i would like to know,

1) What does remap_pfn_range function does?=20
2) How does remap_pfn_range different compare to
remap_page_range?=20

I suspect is due to those functions. Hope you guys can
tell me. Thanks in advance.

Regards,
Raymond

--- Takashi Iwai <tiwai@suse.de> wrote:

> At Mon, 22 Aug 2005 23:57:26 -0400,
> Lee Revell wrote:
> >=20
> > On Mon, 2005-08-22 at 00:06 -0700, Chow Raymond
> wrote:
> > > I also wish to port from 2.6.7 to 2.6.12.
> However,
> > > Compulab only supports till 2.6.7. I can't build
> > > 2.6.12 kernel to run on Compulab's board.=20
> >=20
> > Do you mean the vendor won't provide support for
> anything but 2.6.7, or
> > that 2.6.12 literally will not run on the board?
> >=20
> > If it's the former then ask your support rep how
> to get a new ALSA to
> > work with it.  If it's the latter then report the
> bug to the kernel
> > people.
>=20
> IIRC, some of the core part regarding DMA on ARM was
> added recently,
> which is used by pxa2xx driver.  You can backport
> that code, though.
>=20
>=20
> Takashi
>=20



	=09
____________________________________________________
Start your day with Yahoo! - make it your home page=20
http://www.yahoo.com/r/hs=20
=20


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practic=
es
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & Q=
A
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
