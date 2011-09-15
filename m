From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] ASoC: support sample sizes properly in
 the WM8776 codec driver
Date: Fri, 16 Sep 2011 00:38:14 +0100
Message-ID: <20110915233813.GF3218@opensource.wolfsonmicro.com>
References: <1315936777-27994-1-git-send-email-timur@freescale.com>
	<20110915132154.GF7988@opensource.wolfsonmicro.com>
	<4E7216C4.1090902@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E7CCE103861
	for <alsa-devel@alsa-project.org>;
	Fri, 16 Sep 2011 01:38:18 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4E7216C4.1090902@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 15, 2011 at 10:16:20AM -0500, Timur Tabi wrote:

> This is not a random stylistic change.  My patch changes the way iface is
> calculated.  Therefore, removing an unnecessary pre-initialization of iface is
> both obvious and expected.

No, really it is.

> The "iface = 0" line is used in the original code because the driver did not
> have a "default" case for the "switch" statement.  Since I added a default case,
> there was no need to pre-initialize iface anymore.

It's not that, there's a common idiom in older ASoC drivers where we
initialize the registers we're updating in things like hw_params() to
zero then run through oring in all the various bitfields they update
before a final write at the end.  The code is using that, it just
happens that we end up with only one bitfield to update.  An even better
change would be to use snd_soc_update_bits() to make sure only the
relevant bitfield is touched which is the current state of the art in
idioms for these things.

> If I had left that line in the driver, someone would have complained that I'm
> pre-initializing iface unnecessarily.

That's also the case in the existing code, it's just that the assignment
is masking a bug with the default case (and if we didn't consider that a
bug then of course there's a change to the default behaviour which also
ought to be noted).

In any case, the issue here isn't that the new code is wrong - I'm just
pointing out that you're making the patch harder to review because
you're making changes beyond a straight substitution in of
snd_pcm_format_width() which increases the review difficulty of what
should be a trivial review.

Based on the changelog the first thing I'd look for when reviewing is
that we've got a series of mechanical 1:1 substitutions of references to
SNDRV_PCM_FORMAT and friends with references to snd_pcm_format_width()
and friends.  If you'd just added a note about the style change it'd
have been fine as I'd have been expecting to see changes more like what
you've got.

> > In this case it's not clear
> > from the diff alone that there are no other places where iface gets
> > written to

> Ok, so that means that you need to look at the original code in order to
> understand the change completely.  What's wrong with that?  I just don't see how
> this is a valid criticism for any patch.

Review cost is an issue, not just in terms of it being less effort but
also in terms of increasing the quality of the review - the more that
the reviewer has to infer what's going on the greater the chances that
they'll infer something that isn't there or miss things they should have
seen.  Extra changes that sneak in are a classic source of bugs, things
being missing from the changelog often means that either they were debug
code that went in by accident or they're changes that haven't been
thought through properly.

Had the style change come out all in one diff hunk it'd probably have
been OK but what actually happened was that the first thing seen was a
removal of an assignment to iface which stopped me short.  The fact that
you generally write fairly verbose and clear changlogs makes this
particularly surprising.

> > An important aspect of review is checking that the change being made
> > actually do what they're supposed to do, unexpected additional stuff is
> > a red flag - you have to work out if it's something the sender meant to
> > include, what it's supposed to do and if it's a good idea.

> Again, I just don't understand this complaint of my patch.  I've carefully read
> your email, and I re-examined my patch and the original code, and I still don't
> think that there's anything wrong with the patch.

There's nothing wrong with the code itself, the issue was about how the
process can flow more smoothly.
