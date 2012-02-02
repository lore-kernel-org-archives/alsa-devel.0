From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: soc-dsp programming model for loopbacks
Date: Thu, 02 Feb 2012 17:33:20 +0530
Message-ID: <1328184200.26182.8.camel@vkoul-udesk3>
References: <4f1f2489.c602440a.208e.ffff9d7bSMTPIN_ADDED@mx.google.com>
	<1327511249.11901.37.camel@odin>
	<1328087231.1610.28.camel@vkoul-udesk3>
	<CABS+qY2GADPO+wkmDf5hzT7uaH7v1zNrdAGKnLbip-QAL8V_RQ@mail.gmail.com>
	<1328181472.3974.5.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id E39B410392B
	for <alsa-devel@alsa-project.org>; Thu,  2 Feb 2012 13:02:43 +0100 (CET)
In-Reply-To: <1328181472.3974.5.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 2012-02-02 at 11:17 +0000, Liam Girdwood wrote:
> On Wed, 2012-02-01 at 11:50 +0000, Girdwood, Liam wrote:
> > On 1 February 2012 09:07, Vinod Koul <vinod.koul@linux.intel.com> wrote
> > 
> > > Liam, if we configure the hw_params in the machine driver statically,
> > > represent the DSP using a map along with a codec kind of modeling.
> > >
> 
> In OMAP we reconfigure (or fixup) some of the hw_params() in the machine
> driver for a BE DAI link that cant operate at the requested FE params.
> The ABE takes care of any conversion though. 

> 
> > > Would the BEs be triggered on from soc_dsp_runtime_update() when the
> > > loopback is established thru the DSP.
> > > This way we avoid all the "virtual" FEs. Use loopback to turn on codec
> > > and DSP (thru BEs)
> > >
> > > Would this make sense, or I need more coffee :)
> In the code base atm we have to use a FE pcm to trigger the BE loopback
> DAIs. however, the intention is to use Mark's CODEC <-> CODEC DAI link
> work to support the loopback with hard coded params in the machine
> driver. This would save the need for any FE pcm operations.
precisely my thoughts :)
Assuming we dont have to worry about hw_params (hard coded in machine),
then establishing a loopback with two BEs should automatically trigger
DAPM to detect a loopback, and by principle start these BEs and any
associated codec DAIs. Does this idea sound good?

Now to actual changes, when will we see dynamic-pcm in asoc-next :-)

And Mark, can we see your wip changes??

-- 
~Vinod
