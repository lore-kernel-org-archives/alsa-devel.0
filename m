From: James Pearson <james-p@moving-picture.com>
Subject: Re: Problems with 32 bit apps on 64 bit OS using dmix
 and snd-ioctl32
Date: Wed, 05 Sep 2007 17:54:35 +0100
Message-ID: <46DEDF4B.7050108@moving-picture.com>
References: <46DE8EB0.90208@moving-picture.com>
	<s5hd4wx8ec0.wl%tiwai@suse.de>	<46DEBF69.6070307@moving-picture.com>	<s5hodgh6sqf.wl%tiwai@suse.de>	<46DECCEA.4060306@moving-picture.com>
	<s5hk5r56qin.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moving-picture.com (mpc-26.sohonet.co.uk [193.203.82.251])
	by alsa0.perex.cz (Postfix) with ESMTP id A57D810383B
	for <alsa-devel@alsa-project.org>;
	Wed,  5 Sep 2007 18:54:35 +0200 (CEST)
In-Reply-To: <s5hk5r56qin.wl%tiwai@suse.de>
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

Takashi Iwai wrote:
>>
>>OK, I'll do a bit more poking about to see if I can get 1.0.15rc1 to 
>>build ...
>>
>>Thanks
>>
>>James Pearson
>>
>>Configure output:
>>
>># ./configure --with-redhat=yes
> 
> 
> The output looks OK to me.
> Does the patch (to alsa-driver tree) fix the problem?
> 
> 
> Takashi
> 
> diff -r adfe4179d670 misc/ac97_bus.c
> --- a/misc/ac97_bus.c	Fri Aug 31 12:22:35 2007 +0200
> +++ b/misc/ac97_bus.c	Wed Sep 05 18:09:42 2007 +0200
> @@ -1,1 +1,3 @@
> +#include <sound/driver.h>
> +#include <sound/core.h>
>  #include "../alsa-kernel/ac97_bus.c"

Yes ... I did something similar - copied in ../alsa-kernel/ac97_bus.c 
and patched with alsa-driver-1.0.13/pci/ac97/ac97_bus.patch - which 
makes it compile - it bombs out later on some of the soc/ code - but as 
nothing similar exists in 1.0.13, I just skipped that with 'make -i' ...

However, with these 1.0.15rc1 modules installed, and using 
alsa-lib-1.0.15rc1, I get exactly the same problem with 32 bit apps:

Playing WAVE 'test.wav' : Signed 16 bit Little Endian, Rate 48000 Hz, Mono
aplay: pcm_write:1268: write error: Invalid argument

amd dmesg has:

ioctl32(aplay:6228): Unknown cmd fd(3) cmd(40045402){00} arg(ffffac98) 
on /dev/snd/timer
ioctl32(aplay:6228): Unknown cmd fd(5) cmd(c008551a){00} arg(0806ccd0) 
on /dev/snd/controlC0
ioctl32(aplay:6228): Unknown cmd fd(5) cmd(c008551b){00} arg(0806ccd0) 
on /dev/snd/controlC0
ioctl32(aplay:6228): Unknown cmd fd(3) cmd(000054a0){00} arg(00000325) 
on /dev/snd/timer

James Pearson
