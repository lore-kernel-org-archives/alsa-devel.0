From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Aureal issues on resume
Date: Sat, 3 Sep 2011 07:41:10 +0800
Message-ID: <CAN8cciaL8O_wyESQSeYOr=bvmg=0vjBj0Cw0y09q2eQygs9ODQ@mail.gmail.com>
References: <4E60F0C1.5020008@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id B6F67243E8
	for <alsa-devel@alsa-project.org>;
	Sat,  3 Sep 2011 01:41:21 +0200 (CEST)
Received: by fxh10 with SMTP id 10so2145534fxh.38
	for <alsa-devel@alsa-project.org>; Fri, 02 Sep 2011 16:41:19 -0700 (PDT)
In-Reply-To: <4E60F0C1.5020008@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

2011/9/2 Clemens Ladisch <clemens@ladisch.de>:
> (added recipients)
>
> -------- Original Message --------
> Subject: Aureal issues on resume
> Date: Fri, 02 Sep 2011 13:41:42 +0200
> From: Anders Eriksson <aeriksson@fastmail.fm>
> To: linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org
>
>
> Hi, upon resuming from hibernation, I see this in my log:
>
> Sep =A02 11:15:20 tippex kernel: [72436.287020] vortex_adb_addroutes: une=
nding route! 0x10
> Sep =A02 11:15:20 tippex kernel: [72436.287127] vortex_adb_addroutes: une=
nding route! 0x838
> Sep =A02 11:15:20 tippex kernel: [72436.287277] vortex_adb_addroutes: une=
nding route! 0x11
> Sep =A02 11:15:20 tippex kernel: [72436.287418] vortex_adb_addroutes: une=
nding route! 0x8b9
> Sep =A02 11:15:20 tippex kernel: [72436.292037] Vortex: vortex_fifo_setad=
bctrl fail
> Sep =A02 11:15:55 tippex kernel: [72471.403490] vortex_adb_delroutes: rou=
te not found! 0x10
> Sep =A02 11:15:55 tippex kernel: [72471.403596] vortex_adb_delroutes: rou=
te not found! 0x838
> Sep =A02 11:15:55 tippex kernel: [72471.403710] vortex_adb_delroutes: rou=
te not found! 0x11
> Sep =A02 11:15:55 tippex kernel: [72471.403811] vortex_adb_delroutes: rou=
te not found! 0x8b9
>
> And the sound is no more. I need to reboot to get it back.
>
> If memory serves, it's been there since 2.6.30 or so. Any ideas what can =
be
> triggering it?
>
> lspci says it's an
> 00:04.0 Multimedia audio controller: Aureal Semiconductor Vortex 1 (rev 0=
2)
> =A0 =A0 =A0 =A0Subsystem: Diamond Multimedia Systems Sonic Impact A3D
> =A0 =A0 =A0 =A0Flags: bus master, medium devsel, latency 64, IRQ 11
> =A0 =A0 =A0 =A0Memory at 50000000 (32-bit, non-prefetchable) [size=3D128K]
> =A0 =A0 =A0 =A0I/O ports at 10b0 [size=3D8]
> =A0 =A0 =A0 =A0I/O ports at 10b8 [size=3D8]
> =A0 =A0 =A0 =A0Capabilities: [dc] Power Management version 1
> =A0 =A0 =A0 =A0Kernel driver in use: snd_au8820
> =A0 =A0 =A0 =A0Kernel modules: snd-au8820
>
>
> -Anders
>

Those alsa au88x0 drivers does not support suspend/resume

As each audio stream is assigned different resources (e.g. SRC, mixer
, ...) dynamically and the cards can play 16 mono streams or 8 stereo
streams.

The possible way is to save the contents of 128K memory mapped I/O
ports before suspend to non-volatile memory and restore them after
resume

Is there any way for alsa driver to allocate non-volatile memory ?
au8830 has 256 K mmio
