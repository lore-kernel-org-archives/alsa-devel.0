From: Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH for-4.11] ASoC: don't dereference NULL pcm_{new,free}
Date: Mon, 13 Mar 2017 14:52:56 -0700
Message-ID: <20170313215256.GD4586@google.com>
References: <20170308231854.50167-1-briannorris@chromium.org>
 <20170309110918.getjla6iawgjpfrq@sirena.org.uk>
 <20170311002406.GA4586@google.com>
 <20170313125004.yrqranp3sxsfkmfx@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170313125004.yrqranp3sxsfkmfx@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 13, 2017 at 12:50:04PM +0000, Mark Brown wrote:
> On Fri, Mar 10, 2017 at 04:24:07PM -0800, Brian Norris wrote:
> > On Thu, Mar 09, 2017 at 12:09:18PM +0100, Mark Brown wrote:
> 
> > > Please think hard before including complete backtraces in upstream
> > > reports, they are very large and contain almost no useful information
> > > relative to their size so often obscure the relevant content in your
> > > message. If part of the backtrace is usefully illustrative then it's
> > > usually better to pull out the relevant sections.
> 
> > I did think, and I did trim the trace significantly. I believe (or
> > believed; maybe incorrectly) that much of the remaining context *was*
> > useful, and that it could have answered some of Kuninori's questions, if
> > he chose to dig himself. As admitted in the commit message, I don't
> > really understand all of the relationships here, so it's hard to
> > highlight "only the relevant sections".
> 
> Any editing you'd done is really not obvious looking at the trace (the

There's a "..." in there why I trimmed a huge amount of junk that arm64
likes to dump, like surrounding memory context near the $pc and $sp.
Probably more.

> inclusion of the top of the trace with the pgd and so on which really
> need the image to be useful is a bit of a flag here, as is the bit at
> the end after the end of the trace).  It's certainly not mentioned or

The PC (0) and LR (which is not reflected in the backtrace) are useful.

> referenced.  At the very least for probe errors it's generally safe to
> cut down to just the driver probe function is being called rather than
> showing the entire device model call stack, it's vanishingly rare for
> that to be adding anything and it's generally several times deeper than
> what the driver is doing.

Sure, this could have been trimmed about 50% without losing information.
I can try to be more precise next time, but the 50% useful info included
was quite intentional. Particularly, I'm not very happy with my patch,
so alternatives are welcome (esp. from those who might be able to glean
more from the report than I could).

> > I'm sorry that my post did not meet your standards though. Next time
> > I'll just post a revert with little context and no attempt to understand
> > what actually went wrong.
> 
> Providing changes with little context and no conveyed understanding of
> exactly what went wrong is a very big part of the reason for complaining
> about people just splatting backtraces in and certainly not what I was
> asking for, it's sadly common to see a backtrace provided in lieu of any
> analysis and it does make the whole thing harder to read.  That would be
> even more problematic than what you sent, I wouldn't have applied such a
> change at all unless I somehow reverse engineered the analysis.

Sure, I can understand frustration with essentially contentless "bug
reports." And I got frustrated by a seemingly pat response that was
(IMO) a bit mistargeted.

> You do have a reasonable analysis of your change in the first couple of
> lines ("Not all platform drivers have pcm_{new,free} callbacks...")
> which is why I applied it, it's at least not going to do any harm to
> check that there's a function being provided.

I suppose.

BTW, I don't see the patch applied anywhere (and I have no reply -
either manual or automated/patchwork - other than the above quote to say
it was).

Brian
