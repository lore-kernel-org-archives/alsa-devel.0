From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC updates for 2.6.32
Date: Fri, 6 Nov 2009 14:23:30 +0000
Message-ID: <20091106142330.GB4938@sirena.org.uk>
References: <20091106132654.GC10371@rakim.wolfsonmicro.main>
	<s5h639n92uv.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 5396124705
	for <alsa-devel@alsa-project.org>; Fri,  6 Nov 2009 15:23:33 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5h639n92uv.wl%tiwai@suse.de>
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

On Fri, Nov 06, 2009 at 02:53:12PM +0100, Takashi Iwai wrote:

> Ah, I thought you merged 2.6.32-rc6 to for-2.6.33 branch.

I'd like to be able to build 2.6.32 too - the build failures arrived via
mainline in the merge window and are completely unrelated to ASoC,
they're in the core architecture code.

> Well, this back-merging isn't good.  If needed, move to 2.6.32-rc6,

IIRC you have other fixes which are going to generate a merge up anyway
when this gets merged down into your fixes branch due to other things
not having being pushed to Linus yet (unless stuff got merged since I
last checked).  

I do wonder if it might be worth removing the fixes branches after
they've been merged and starting from the last -rc (or always merging
the -rcs into the fixes branches would have the same effect).  That
would maintain your goal of keeping the logs clean and would also
improve the integration testing that the fixes get, even if that
improvement should mostly be trivial.

To be honest I find it hard to see any issue with merging either way
around; the difference in the logs is minor and which you want really
depends on why you're looking at them and your understanding of what the
branches are doing.  Part of the reason I tend to do the merges this way
around is that the way the topic branches are split and kept feels like
a concerted effort to keep development isolated so merging up mainline
so pulling mainline fixes onto the branch seems like an event.

> then merge or rebase the pending commits (just two?) to there, and
> give it as for-2.6.32 branch.

I've pushed the branch up as a rebase onto 2.6.32; you still get the
enormous diffstat and changelog against your fix branch so not
reposting it.
