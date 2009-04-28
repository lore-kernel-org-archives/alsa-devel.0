From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 16/17] ASoC: Basic split of mpc5200
	DMA	code out from mpc5200_psc_i2s
Date: Tue, 28 Apr 2009 22:01:41 +0100
Message-ID: <20090428210141.GB10325@sirena.org.uk>
References: <20090428152256.GB2244@rakim.wolfsonmicro.main>
	<1240932222-3718-16-git-send-email-broonie@opensource.wolfsonmicro.com>
	<s5hljpk233w.wl%tiwai@suse.de>
	<9e4733910904280859t6409e9b7w4eccee65959598e5@mail.gmail.com>
	<s5hk554sow9.wl%tiwai@suse.de>
	<9e4733910904280955u179bc260k80dd955fce6d1c0a@mail.gmail.com>
	<9e4733910904281014t1472281cn48070de201a85a8@mail.gmail.com>
	<s5hd4awr2m9.wl%tiwai@suse.de>
	<20090428195353.GD4241@sirena.org.uk>
	<9e4733910904281259r1188acb0r7063ea809668b6b5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 33BBA103817
	for <alsa-devel@alsa-project.org>;
	Tue, 28 Apr 2009 23:01:49 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <9e4733910904281259r1188acb0r7063ea809668b6b5@mail.gmail.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 28, 2009 at 03:59:52PM -0400, Jon Smirl wrote:

> Why are people going to complain about patches to a driver marked
> broken? You can't even compile it without editing the Kconfig.

There is no problem with doing whatever to the driver for 2.6.31 but we
do need to make sure we stay in sync with the other API work that's
going on in 2.6.31.

For 2.6.30 we're outside the merge window so we need to send targetted
fixes for bugs - if we sent your current patches upstream now the
pushback would be that such large refactorings should be merged as part
of the merge window and the bug fixes should be extracted from your
refactoring and merged now.  This is the kernel wide development policy,
not an ALSA or ASoC specific one.

Ideally we wouldn't have to mark the driver broken but would instead be
merging bug fixes to it into 2.6.30 - marking it as broken was an
alternative to that.

For the merges the simplest thing would be to fix the current code
before doing the refactoring, though from the sounds of it the final
fixes required for 2.6.30 will be very small in the driver so I'd expect
this can be resolved fairly simply.  Changes made in the 2.6.30 branch
get merged into the 2.6.31 branch very quickly so any divergence between
the two branches shouldn't exist for long.
