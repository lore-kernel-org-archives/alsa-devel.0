From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: asoc SND_SOC_DAPM_AIF_IN question
Date: Thu, 23 Dec 2010 11:28:28 +0000
Message-ID: <20101223112828.GA14481@opensource.wolfsonmicro.com>
References: <438BB0150E931F4B9CE701519A44630104C104C2AA@bgsmsx502.gar.corp.intel.com>
	<20101222175503.GA27401@opensource.wolfsonmicro.com>
	<438BB0150E931F4B9CE701519A44630104C104C329@bgsmsx502.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 22FD6248FD
	for <alsa-devel@alsa-project.org>; Thu, 23 Dec 2010 12:28:17 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <438BB0150E931F4B9CE701519A44630104C104C329@bgsmsx502.gar.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Koul, Vinod" <vinod.koul@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Harsha,
	Priya" <priya.harsha@intel.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 23, 2010 at 08:36:07AM +0530, Koul, Vinod wrote:
> On Wed, Dec 22, 2010 at 11:25:29PM +0530, Mark Brown wrote:

> > These "Rail" widgets look quite unusual - what are they?

> Audio Supply rails, I have one global audio rail which controls most of audio 
> widgets and then separate rails for speakers and headset. For example I need to 
> turn on Audio supply rail and then headset rail for headsets to work properly. 
> So I described them as SND_SOC_DAPM_SUPPLY. Added events so that I power them on 
> and power off when stream becomes active or inactive.

"Audio Supply" sounds like the main analogue bias for the CODEC - that
would normally be managed by set_bias_level() rather than by having it
supply every single widget in the CODEC map.

> > What is a "PCM button" and what do you mean by starting a "stream"?
> > Normally a stream would be a path between the CPU and the CODEC.

> This is PCM interface enable between codec and cpu. So for PCM port to work 
> between codec and cpu, we need to enable the PCM port, this one does 
> that. This is going to be a global switch to be turned on for all streams (I 
> have 4 playback and 1 capture, and can be simultaneous).

If you have multiple links between the CPU and the CODEC with a single
power bit to control them all I'd suggest defining several AIF widgets,
each with no power management, then making the actual power controlled
by a supply widget.  That way the power will be enabled as required but
you won't have tied all the data streams together in the DAPM map.

> Here I was trying 
> 1) Putting the PCM_In Button as SND_SOC_DAPM_AIF_IN()

I'm still not sure what you mean by "Button"?  I'm guessing it's a
register control for power.
