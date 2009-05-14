From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/1] ASoC: TWL4030: Wait RAMP_DELAY
	on	headsetl_event: POST_PMD
Date: Thu, 14 May 2009 10:56:21 +0100
Message-ID: <20090514095621.GA6823@rakim.wolfsonmicro.main>
References: <1242040465-10835-1-git-send-email-peter.ujfalusi@nokia.com>
	<200905141109.09084.peter.ujfalusi@nokia.com>
	<20090514092455.GB4917@rakim.wolfsonmicro.main>
	<200905141248.49418.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 788CF243BF
	for <alsa-devel@alsa-project.org>;
	Thu, 14 May 2009 11:56:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200905141248.49418.peter.ujfalusi@nokia.com>
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
Cc: "sakoman@gmail.com" <sakoman@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "getarunks@gmail.com" <getarunks@gmail.com>, "anuj.aggarwal@ti.com" <anuj.aggarwal@ti.com>
List-Id: alsa-devel@alsa-project.org

On Thu, May 14, 2009 at 12:48:49PM +0300, Peter Ujfalusi wrote:

> This is not really possible with the twl4030 codec.
> For simplicity, let's take the Audio left2 route:
> DACL2 -> PGAL2 ---> PreDriveL
>                 |-> PreDriveR
>                 |-> HeadsetL
>                 |-> CarkitL
>                 |-> HandsFreeL
>                 |-> HandsFreeR
>                 \-> Earpiece

> At least the Headset and HandsFree needs special mantra for the pop removal.
> If the Headset is not connected/used than there is no need to do the HS pop 
> attenuation.

The event could check the current setup and do whatever's appropriate?

BTW, since you're saying the required ramp time is clock dependent
shouldn't it also be possible to configure the ramp time automatically
based on the clock that's been configured?
