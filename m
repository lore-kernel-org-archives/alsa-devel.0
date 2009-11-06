From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC updates for 2.6.32
Date: Fri, 6 Nov 2009 15:06:54 +0000
Message-ID: <20091106150654.GB27699@rakim.wolfsonmicro.main>
References: <20091106132654.GC10371@rakim.wolfsonmicro.main>
	<s5h639n92uv.wl%tiwai@suse.de>
	<20091106142330.GB4938@sirena.org.uk>
	<s5hzl6zu3c5.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5FC132474F
	for <alsa-devel@alsa-project.org>; Fri,  6 Nov 2009 16:06:55 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hzl6zu3c5.wl%tiwai@suse.de>
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

On Fri, Nov 06, 2009 at 03:37:14PM +0100, Takashi Iwai wrote:

> It's fine to keep the fix branch forwarding after the merge.  Feel
> free to do that in your side.

OK, I'll do that.  You're not concerned about this giving you the effect
of back merging into your for-linus branches, or do you throw those away
and regenerate them anyway?

> My only point is that the backward merge from the upstream isn't
> regarded as a good thing.

...

> Well, I myself don't mind much, but Linus would do.
> That's why I'm asking.

I wasn't aware of this.  I know he had issues with merging up of random
not particularly tested commits (I don't like that either, especially in
the merge window) but he had said he was OK with merging up tagged
releases.

Like I say, it's mostly just for my mental model of what's going on -
the fact that there are these topic branches and they're kept around is
what's telling me to do things this way.
