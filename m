From: Liam Girdwood <lrg@ti.com>
Subject: Re: soc-dsp programming model for loopbacks
Date: Thu, 02 Feb 2012 11:17:52 +0000
Message-ID: <1328181472.3974.5.camel@odin>
References: <4f1f2489.c602440a.208e.ffff9d7bSMTPIN_ADDED@mx.google.com>
	<1327511249.11901.37.camel@odin>
	<1328087231.1610.28.camel@vkoul-udesk3>
	<CABS+qY2GADPO+wkmDf5hzT7uaH7v1zNrdAGKnLbip-QAL8V_RQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog107.obsmtp.com (na3sys009aog107.obsmtp.com
	[74.125.149.197])
	by alsa0.perex.cz (Postfix) with ESMTP id 3B84424512
	for <alsa-devel@alsa-project.org>; Thu,  2 Feb 2012 12:17:57 +0100 (CET)
Received: by wgbdt10 with SMTP id dt10so1913257wgb.25
	for <alsa-devel@alsa-project.org>; Thu, 02 Feb 2012 03:17:54 -0800 (PST)
In-Reply-To: <CABS+qY2GADPO+wkmDf5hzT7uaH7v1zNrdAGKnLbip-QAL8V_RQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 2012-02-01 at 11:50 +0000, Girdwood, Liam wrote:
> On 1 February 2012 09:07, Vinod Koul <vinod.koul@linux.intel.com> wrote:
> > On Wed, 2012-01-25 at 17:07 +0000, Liam Girdwood wrote:
> >> We could eventually remove steps 2 and 4 for the FE DAI link, and look
> >> at hard coding the hw_params() in the mach driver for the loopback
> >> link.
> >> That way the only user space driven actions would be to configure the
> >> mixers in the CODEC and DSP for the correct route. DAPM would then
> >> detect the path and Dynamic PCM would use the hard coded configuration
> >> or bespoke mach driver logic to configure the loopback DAI link based
> >> on
> >> use case. This would have to be done after the basic Dynamic PCM
> >> infrastructure was upstream though (unless you have a patch atm).
> > Hi,
> > Sorry to join the party late :-)
> >
> 

No worries ;-)

> 
> > Liam, if we configure the hw_params in the machine driver statically,
> > represent the DSP using a map along with a codec kind of modeling.
> >

In OMAP we reconfigure (or fixup) some of the hw_params() in the machine
driver for a BE DAI link that cant operate at the requested FE params.
The ABE takes care of any conversion though. 

> > Would the BEs be triggered on from soc_dsp_runtime_update() when the
> > loopback is established thru the DSP.
> > This way we avoid all the "virtual" FEs. Use loopback to turn on codec
> > and DSP (thru BEs)
> >
> > Would this make sense, or I need more coffee :)

In the code base atm we have to use a FE pcm to trigger the BE loopback
DAIs. however, the intention is to use Mark's CODEC <-> CODEC DAI link
work to support the loopback with hard coded params in the machine
driver. This would save the need for any FE pcm operations.

Regards

Liam

> >
> > --
> > ~Vinod
> >
> 
