From: "Koul, Vinod" <vinod.koul@intel.com>
Subject: Re: asoc SND_SOC_DAPM_AIF_IN question
Date: Thu, 23 Dec 2010 18:31:08 +0530
Message-ID: <438BB0150E931F4B9CE701519A44630104C104C6B6@bgsmsx502.gar.corp.intel.com>
References: <438BB0150E931F4B9CE701519A44630104C104C2AA@bgsmsx502.gar.corp.intel.com>
	<20101222175503.GA27401@opensource.wolfsonmicro.com>
	<438BB0150E931F4B9CE701519A44630104C104C329@bgsmsx502.gar.corp.intel.com>
	<20101223112828.GA14481@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id AE05F1037FB
	for <alsa-devel@alsa-project.org>; Thu, 23 Dec 2010 14:01:13 +0100 (CET)
In-Reply-To: <20101223112828.GA14481@opensource.wolfsonmicro.com>
Content-Language: en-US
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Harsha,
	Priya" <priya.harsha@intel.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

> "Audio Supply" sounds like the main analogue bias for the CODEC - that
> would normally be managed by set_bias_level() rather than by having it
> supply every single widget in the CODEC map.
Yes that would make sense. But only for Audio rail which is global codec rail.
What do you recommend for headset and speaker rails? They would be required only for headset and speaker DAI not rest.

> If you have multiple links between the CPU and the CODEC with a single
> power bit to control them all I'd suggest defining several AIF widgets,
> each with no power management, then making the actual power controlled
> by a supply widget.  That way the power will be enabled as required but
> you won't have tied all the data streams together in the DAPM map.
Okay so then why should I do with several AIF widgets, wont doing that in DAI startup be a better idea?

> > Here I was trying
> > 1) Putting the PCM_In Button as SND_SOC_DAPM_AIF_IN()
> 
> I'm still not sure what you mean by "Button"?  I'm guessing it's a
> register control for power.
Yes :)

~Vinod
