From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 0/2][RFC] ASoC: fsi/rcar: fixup SND_SOC_DAIFMT_CBx_CFx
 flags
Date: Fri, 14 Mar 2014 08:55:51 +0900
Message-ID: <20140313235551.GB28137@verge.net.au>
References: <87txb3rjzw.wl%kuninori.morimoto.gx@gmail.com>
 <20140313104836.GN366@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140313104836.GN366@sirena.org.uk>
Sender: linux-sh-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Morimoto <kuninori.morimoto.gx@renesas.com>, Linux-SH <linux-sh@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 13, 2014 at 10:48:36AM +0000, Mark Brown wrote:
> On Tue, Mar 11, 2014 at 11:47:36PM -0700, Kuninori Morimoto wrote:
> > 
> > Hi Mark, Simon
> > 
> > These patches fixup Renesas fsi/rcar driver's
> > SND_SOC_DAIFMT_CBx_CFx flag settings.
> > 
> > I had misunderstand these settings...
> > But this is still [RFC], since it modifies DT side code too.
> > 
> > >> Mark
> > 
> > #1 patch depends on Jyri's
> > "Fix simple-card *-master DT parameter handling"
> > if it was accepted
> > 
> > >> Simon
> > 
> > Can you check #1 patch which modifys SH-ARM platform ?
> 
> So, we need to do something quickly here since this affects DT bindings
> but it would be *much* better to avoid having to set the master flags on
> both ends of the link since that's going to make the binding confusing
> if we're stuck with it as an ABI.
> 
> Simon, are you OK with the arch side of cleanups for this going via my
> tree?

Yes, I'll provide an Ack for them accordingly.

Do you anticipate that they will end up in v3.15-rcX?
If not, could I get a branch with stable commit ids that
I can use as a basis for futher shmobile changes: I'd
like avoid conflicts bubbling up.


