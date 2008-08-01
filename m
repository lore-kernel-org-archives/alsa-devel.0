From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 04/14] ASoC: Allow codecs to override
	register display
Date: Fri, 1 Aug 2008 16:35:40 +0100
Message-ID: <20080801153538.GA11735@sirena.org.uk>
References: <1217328155-30158-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1217328155-30158-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1217328155-30158-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1217328155-30158-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<9e4733910807311841v3ebe98f5i327606d7d793f832@mail.gmail.com>
	<s5hk5f1jcl7.wl%tiwai@suse.de>
	<20080801100003.GA16420@rakim.wolfsonmicro.main>
	<9e4733910808010750x69e71cd2i21eb0b448e11544a@mail.gmail.com>
	<s5hiquk4v4g.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 4A9462445A
	for <alsa-devel@alsa-project.org>;
	Fri,  1 Aug 2008 17:35:41 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hiquk4v4g.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 01, 2008 at 05:23:27PM +0200, Takashi Iwai wrote:
> Jon Smirl wrote:

> > -			count += codec->display_register(codec, buf + count,
> > -							 PAGE_SIZE - count, i);

...

> > +			count += codec->display_register(codec,
> > +							 buf + count, PAGE_SIZE - count, i);

> Please make it fit in 80 chars like the original code.

This also seems to be an indentation-only change but perhaps I'm missing
something here?

> > -	/* Truncate count; min() would cause a warning */
> > -	if (count >= PAGE_SIZE)
> > -		count = PAGE_SIZE - 1;
> > -

> Really safe to remove this?

No.  snprintf() returns how many bytes it wanted to write, not the
number of bytes it wrote, which means that if the end of the buffer is
hit then count will include the overspill and sysfs will complain.
