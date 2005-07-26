From: Andrew Haninger <ahaning@gmail.com>
Subject: Re: BUG: Yamaha OPL3SA2 does not work with ALSA on 2.6 kernels.
Date: Tue, 26 Jul 2005 01:37:37 -0400
Message-ID: <105c793f050725223733964f55@mail.gmail.com>
References: <105c793f05072507315cfd1878@mail.gmail.com>
	 <20050725232604.GH3160@stusta.de>
Reply-To: Andrew Haninger <ahaning@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from rproxy.gmail.com (rproxy.gmail.com [64.233.170.193])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 43070192
	for <alsa-devel@alsa-project.org>; Tue, 26 Jul 2005 07:37:38 +0200 (MEST)
Received: by rproxy.gmail.com with SMTP id z35so589543rne
        for <alsa-devel@alsa-project.org>; Mon, 25 Jul 2005 22:37:37 -0700 (PDT)
In-Reply-To: <20050725232604.GH3160@stusta.de>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Adrian Bunk <bunk@stusta.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, perex@suse.cz, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 7/25/05, Adrian Bunk <bunk@stusta.de> wrote:
> Does the OSS driver work in 2.6?
I was able to get the OSS module (opl3sa2) installed in 2.6 and I was
able to get some nice hiss when doing 'cat /dev/urandom > /dev/dsp'. I
used the following modprobe line:

modprobe opl3sa2 io=3D0x370 irq=3D11 dma=3D0 dma2=3D1 mss_io=3D0x530 isapnp=
=3D0

the isapnp=3D0 part appeared to be required. The following showed up in
dmesg upon inserting the OSS module:

opl3sa2: Chipset version =3D 0x7
opl3sa2: Found OPL3-SA3 (YMF715E or YMF719E)

However, when I try to rmmod the opl3sa2 module, I get an Oops:

Unable to handle kernel NULL pointer dereference at virtual address 0000000=
0
 printing eip:
c037ae01
*pde =3D 00000000
Oops: 0002 [#1]
PREEMPT
Modules linked in: opl3sa2 ad1848 mpu401 sound soundcore vfat fat
sd_mod usb_storage lp parport ide_scsi rtc
CPU:    0
EIP:    0060:[<c037ae01>]    Not tainted VLI
EFLAGS: 00010046   (2.6.12.2)
EIP is at wait_for_completion+0x71/0xf0
eax: cca91180   ebx: c52ea000   ecx: c52ebf20   edx: 00000000
esi: c52ea000   edi: cca9117c   ebp: c52ebf40   esp: c52ebef4
ds: 007b   es: 007b   ss: 0068
Process rmmod (pid: 11277, threadinfo=3Dc52ea000 task=3Dc79ce550)
Stack: 00000000 c79ce550 c0113cf0 00000000 00000000 c52ea000 c0e899e0 c0209=
ffe
       00000001 c79ce550 c0113cf0 cca91180 00000114 00000001 00000000 cca91=
174
       00000114 00000001 00000000 c52ea000 cca8f964 cca91174 00000000 cca91=
200
Call Trace:
 [<c0113cf0>] default_wake_function+0x0/0x20
 [<c0209ffe>] kobject_put+0x1e/0x30
 [<c0113cf0>] default_wake_function+0x0/0x20
 [<cca8f964>] cleanup_opl3sa2+0x74/0x8c [opl3sa2]
 [<c0131bc8>] sys_delete_module+0x178/0x1b0
 [<c015b2c0>] sys_munmap+0x50/0x80
 [<c0103205>] syscall_call+0x7/0xb
Code: 00 00 8b 03 c7 45 d4 01 00 00 00 c7 45 bc f0 3c 11 c0 c7 45 dc
f0 3c 11 c0 89 45 b8 89 45 d8 8d 47 04 8b 50 04 89 45 e0 89 48 04 <89>
0a 89 55 e4 8d 76 00 8d bc 27 00 00 00 00 8b 03 c7 00 02 00
 <6>note: rmmod[11277] exited with preempt_count 1

and now when I try to rmmod the module again, I get:

ERROR: Removing 'opl3sa2': Device or resource busy

So, yes, given the correct parameters, the OSS module (just like the
ALSA module) works with the occasional Oops. I guess the Oopses are
acceptable for now; it's the ALSA detection routines that are broken
themselves or that are broken by something in the 2.6 kernel (remember
that they work fine in 2.4).

Thanks.

-Andy


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
