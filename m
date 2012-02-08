From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: FW: [PATCH v3] ASoC: Add support for TI LM49453
 Audio codec
Date: Wed, 08 Feb 2012 16:47:00 +0530
Message-ID: <1328699820.21099.12.camel@vkoul-udesk3>
References: <290463D19D2E064191F1F96ECA480A89434AC4A96E@EXMAIL02.scwf.nsc.com>
	<4F323BF5.4010309@ti.com>  <1328692723.3955.4.camel@odin>
	<1328693854.21099.5.camel@vkoul-udesk3> <1328694877.3955.9.camel@odin>
	<1328697415.21099.8.camel@vkoul-udesk3> <1328698650.3955.13.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 7B1E224346
	for <alsa-devel@alsa-project.org>; Wed,  8 Feb 2012 12:14:43 +0100 (CET)
In-Reply-To: <1328698650.3955.13.camel@odin>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, M R Swami Reddy <MR.Swami.Reddy@ti.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 2012-02-08 at 10:57 +0000, Liam Girdwood wrote:
> On Wed, 2012-02-08 at 16:06 +0530, Vinod Koul wrote:
> > On Wed, 2012-02-08 at 09:54 +0000, Liam Girdwood wrote:
> > > Atm, the machine driver would have to enable any system clocks before
> > > the codec driver could use them. 
> > But how would machine driver know _when_?
> > 
> 
> The machine driver gets all the PCM ops that the codec driver does and
> is responsible for configuring CODEC PLLs and clocks (usually in it's
> hw_params()).
> 
> > We want to dynamical turn off this clock when not is use and turn on
> > only when codec is using. So I was thinking of turning this ON in
> > codecs .set_bias_level callback, but how to propagate this into machine
> > driver?
> > 
> 
> It's usually done in the machine driver hw_params() since at this point
> we know the rate, format etc that can have a bearing on the clock
> configuration. You could switch it OFF in machine hw_free().
For DAIs yes. But I also have a Vibra controller on codec, which can be
configured and turned On using alsa controls. I treat the Vibra as input
(or as recoently as Mark has done a signal generator) so mixer
connections ensure loopback from Input to Output and my codec is powered
ON. Those cases DAI doesn't help me.

Possibly a .set_machine_clock_input callback which can be called from
codec driver in .set_bias_level callback?


-- 
~Vinod
