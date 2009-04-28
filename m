From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 16/17] ASoC: Basic split of mpc5200
	DMA	code out from mpc5200_psc_i2s
Date: Tue, 28 Apr 2009 20:37:15 +0100
Message-ID: <20090428193715.GB4241@sirena.org.uk>
References: <20090428152256.GB2244@rakim.wolfsonmicro.main>
	<1240932222-3718-16-git-send-email-broonie@opensource.wolfsonmicro.com>
	<s5hljpk233w.wl%tiwai@suse.de>
	<9e4733910904280859t6409e9b7w4eccee65959598e5@mail.gmail.com>
	<s5hk554sow9.wl%tiwai@suse.de>
	<9e4733910904280955u179bc260k80dd955fce6d1c0a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id BFC8E103854
	for <alsa-devel@alsa-project.org>;
	Tue, 28 Apr 2009 21:37:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <9e4733910904280955u179bc260k80dd955fce6d1c0a@mail.gmail.com>
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

On Tue, Apr 28, 2009 at 12:55:16PM -0400, Jon Smirl wrote:

> I wanted the split files added to 2.6.30 not 2.6.31. If they had gone
> into 2.6.30 you would have patched after the split and everything
> would have propagated without merge conflicts. In general, changes in
> git that cross a file split will cause manual manual merges in
> everything pending past the split.

It wouldn't have helped with the merge issues since bug fixes get merged
up into the 2.6.31 branch very fast.  In any case, we're in the -rc part
of the development cycle - we should be merging targetted bug fixes
only.  Eyebrows would be raised by a diff of that size going in.
