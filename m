From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: Request for test (1.0.18 final) (2.4 Kernel report)
Date: Wed, 29 Oct 2008 13:25:30 +0000
Message-ID: <200810291325.30327.gineera@aspect135.co.uk>
References: <Pine.LNX.4.61.0810271449320.12044@tm8103.perex-int.cz>
	<200810272041.10885.gineera@aspect135.co.uk>
	<Pine.LNX.4.61.0810290945200.12044@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.talktalk.net (smtp-out-1.talktalk.net [62.24.128.231])
	by alsa0.perex.cz (Postfix) with ESMTP id 16E2F10383B
	for <alsa-devel@alsa-project.org>; Wed, 29 Oct 2008 14:09:33 +0100 (CET)
In-Reply-To: <Pine.LNX.4.61.0810290945200.12044@tm8103.perex-int.cz>
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
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Jaroslav, Takashi,

On Wednesday 29 October 2008 08:48, you wrote:
> On Mon, 27 Oct 2008, Alan Horstmann wrote:
> > Here on the 2.4.21-99-Suse, make results in:
>
> We do not support officially kernels bellow 2.4.31 (see
> SUPPORTED_KERNELS).
>
> > ../../alsa-kernel/pci/ice1712/ice1712.c:50:22: linux/io.h: No such file
> > or directory
> >
> > presumably caused as it is <asm/io.h> here?
>
> It should be handled in configure.in:
>
> CHECK_KERNEL_HEADER(linux/io.h, [#include <asm/io.h>
> ])
>
> Not sure why linux/io.h in alsa-driver/include/linux/ directory is not
> created for your kernel. You may investigate this yourself if you like.
>
> > I added temp symbolic link & continued to:
> >
> > patching file maestro3.c
> > Hunk #2 succeeded at 2596 (offset 4 lines).
> > Hunk #3 succeeded at 2777 (offset 4 lines).
> > gcc -D__KERNEL__ -DMODULE=1 -I/home/alan/Vault/Alsa/1.0.18/
> > alsa-driver-1.0.18rc3.20.gcbea1.192.g2973f/include  -I/lib/
> > modules/2.4.21-99-athlon/build/include -O2 -mpreferred-stack-boundary=2
> > -march=athlon -DLINUX -Wall -Wstrict-prototypes -fomit-frame-pointer
> > -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -DALSA_BUILD
> > -nostdinc -iwithprefix include -DMODVERSIONS -include /lib/
> > modules/2.4.21-99-athlon/build/include/linux/modversions.h
> > -DKBUILD_BASENAME=maestro3   -c -o maestro3.o maestro3.c
> > maestro3.c: In function `snd_m3_create':
>
> ....
>
> > maestro3.c:2612: error: structure has no member named `dev'

Can confirm this mornings tiwai snapshot builds fine.

Alan
