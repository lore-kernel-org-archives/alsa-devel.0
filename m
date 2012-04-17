From: Rob Landley <rob@landley.net>
Subject: Re: [PATCH] [Trivial] Documentation: Add newline at end-of-file to
 files lacking one
Date: Tue, 17 Apr 2012 10:41:33 -0500
Message-ID: <4F8D8F2D.7030704@landley.net>
References: <alpine.LNX.2.00.1204162329190.21898@swampdragon.chaosbits.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <alpine.LNX.2.00.1204162329190.21898@swampdragon.chaosbits.net>
Sender: linux-doc-owner@vger.kernel.org
To: Jesper Juhl <jj@chaosbits.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@xenotime.net>, trivial@kernel.org, kjsisson@bellsouth.net, Ben Dooks <ben-linux@fluff.org>, Mauro Carvalho Chehab <mchehab@infradead.org>, Ben Dooks <ben@simtec.co.uk>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Andy Lutomirski <luto@mit.edu>, "H. Peter Anvin" <hpa@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Josua Dietze <digidietze@draisberghof.de>, Andiry Xu <andiry.xu@amd.com>, Matthew Garrett <mjg@redhat.com>, Sarah Sharp <sarah.a.sharp@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, Mike Frysinger <vapier@gentoo.org>, Michael Hennerich <michael.hennerich@analog.com>, linux-media@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 04/16/2012 04:35 PM, Jesper Juhl wrote:
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

Acked-by: Rob Landley <rob@landley.net>

Rob
-- 
GNU/Linux isn't: Linux=GPLv2, GNU=GPLv3+, they can't share code.
Either it's "mere aggregation", or a license violation.  Pick one.
