From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Breakage in pcm_lib.c
Date: Sun, 26 Apr 2009 10:12:42 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0904261000520.25064@eeebox2.perex-int.cz>
References: <9e4733910904251756y6534d2d0x6c201d00cbc728d9@mail.gmail.com>
	<9e4733910904251848q4d64c413ld5af61019edae647@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id A295E24472
	for <alsa-devel@alsa-project.org>;
	Sun, 26 Apr 2009 10:12:42 +0200 (CEST)
In-Reply-To: <9e4733910904251848q4d64c413ld5af61019edae647@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sat, 25 Apr 2009, Jon Smirl wrote:

> This appears to be a bug in this code...
>
> 	if (delta < 0) {
> 		delta += runtime->period_size * runtime->periods;
>
> it was adding, buffer_size. But buffer_size is not correct when the
> periods don't evenly fit into the buffer

Could you show real values what you're getting here with your driver?

The buffer_size is always a wrap point. For example:

buffer_size = 4096
period_size = 1536

hw_ptr_interrupt => 1536, 3072, 4608

For example, if we receive update_hw_interrupt for second period
late when pos (.pointer callback) = 100 and hw_ptr_interrupt = 3072 
(hw_base is 0 at the moment):

new_hw_ptr = 100
hw_ptr_interrupt = 3072
delta = -2972

delta += buffer_size -> delta = 1124	- seems correct

Appearently, your .pointer callback returns wrong values.

> 		if (delta < 0) {
> 			hw_ptr_error(substream,
> 				     "Unexpected hw_pointer value "
> 				     "(stream=%i, pos=%ld, intr_ptr=%ld)\n",
> 				     substream->stream, (long)pos,
> 				     (long)hw_ptr_interrupt);
> 			/* rebase to interrupt position */
> 			hw_base = new_hw_ptr = hw_ptr_interrupt;
> 			/* align hw_base to buffer_size */
> 			hw_base -= hw_base % runtime->buffer_size;
> 			delta = 0;
> 		} else {
> 			hw_base += runtime->period_size * runtime->periods;
>
> same here

hw_base is always aligned to buffer_size (start of ring buffer)

> 	delta = jiffies - s->jiffies; /* s->jiffies recorded at DMA
> interrrupt at end of buffer */
> 	delta = delta * runtime->rate / HZ;

Using jiffies to correct stream position seems correct to me.

 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
