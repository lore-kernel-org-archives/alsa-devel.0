From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH 1/1] ASoC: TWL4030: Wait RAMP_DELAY on
 headsetl_event: POST_PMD
Date: Thu, 14 May 2009 12:05:50 +0300
Message-ID: <20090514120550.88494822.jhnikula@gmail.com>
References: <1242040465-10835-1-git-send-email-peter.ujfalusi@nokia.com>
	<200905140827.11625.peter.ujfalusi@nokia.com>
	<20090514090808.14c0dfda.jhnikula@gmail.com>
	<200905141109.09084.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yx-out-1718.google.com (yx-out-1718.google.com [74.125.44.155])
	by alsa0.perex.cz (Postfix) with ESMTP id 6B5E2243A5
	for <alsa-devel@alsa-project.org>;
	Thu, 14 May 2009 11:04:01 +0200 (CEST)
Received: by yx-out-1718.google.com with SMTP id 6so836417yxn.2
	for <alsa-devel@alsa-project.org>; Thu, 14 May 2009 02:03:59 -0700 (PDT)
In-Reply-To: <200905141109.09084.peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: "sakoman@gmail.com" <sakoman@gmail.com>, "anuj.aggarwal@ti.com" <anuj.aggarwal@ti.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, ext Mark Brown <broonie@opensource.wolfsonmicro.com>, "getarunks@gmail.com" <getarunks@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 14 May 2009 11:09:08 +0300
Peter Ujfalusi <peter.ujfalusi@nokia.com> wrote:

> Startup:
> dac -> HS ramp up (HS enable, fake PGA) -> PGA
> 
> Standby:
> HS ramp down (HS disable, fake PGA) -> PGA -> dac
> 
> If the order of the startup can be somehow altered to be:
> dac -> PGA -> HS ramp up (HS enable, fake PGA)
> 
Did you implement this fake or actually real PGA between "HeadsetL
Mixer" and "HSOL"?

I seems that there is an error in audio path that output pin control is
tied to mixer and there is no widget in audio path defining the output
amplifier. See

SND_SOC_DAPM_MIXER_E("HeadsetL Mixer", SND_SOC_NOPM, 0, 0,
	&twl4030_dapm_hsol_controls[0],
	ARRAY_SIZE(twl4030_dapm_hsol_controls), headsetl_event,
	SND_SOC_DAPM_POST_PMU|SND_SOC_DAPM_POST_PMD),
...
	{"HSOL", NULL, "HeadsetL Mixer"},
	{"HSOR", NULL, "HeadsetR Mixer"},

So startup/shutdown order should be correct if you define a new PGA
between the HSOx and Headsetx mixer and let that to manage output pin
power.


-- 
Jarkko
