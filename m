From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Convert ASoC pxa2xx-ac97 driver to use
	the	clock API
Date: Wed, 20 Feb 2008 11:08:01 +0000
Message-ID: <20080220110759.GA8661@sirena.org.uk>
References: <s5hd4qsucgy.wl%tiwai@suse.de>
	<E913911567467945BBEB9277E27868B08812AA@msiexch01.marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id EFBE924455
	for <alsa-devel@alsa-project.org>; Wed, 20 Feb 2008 12:08:03 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <E913911567467945BBEB9277E27868B08812AA@msiexch01.marvell.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Eric Miao <ymiao3@marvell.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-arm-kernel@lists.arm.linux.org.uk, Russell King <rmk@arm.linux.org.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 19, 2008 at 04:59:00PM -0800, Eric Miao wrote:

> Shouldn't the clock rate for AC97 be 12.288MHz? Though the clock is
> actually provided by external, the clock hierarchy implies an internal
> clock of 12.288MHz on both PXA25x DM and PXA3xx DM (unfortunately, not
> specified on PXA27x DM)

The AC97 bit clock should be run at 12.288MHz but this is a separate
thing to that.  The AC97 controller needs its own clocking for at least
some things that need to work when the AC97 link is not active (like
reset operations).  The controller also provides an external 24.576MHz
AC97_SYSCLK signal which is used by some designs to clock the primary
codec - in those designs the bit clock is derived from it, but it may
also be derived from another source.
