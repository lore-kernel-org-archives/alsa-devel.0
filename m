From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: soc-dsp programming model for loopbacks
Date: Wed, 01 Feb 2012 14:37:11 +0530
Message-ID: <1328087231.1610.28.camel@vkoul-udesk3>
References: <4f1f2489.c602440a.208e.ffff9d7bSMTPIN_ADDED@mx.google.com>
	<1327511249.11901.37.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id C88D5103B5B
	for <alsa-devel@alsa-project.org>; Wed,  1 Feb 2012 10:06:21 +0100 (CET)
In-Reply-To: <1327511249.11901.37.camel@odin>
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

On Wed, 2012-01-25 at 17:07 +0000, Liam Girdwood wrote:
> We could eventually remove steps 2 and 4 for the FE DAI link, and look
> at hard coding the hw_params() in the mach driver for the loopback
> link.
> That way the only user space driven actions would be to configure the
> mixers in the CODEC and DSP for the correct route. DAPM would then
> detect the path and Dynamic PCM would use the hard coded configuration
> or bespoke mach driver logic to configure the loopback DAI link based
> on
> use case. This would have to be done after the basic Dynamic PCM
> infrastructure was upstream though (unless you have a patch atm). 
Hi,
Sorry to join the party late :-)

Liam, if we configure the hw_params in the machine driver statically,
represent the DSP using a map along with a codec kind of modeling.

Would the BEs be triggered on from soc_dsp_runtime_update() when the
loopback is established thru the DSP.
This way we avoid all the "virtual" FEs. Use loopback to turn on codec
and DSP (thru BEs)

Would this make sense, or I need more coffee :)

-- 
~Vinod
