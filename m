From: Jan Engelhardt <jengelh@medozas.de>
Subject: Re: No mixers on ATI RS780 Azalia
Date: Mon, 7 Jun 2010 14:49:16 +0200 (CEST)
Message-ID: <alpine.LSU.2.01.1006071404210.11780@obet.zrqbmnf.qr>
References: <alpine.LSU.2.01.1005261303170.19406@obet.zrqbmnf.qr>
	<s5hmxvmzwwd.wl%tiwai@suse.de>
	<alpine.LSU.2.01.1005261413040.23865@obet.zrqbmnf.qr>
	<4BFD2901.20800@ladisch.de>
	<alpine.LSU.2.01.1005271230340.18087@obet.zrqbmnf.qr>
	<4BFE5AA1.7070103@ladisch.de> <4BFE66CA.5070400@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from borg.medozas.de (borg.medozas.de [188.40.89.202])
	by alsa0.perex.cz (Postfix) with ESMTP id EF8D71037F7
	for <alsa-devel@alsa-project.org>;
	Mon,  7 Jun 2010 14:49:17 +0200 (CEST)
In-Reply-To: <4BFE66CA.5070400@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Takashi Iwai <tiwai@suse.de>, Dave Airlie <airlied@redhat.com>, alsa-devel@alsa-project.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org
List-Id: alsa-devel@alsa-project.org

On Thursday 2010-05-27 14:34, Clemens Ladisch wrote:
>Clemens Ladisch wrote:
>> Please do not assume that the "HDMI" device is the right one, since you
>> never got either one to work in Linux.
>
>Hmm, that computer is separate from the actual LCD, which has an HDMI
>input, so it's possible that the HDMI output would be correct.
>
>In that case, it's likely that you've run into this bug:
>https://bugs.freedesktop.org/show_bug.cgi?id=28030
>
>You might try the patch mentioned there, or radeonhd, or fglrx.

Cc'ing drm.

I conclude further tests.

* Linux 2.6.35-rc2
- fbcon:radeondrmfb using "modprobe radeon modeset=1"
  - sound ok
- Xorg (7.4) with 'radeonhd'
  - fbcon ok, no sound in Xorg - I figure radeonhd is obsolete
- Xorg with 'radeon'
  - fbcon ok, xorg ok.
    There is a small breakdown when switching between fbcon and xorg

* Linux 2.6.33.5
- like 2.6.35-rc2, but had a bug that prevented radeon.ko to go into 
  graphics mode when initially loaded; workaround: modprobe fglrx;
  rmmod fglrx; modprobe radeon modeset=1
- or fglrx, also makes sound work

- fglrx bug aside: switching from Xorg to console (either 80x25 or
  radeondrmfb) makes a fugly "pop" noise, and if the target is
  radeomdrmfb, display is garbled.


So I'm happy.
Conclusive questions however:

* Why is it that I am only allowed to have sound in graphics mode?

* The radeon.ko module does not have any PCI IDs defined, thus does not 
get autoloaded like i915.ko. Is this intentional? It also seems
to default to modeset=0.
