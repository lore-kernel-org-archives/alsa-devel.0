From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: safe support for rewind in ALSA
Date: Tue, 2 Feb 2010 10:53:44 +0800
Message-ID: <4f3252891002011853t122d6098x76a62c0c4fc0b2ca@mail.gmail.com>
References: <6160a5131002010920j4417a34ai9f410fb500f7f305@mail.gmail.com>
	<alpine.LNX.2.00.1002011840020.25340@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f176.google.com (mail-pz0-f176.google.com
	[209.85.222.176])
	by alsa0.perex.cz (Postfix) with ESMTP id EE03524434
	for <alsa-devel@alsa-project.org>; Tue,  2 Feb 2010 03:53:46 +0100 (CET)
Received: by pzk6 with SMTP id 6so105398pzk.23
	for <alsa-devel@alsa-project.org>; Mon, 01 Feb 2010 18:53:45 -0800 (PST)
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
Are there any demo program using snd_pcm_rewind()/snd_pcm_forward() to
verify the driver meet  your proposal  ?

For the interrupt driven model, the application fill the period while the
driver playing the other period on two periods per buffer , the drivers
don't need to provide accuracy up to a few sample derivation.

However It seem to me that your proposal give an impression to the
application developer that all ALSA drivers can  provide accuracy up to
sample accuracy
