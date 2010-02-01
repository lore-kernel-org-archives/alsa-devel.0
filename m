From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: safe support for rewind in ALSA
Date: Mon, 1 Feb 2010 19:00:52 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1002011840020.25340@eeebox2.perex-int.cz>
References: <6160a5131002010920j4417a34ai9f410fb500f7f305@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 4E61E243F0
	for <alsa-devel@alsa-project.org>; Mon,  1 Feb 2010 19:00:53 +0100 (CET)
In-Reply-To: <6160a5131002010920j4417a34ai9f410fb500f7f305@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: pl bossart <bossart.nospam@gmail.com>
Cc: ALSA development <alsa-devel@alsa-project.org>, Kai Vehmanen <kvehmanen@eca.cx>
List-Id: alsa-devel@alsa-project.org

On Mon, 1 Feb 2010, pl bossart wrote:

> All,
> I'd like to reopen a thread on concerns with the current
> implementation of rewind in ALSA. This was already discussed on the
> mailing list last year without any progress.

I don't think that there have been no progress. The queued samples can be 
stored to runtime->delay now, so snd_pcm_delay() returns a correct 
value.

The snd_pcm_rewind() and snd_pcm_forward() functions should operate in the 
ring buffer and it's ok. See the USB driver for an example. Just add 
support for runtime->delay to the lowlevel drivers and use snd_pcm_delay() 
correctly in the user space and everything will work as expected.

In other words - for hardware with large FIFOs, the runtime->delay should 
be used for queued samples and the hw_ptr in the ring buffer should be 
increased as soon as the FIFO is filled with samples from the ring buffer.

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
