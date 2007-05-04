From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: DMix period_size should always be half of buffer
	size?
Date: Fri, 4 May 2007 09:06:05 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0705040903340.7594@tm8103.perex-int.cz>
References: <49f264960705031550q4884453ck6d9d6a1f1b6ef6d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 3FC1224430
	for <alsa-devel@alsa-project.org>;
	Fri,  4 May 2007 09:06:06 +0200 (CEST)
In-Reply-To: <49f264960705031550q4884453ck6d9d6a1f1b6ef6d@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Prabhu Sivaraja <prabhu.sivaraja@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 3 May 2007, Prabhu Sivaraja wrote:

> This is a followup to my earlier question about dmix not being able to mix
> small files. I investigated it more and here is what I found.
> 
> Again background info.
> I have a 64KB as kernel buffer and a 64KB circular buffer for my device. In
> a poll thread I copy the data obtained from ALSA lib from the kernel buffer
> to my device circular buffer by keeping track of appl_ptr and hw_ptr(dmix
> only). Everything was working fine except when I was trying to mix files
> smaller than 64KB(my buffer size), the small file was not getting mixed
> through the dmix plugin. Anything over 64KB was getting mixed just fine. So
> I set about reducing my period size from 32KB to 4KB while maintaining my
> buffer size at 64KB.
> 
> When I tried to do this my hw_ptr never gets incremented from 0. Hence my
> driver is stuck in a loop waiting for bytes to copy. This is only observed
> when I am using dmix plugin and NOT when using hw or plughw. When my period
> size is half the size of my buffer everything works fine with dmix (I
> verified this by reducing my buffer size to 8KB and making my period size
> 4KB. hw_ptr gets incremented then but I get buffer problems). It seems like
> dmix is forcing me to keep my period size half the size of my buffer. hw and
> plughw devices do not seem to do that.
> 
> Is this a limitation of dmix. Could anyone comment on the dmix limitation
> that I am experiencing.

No, dmix works with more periods well. Send us debug info from 
/proc/asound/card0/pcm0p (when the stream is opened) and check, if your 
driver notifies higher PCM level with period_elapsed() and if your 
position callback returns right value when the stream is started.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
