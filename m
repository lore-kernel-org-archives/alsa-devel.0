From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Request for test (1.0.18 final)
Date: Wed, 29 Oct 2008 09:48:55 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0810290945200.12044@tm8103.perex-int.cz>
References: <Pine.LNX.4.61.0810271449320.12044@tm8103.perex-int.cz>
	<200810272041.10885.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 1A8C224330
	for <alsa-devel@alsa-project.org>; Wed, 29 Oct 2008 09:48:57 +0100 (CET)
In-Reply-To: <200810272041.10885.gineera@aspect135.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alan Horstmann <gineera@aspect135.co.uk>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 27 Oct 2008, Alan Horstmann wrote:

> On Monday 27 October 2008 13:54, Jaroslav Kysela wrote:
> > Hello,
> >
> > 	I would like to release 1.0.18 final packages (driver, lib,
> > utils, tools, plugins) in few days. Please, report compilation trouble
> > with the current ALSA code.
> >
> > 			Thank you for testing,
> > 						Jaroslav
> 
> Here on the 2.4.21-99-Suse, make results in:

We do not support officially kernels bellow 2.4.31 (see 
SUPPORTED_KERNELS).

> ../../alsa-kernel/pci/ice1712/ice1712.c:50:22: linux/io.h: No such file or 
> directory
> 
> presumably caused as it is <asm/io.h> here?

It should be handled in configure.in:

CHECK_KERNEL_HEADER(linux/io.h, [#include <asm/io.h>
])

Not sure why linux/io.h in alsa-driver/include/linux/ directory is not 
created for your kernel. You may investigate this yourself if you like.

> I added temp symbolic link & continued to:
> 
> patching file maestro3.c
> Hunk #2 succeeded at 2596 (offset 4 lines).
> Hunk #3 succeeded at 2777 (offset 4 lines).
> gcc -D__KERNEL__ -DMODULE=1 -I/home/alan/Vault/Alsa/1.0.18/
> alsa-driver-1.0.18rc3.20.gcbea1.192.g2973f/include  -I/lib/
> modules/2.4.21-99-athlon/build/include -O2 -mpreferred-stack-boundary=2 
> -march=athlon -DLINUX -Wall -Wstrict-prototypes -fomit-frame-pointer 
> -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -DALSA_BUILD 
> -nostdinc -iwithprefix include -DMODVERSIONS -include /lib/
> modules/2.4.21-99-athlon/build/include/linux/modversions.h  
> -DKBUILD_BASENAME=maestro3   -c -o maestro3.o maestro3.c
> maestro3.c: In function `snd_m3_create':

....

> maestro3.c:2612: error: structure has no member named `dev'

I fixed this one (it's reproducible with 2.4.31 kernel, too).

						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
