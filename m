From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Request for test (1.0.18 final)
Date: Wed, 29 Oct 2008 09:56:07 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0810290955310.12044@tm8103.perex-int.cz>
References: <Pine.LNX.4.61.0810271449320.12044@tm8103.perex-int.cz>
	<200810272041.10885.gineera@aspect135.co.uk>
	<Pine.LNX.4.61.0810290945200.12044@tm8103.perex-int.cz>
	<s5hmygnlr47.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id AAED024339
	for <alsa-devel@alsa-project.org>; Wed, 29 Oct 2008 09:56:07 +0100 (CET)
In-Reply-To: <s5hmygnlr47.wl%tiwai@suse.de>
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
Cc: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 29 Oct 2008, Takashi Iwai wrote:

> At Wed, 29 Oct 2008 09:48:55 +0100 (CET),
> Jaroslav Kysela wrote:
> > 
> > > ../../alsa-kernel/pci/ice1712/ice1712.c:50:22: linux/io.h: No such file or 
> > > directory
> > > 
> > > presumably caused as it is <asm/io.h> here?
> > 
> > It should be handled in configure.in:
> > 
> > CHECK_KERNEL_HEADER(linux/io.h, [#include <asm/io.h>
> > ])
> > 
> > Not sure why linux/io.h in alsa-driver/include/linux/ directory is not 
> > created for your kernel. You may investigate this yourself if you like.
> 
> This check was added after this report.

Great. I overlooked this.

					Thanks,
						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
