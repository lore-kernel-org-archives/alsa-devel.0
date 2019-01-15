From: Matthias Reichl <hias@horus.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: soc-core: Fix null pointer
 dereference in soc_find_component
Date: Tue, 15 Jan 2019 22:48:07 +0100
Message-ID: <20190115214807.vhzxuuf33b4nnkoo@lenny.lan>
References: <1547194442-1487-1-git-send-email-rohitkr@codeaurora.org>
 <d8726e9a-3477-a573-8c1a-dd8245068802@linux.intel.com>
 <4886ed21-65d2-159d-afcd-bb26dcde636e@linux.intel.com>
 <20190115000610.GM11073@sirena.org.uk>
 <796a856c-a9a6-022d-da63-947279090198@linux.intel.com>
 <20190115211137.rhdyjadu7fppp3p4@lenny.lan>
 <af2e9555-444f-7c40-865b-347f3db8fa76@linux.intel.com>
 <20190115214138.GL5522@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190115214138.GL5522@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, rohkumar@qti.qualcomm.com, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, vinod.koul@linaro.org, lgirdwood@gmail.com, plai@codeaurora.org, linux-kernel@vger.kernel.org, tiwai@suse.com, Liam Girdwood <liam.r.girdwood@linux.intel.com>, srinivas.kandagatla@linaro.org, Rohit kumar <rohitkr@codeaurora.org>, asishb@codeaurora.org, Ajit Pandey <ajitp@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 15, 2019 at 09:41:38PM +0000, Mark Brown wrote:
> On Tue, Jan 15, 2019 at 03:16:57PM -0600, Pierre-Louis Bossart wrote:
> 
> > > Maybe the defer card probe logic needs to be extended to also check if
> > > dai_link_name had already been registered (either cpu or cpu_dai_name
> > > needs to be set), not 100% sure which problem the defer card probe patch
> > > was trying to solve.
> 
> We were getting cards probing without the platforms being registered
> (which in turn meant we were just skipping their init) and had patches
> proposed to implement the deferral in the cards.  The deferral stuff is
> supposed to making sure that everything is registered when we
> instantiate.

Ah, that makes sense. Thanks a lot for the info!

so long,

Hias

> 
> > same here, I don't get why the deferred probe stuff only deals with one of
> > the two options.
> 
> I think it's just an oversight - I think the change you were proposing
> to check the cpu_dai_name is a good idea anyway as it makes things more
> consistent and work more obviously by intention.  And more generally if
> we can simplify the code by removing legacy options that'd be good but
> that's a bigger bit of work...
