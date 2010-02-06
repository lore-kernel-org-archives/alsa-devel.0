From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: safe support for rewind in ALSA
Date: Sat, 6 Feb 2010 19:59:12 +0800
Message-ID: <4f3252891002060359j11d68819idf5d12705e2a60bc@mail.gmail.com>
References: <6160a5131002010920j4417a34ai9f410fb500f7f305@mail.gmail.com>
	<alpine.LNX.2.00.1002011840020.25340@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f173.google.com (mail-px0-f173.google.com
	[209.85.216.173])
	by alsa0.perex.cz (Postfix) with ESMTP id 5A2D024462
	for <alsa-devel@alsa-project.org>; Sat,  6 Feb 2010 12:59:14 +0100 (CET)
Received: by pxi3 with SMTP id 3so392356pxi.16
	for <alsa-devel@alsa-project.org>; Sat, 06 Feb 2010 03:59:13 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.1002011840020.25340@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2010/2/2 Jaroslav Kysela <perex@perex.cz>

> On Mon, 1 Feb 2010, pl bossart wrote:
>
> > All,
> > I'd like to reopen a thread on concerns with the current
> > implementation of rewind in ALSA. This was already discussed on the
> > mailing list last year without any progress.
>
> I don't think that there have been no progress. The queued samples can be
> stored to runtime->delay now, so snd_pcm_delay() returns a correct
> value.
>
> The snd_pcm_rewind() and snd_pcm_forward() functions should operate in the
> ring buffer and it's ok. See the USB driver for an example. Just add
> support for runtime->delay to the lowlevel drivers and use snd_pcm_delay()
> correctly in the user space and everything will work as expected.
>
> In other words - for hardware with large FIFOs, the runtime->delay should
> be used for queued samples and the hw_ptr in the ring buffer should be
> increased as soon as the FIFO is filled with samples from the ring buffer.
>
>                                        Jaroslav
>
>
How about those alsa plugins ( e.g. pulse , jack , oss , .... )

Can alsa application use snd_pcm_rewind() for pulse plugin or oss plugin ?
