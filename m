From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 16/17] ASoC: Basic split of mpc5200
	DMA	code out from mpc5200_psc_i2s
Date: Tue, 28 Apr 2009 20:50:21 +0100
Message-ID: <20090428195020.GC4241@sirena.org.uk>
References: <20090428152256.GB2244@rakim.wolfsonmicro.main>
	<1240932222-3718-16-git-send-email-broonie@opensource.wolfsonmicro.com>
	<s5hljpk233w.wl%tiwai@suse.de>
	<20090428192543.GA4241@sirena.org.uk>
	<9e4733910904281232s32e73f3ka793fdbe5b5db9a0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 1987324571
	for <alsa-devel@alsa-project.org>;
	Tue, 28 Apr 2009 21:50:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <9e4733910904281232s32e73f3ka793fdbe5b5db9a0@mail.gmail.com>
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

On Tue, Apr 28, 2009 at 03:32:18PM -0400, Jon Smirl wrote:

> Now I get to deal with the merge mess in my patch stack. All this did
> was move the problem.

Please send patches against:

git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git mpc5200
