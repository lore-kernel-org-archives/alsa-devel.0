From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH 1/1] ASoC: TWL4030: Wait RAMP_DELAY on
 headsetl_event: POST_PMD
Date: Thu, 14 May 2009 09:08:08 +0300
Message-ID: <20090514090808.14c0dfda.jhnikula@gmail.com>
References: <1242040465-10835-1-git-send-email-peter.ujfalusi@nokia.com>
	<200905131557.09731.peter.ujfalusi@nokia.com>
	<20090513130548.GB10035@sirena.org.uk>
	<200905140827.11625.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f175.google.com (mail-ew0-f175.google.com
	[209.85.219.175])
	by alsa0.perex.cz (Postfix) with ESMTP id 31F02244B3
	for <alsa-devel@alsa-project.org>;
	Thu, 14 May 2009 08:06:19 +0200 (CEST)
Received: by ewy23 with SMTP id 23so1346029ewy.32
	for <alsa-devel@alsa-project.org>; Wed, 13 May 2009 23:06:18 -0700 (PDT)
In-Reply-To: <200905140827.11625.peter.ujfalusi@nokia.com>
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

On Thu, 14 May 2009 08:27:11 +0300
Peter Ujfalusi <peter.ujfalusi@nokia.com> wrote:

> That is why I'm a bit nervous when I need to touch the core... It has
> been working fine for all other codes so far. 
> In the twl4030 codec case, the playback involves the following chain
> in DAPM domain:
> 
> Headset, PreDrive, Carkit, Earpiece:
> DAC -> PGA -> Mixer -> output pin.
> 
> Handsfree:
> DAC -> PGA -> Mux -> output pin.
> 
...
> Is it possible to add several SND_SOC_DAPM_PRE to the DAPM routing?
> For example to the HeadsetL, HeadsetR, HandsFreeL and HandsFreeR? How
> does it than would work?
> If this is possible, than I can handle the correct power up/down
> sequences required for the twl4030 codec.
> 
My two cents: Would it be possible to implement 'fake' PGA or amplifier
into TWL outputs which only controls the power state of mixer and mux?


-- 
Jarkko
