From: Dan Carpenter <error27@gmail.com>
Subject: Re: [patch] ASoC: soc: snprintf() doesn't return
	negative
Date: Mon, 11 Oct 2010 23:11:38 +0200
Message-ID: <20101011211138.GL5851@bicker>
References: <20101011035416.GD5851@bicker>
	<20101011104009.GB9231@rakim.wolfsonmicro.main>
	<20101011164038.GE5851@bicker>
	<20101011185148.GB22355@opensource.wolfsonmicro.com>
	<20101011194502.GK5851@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 8F249103974
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Oct 2010 23:11:56 +0200 (CEST)
Received: by wwb28 with SMTP id 28so3406131wwb.20
	for <alsa-devel@alsa-project.org>; Mon, 11 Oct 2010 14:11:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101011194502.GK5851@bicker>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Peter Ujfalusi <peter.ujfalusi@n>
List-Id: alsa-devel@alsa-project.org

On Mon, Oct 11, 2010 at 09:45:02PM +0200, Dan Carpenter wrote:
> On Mon, Oct 11, 2010 at 07:51:48PM +0100, Mark Brown wrote:
> > In actual fact quite a few devices have enough registers to be
> > truncated, meaning that it's not only possible but likely we'll exercise
> > the cases that deal with the end of buffer.  If snprintf() is returning
> > values larger than buffer size it was given we're likely to have an
> > issue but it seems that there's something missing in your analysis since
> > we're never seeing WARN_ON()s and are instead seeing the behaviour the
> > code is intended to give, which is to truncate the output when we run
> > out of space.
> > 
> > Could you re-check your analysis, please?
> 
> That's odd.  I'm sorry, I can't explain why you wouldn't see a stack
> trace...  The code is straight forward:
> 
>         /* Reject out-of-range values early.  Large positive sizes are
>            used for unknown buffer sizes. */
>         if (WARN_ON_ONCE((int) size < 0))
>                 return 0;
> 
> It would still give you truncated output but after the NULL terminator
> there would be information leaked from the kernel.  If the reader
> program had allocated a large enough buffer to handle the extra
> information it wouldn't cause a problem.
> 

Actually it will never cause a problem with userspace because we pass
the size of the userspace buffer to the kernel.  The only issues are the
information leak if the user passes in a 8k buffer and the also the
WARN_ON_ONCE()


regards,
dan carpenter
