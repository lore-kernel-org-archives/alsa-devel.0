From: "Koul, Vinod" <vinod.koul@intel.com>
Subject: Re: snd_soc_dapm_force_enable_pin question
Date: Fri, 25 Mar 2011 17:50:07 +0530
Message-ID: <1301055607.1695.16.camel@vkoul-udesk3>
References: <1301049930.1695.11.camel@vkoul-udesk3>
	<20110325114050.GC31415@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by alsa0.perex.cz (Postfix) with ESMTP id 7B1E4103A69
	for <alsa-devel@alsa-project.org>; Fri, 25 Mar 2011 13:49:35 +0100 (CET)
In-Reply-To: <20110325114050.GC31415@opensource.wolfsonmicro.com>
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

On Fri, 2011-03-25 at 17:10 +0530, Mark Brown wrote:
> On Fri, Mar 25, 2011 at 04:15:30PM +0530, Koul, Vinod wrote:
> 
> > I have a Vibra controller on the codec which can be programmed using
> > alsa controls. Now after configuration I added an enable control which
> > when turned On, forces the Vibra Pin to be ON. The Pin is on, but not
> > the path, I need the DAC and amplifier connected to be ON as well?
> 
> > Is this not what the force_enable_pin() is supposed to do?
> 
> No, it's there to force a pin to be on when there's no audio path - the
> main use is for microphone biases, to ensure they're enabled in order to
> allow jack detection to work.  The purpose is to ignore routing so it
> won't affect any other widgets.
> 
> > If not how should I ensure this path and codec BIAS is on when Vibra is
> > activated by user?
> 
> Your above scenario sounds like you're just doing a regular playback of
> some kind - if that is the case I'd expect things to power up when you
> start playing through the DAC.
No, its Vibra PWM controller no playback here
> 
> Otherwise I'd suggest creating an input widget, connecting it as an
> input to the DAC and then using regular enable_pin() to enable that and
> the output.
This sounds the way for me, let me try this

Thanks
-- 
~Vinod
