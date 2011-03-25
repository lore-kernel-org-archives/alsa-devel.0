From: "Koul, Vinod" <vinod.koul@intel.com>
Subject: Re: snd_soc_dapm_force_enable_pin question
Date: Fri, 25 Mar 2011 18:05:34 +0530
Message-ID: <1301056534.1695.22.camel@vkoul-udesk3>
References: <1301049930.1695.11.camel@vkoul-udesk3>
	<20110325114050.GC31415@opensource.wolfsonmicro.com>
	<1301055607.1695.16.camel@vkoul-udesk3>
	<20110325125612.GD22502@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id A9A831037F3
	for <alsa-devel@alsa-project.org>; Fri, 25 Mar 2011 14:05:13 +0100 (CET)
In-Reply-To: <20110325125612.GD22502@sirena.org.uk>
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
Cc: alsa <alsa-devel@alsa-project.org>, Liam <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, 2011-03-25 at 18:26 +0530, Mark Brown wrote:
> On Fri, Mar 25, 2011 at 05:50:07PM +0530, Koul, Vinod wrote:
> > On Fri, 2011-03-25 at 17:10 +0530, Mark Brown wrote:
> 
> > > Your above scenario sounds like you're just doing a regular playback of
> > > some kind - if that is the case I'd expect things to power up when you
> > > start playing through the DAC.
> 
> > No, its Vibra PWM controller no playback here
> 
> So the DAC gets its input from some internal source?  In that case that
> source maps very directly onto the input widget.
Yes the Vibra PWM controller should be treated as source. ahhhh, this
sounds so obvious in hindsight...

Thanks
-- 
~Vinod
