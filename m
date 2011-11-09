From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: soc-dsp questions
Date: Wed, 09 Nov 2011 13:34:57 +0530
Message-ID: <1320825897.32205.490.camel@vkoul-udesk3>
References: <1320740555.32205.144.camel@vkoul-udesk3>
	<CABS+qY3kpJjWtEOP4RG=jv_OzD2RVvJqPnJzO09yzDypk6pS8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id EBA2D1039B2
	for <alsa-devel@alsa-project.org>; Wed,  9 Nov 2011 09:09:20 +0100 (CET)
In-Reply-To: <CABS+qY3kpJjWtEOP4RG=jv_OzD2RVvJqPnJzO09yzDypk6pS8A@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Girdwood, Liam" <lrg@ti.com>
Cc: alsa <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Pierre-louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 2011-11-08 at 20:20 +0000, Girdwood, Liam wrote:
> Hi Vinod,
> 
> Sorry, just about to travel again so my replies might be delayed.
> 
> On 8 November 2011 08:22, Vinod Koul <vinod.koul@linux.intel.com> wrote:
> > Hey Liam,
> >
> > I had few questions on your dsp work, would be great if you could answer
> > them and help me in understanding the approach.
> >
> > - Is it possible to have one FE connected to multiple BEs (voice FE to
> > modem and headset bBE), if so how?
> 
> yes, the DAPM graph is extended to link the AIF of each FE PCM to each
> supported BE DAI (please look at omap-abe-dsp.c).
> 
> This allows (via kcontrol settings) the routing between FE PCMs and BE
> DAIs to be controlled at stream runtime. The Dynamic PCM core takes
> care of all the PCM ops and hw_params for each DAI (and re-writes any
> params that require changes for a particular DAI).
Good, that is what i was hoping for :)
> 
> > - SND_SOC_DAI_LINK_OPT_HOST, what does this mean, does not seem to be
> > used anywhere in core?
> 
> It's historical and can be removed.
> 
> > - Why comment need dummy codec for some BEs like BT etc, when soc-core
> > has already one?
> 
> ditto.
> 
> > - any reason why be haves a number associated with a BE, than usual
> > convention of referring things by string name in asoc?
> >
> 
> Sorry, not sure what part do you mean here ?
you are referring to BEs using a number of be_id in the dai_link, like
as OMAP_ABE_DAI_XXX. Not usually by the name of the BE DAI. Any reason
for this departure from usual asoc convention of using string names?

> > and last one, when would this be merged to mainline, 3.3?
> >
> 
> Ah yes, the important question ;) I've been traveling the last 3
> months or so and have not had a chance to finish the upstreaming. I
> have one more trip planned this year and my intention is 3.3 when I
> return.
Okay, thanks for the info


-- 
~Vinod
