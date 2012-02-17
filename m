From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: [PATCH 1/2] ASoC: core - Add direct mapping
 between DAIs and DAPM
Date: Fri, 17 Feb 2012 11:10:53 +0530
Message-ID: <1329457253.24656.7.camel@vkoul-udesk3>
References: <1329321775-21082-1-git-send-email-lrg@ti.com>
	<20120215162412.GG2996@opensource.wolfsonmicro.com>
	<1329399358.28852.19.camel@odin>
	<20120216175955.GE3383@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id 3FB802451C
	for <alsa-devel@alsa-project.org>; Fri, 17 Feb 2012 06:36:30 +0100 (CET)
In-Reply-To: <20120216175955.GE3383@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 2012-02-16 at 09:59 -0800, Mark Brown wrote:
> On Thu, Feb 16, 2012 at 01:35:58PM +0000, Liam Girdwood wrote:
> > On Wed, 2012-02-15 at 08:24 -0800, Mark Brown wrote:
> 
> > > I was thinking about something close to this myself as part of the
> > > CODEC<->CODEC automatic DAPM stuff I keep mentioning.  In order to make
> > > that work what I was going to do was instead of mapping the widgets
> > > directly onto the DAI was to add a DAPM widget that represented the
> > > stream and link the DAI to that, probably created automatically from the
> > > DAI definition.  We'd then have the DAIs sitting in the DAPM graph and
> 
> > I'm easy enough, but I'm not sure how we could map specific PCM channels
> > via the DAPM graph. e.g. we could connect the L and R DAC widgets to the
> > DAI widget but how would we associate the L DAC widget with PCM channel
> > 0 etc. 
> 
> We actually need to do that anyway for the CODEC<->CODEC links, I've got
> use cases where there are multiple independant streams going over the
> same DAI on different channels (eg, stereo pair on 0 and 1, another
> stereo pair on 2 and 3).
Is this a TDM DAI you are referring to? 
> 
> I can see two ways of doing this.  One is simply to teach DAPM about
> these shiny new things like channel numbers in the same way it knows
> about mixers and muxes.  Obviously that's a bit invasive but clearly
> it'll do the trick.  The other is to hang this in using the connected
> callback on the route, have the callback look at the DAI to see what
> channels are active and then report if the link is present or not.  The
> infrastructure for that is there in DAPM itself already which is nice.
My +1 for teaching DAPM about channel numbering. Today I have DAI
associated with a stream. This DAI can take 4 channels. But DAPM turns
ON all 4 channels even if we have mono or stereo being turned on.
> 
> > To give us a unique channel ID for each PCM channel propagating through
> > each widget (since I can map PCM channels atm).
> 
> > I did connect the DAIs together in the mach driver via DAPM, but I agree
> > it would be nicer connect the DAI widgets together here rather than
> > DACs, etc.
> 
> > The dynamic PCM patch is also blocking on having some sort of DAI ->
> > widget mapping so we would need something upstream soonish.
> 
> > I'll take a quick look and see if I can modify this and try and include
> > a DAI widget too whilst retaining the channel mapping before you have
> > breakfast.
> 
> I *think* can get something working quickly that doesn't fill in the
> blanks for CODEC-CODEC links, though the conference is looking quite
> interesting today.  I'll try to send something later.
On conference, when are we planing our next ASoC conference?

-- 
~Vinod
