From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [alsa-devel] No mixers on ATI RS780 Azalia
Date: Mon, 7 Jun 2010 11:03:56 -0400
Message-ID: <AANLkTilqmEK7R26DmLg0_LZ4al4F0_bX4asCl1DVA6GH@mail.gmail.com>
References: <alpine.LSU.2.01.1005261303170.19406@obet.zrqbmnf.qr>
	<s5hmxvmzwwd.wl%tiwai@suse.de>
	<alpine.LSU.2.01.1005261413040.23865@obet.zrqbmnf.qr>
	<4BFD2901.20800@ladisch.de>
	<alpine.LSU.2.01.1005271230340.18087@obet.zrqbmnf.qr>
	<4BFE5AA1.7070103@ladisch.de>
	<4BFE66CA.5070400@ladisch.de>
	<alpine.LSU.2.01.1006071404210.11780@obet.zrqbmnf.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LSU.2.01.1006071404210.11780@obet.zrqbmnf.qr>
Sender: linux-kernel-owner@vger.kernel.org
To: Jan Engelhardt <jengelh@medozas.de>
Cc: Clemens Ladisch <clemens@ladisch.de>, Takashi Iwai <tiwai@suse.de>, Dave Airlie <airlied@redhat.com>, alsa-devel@alsa-project.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 7, 2010 at 8:49 AM, Jan Engelhardt <jengelh@medozas.de> wro=
te:
> On Thursday 2010-05-27 14:34, Clemens Ladisch wrote:
>>Clemens Ladisch wrote:
>>> Please do not assume that the "HDMI" device is the right one, since=
 you
>>> never got either one to work in Linux.
>>
>>Hmm, that computer is separate from the actual LCD, which has an HDMI
>>input, so it's possible that the HDMI output would be correct.
>>
>>In that case, it's likely that you've run into this bug:
>>https://bugs.freedesktop.org/show_bug.cgi?id=3D28030
>>
>>You might try the patch mentioned there, or radeonhd, or fglrx.
>
> Cc'ing drm.
>
> I conclude further tests.
>
> * Linux 2.6.35-rc2
> - fbcon:radeondrmfb using "modprobe radeon modeset=3D1"
> =A0- sound ok
> - Xorg (7.4) with 'radeonhd'
> =A0- fbcon ok, no sound in Xorg - I figure radeonhd is obsolete
> - Xorg with 'radeon'
> =A0- fbcon ok, xorg ok.
> =A0 =A0There is a small breakdown when switching between fbcon and xo=
rg
>
> * Linux 2.6.33.5
> - like 2.6.35-rc2, but had a bug that prevented radeon.ko to go into
> =A0graphics mode when initially loaded; workaround: modprobe fglrx;
> =A0rmmod fglrx; modprobe radeon modeset=3D1
> - or fglrx, also makes sound work
>
> - fglrx bug aside: switching from Xorg to console (either 80x25 or
> =A0radeondrmfb) makes a fugly "pop" noise, and if the target is
> =A0radeomdrmfb, display is garbled.
>
>
> So I'm happy.
> Conclusive questions however:
>
> * Why is it that I am only allowed to have sound in graphics mode?

HDMI audio is only enabled on active outputs during modeset.

>
> * The radeon.ko module does not have any PCI IDs defined, thus does n=
ot
> get autoloaded like i915.ko. Is this intentional? It also seems
> to default to modeset=3D0.

What kernel are you using?  It definitely has pci ids and autoloads jus=
t fine.

Alex
