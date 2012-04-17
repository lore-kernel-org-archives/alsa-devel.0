From: Mauro Carvalho Chehab <mchehab@redhat.com>
Subject: Re: [PATCH] [Trivial] Documentation: Add newline at
 end-of-file to files lacking one
Date: Tue, 17 Apr 2012 13:03:35 -0300
Message-ID: <4F8D9457.2080900@redhat.com>
References: <alpine.LNX.2.00.1204162329190.21898@swampdragon.chaosbits.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by alsa0.perex.cz (Postfix) with ESMTP id 30C531042D0
	for <alsa-devel@alsa-project.org>;
	Tue, 17 Apr 2012 18:03:47 +0200 (CEST)
In-Reply-To: <alpine.LNX.2.00.1204162329190.21898@swampdragon.chaosbits.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jesper Juhl <jj@chaosbits.net>
Cc: alsa-devel@alsa-project.org, Andiry Xu <andiry.xu@amd.com>, linux-doc@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, kjsisson@bellsouth.net, Randy Dunlap <rdunlap@xenotime.net>, Sarah Sharp <sarah.a.sharp@linux.intel.com>, linux-media@vger.kernel.org, Andy Lutomirski <luto@mit.edu>, Mike Frysinger <vapier@gentoo.org>, Josua Dietze <digidietze@draisberghof.de>, Michael Hennerich <michael.hennerich@analog.com>, Mauro Carvalho Chehab <mchehab@infradead.org>, Ben Dooks <ben-linux@fluff.org>, Matthew Garrett <mjg@redhat.com>, trivial@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Ben Dooks <ben@simtec.co.uk>, Andrew Morton <akpm@linux-foundation.org>, "H. Peter Anvin" <hpa@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Em 16-04-2012 18:35, Jesper Juhl escreveu:
> This patch simply adds a newline character at end-of-file to those
> files in Documentation/ that currently lack one.
> 
> This is done for a few different reasons:
> 
> A) It's rather annoying when you do "cat some_file.txt" that your
>    prompt/cursor ends up at the end of the last line of output rather
>    than on a new line.
> 
> B) Some tools that process files line-by-line may get confused by the
>    lack of a newline on the last line.
> 
> C) The "\ No newline at end of file" line in diffs annoys me for some
>    reason.
> 
> So, let's just add the missing newline once and for all.
> 
> Signed-off-by: Jesper Juhl <jj@chaosbits.net>
> ---

>  Documentation/dvb/opera-firmware.txt                           |    2 +-
>  Documentation/video4linux/cpia2_overview.txt                   |    2 +-
>  Documentation/video4linux/stv680.txt                           |    2 +-

Acked-by: Mauro Carvalho Chehab <mchehab@redhat.com>
