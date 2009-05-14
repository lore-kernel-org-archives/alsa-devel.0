From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/1] ASoC: TWL4030: Wait RAMP_DELAY
	on	headsetl_event: POST_PMD
Date: Thu, 14 May 2009 10:24:55 +0100
Message-ID: <20090514092455.GB4917@rakim.wolfsonmicro.main>
References: <1242040465-10835-1-git-send-email-peter.ujfalusi@nokia.com>
	<200905140827.11625.peter.ujfalusi@nokia.com>
	<20090514090808.14c0dfda.jhnikula@gmail.com>
	<200905141109.09084.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 645B6243B9
	for <alsa-devel@alsa-project.org>;
	Thu, 14 May 2009 11:24:56 +0200 (CEST)
Content-Disposition: inline
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
Cc: "sakoman@gmail.com" <sakoman@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "getarunks@gmail.com" <getarunks@gmail.com>, "anuj.aggarwal@ti.com" <anuj.aggarwal@ti.com>
List-Id: alsa-devel@alsa-project.org

On Thu, May 14, 2009 at 11:09:08AM +0300, Peter Ujfalusi wrote:

> If the order of the startup can be somehow altered to be:
> dac -> PGA -> HS ramp up (HS enable, fake PGA)

Looking at that (without any reference to the TWL4030 itself) I would do
this by having the headset ramp up be handled by an POST_PMU event on
the PGA.
