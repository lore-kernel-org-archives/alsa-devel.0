From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/1] ASoC: TWL4030: Wait RAMP_DELAY
	on	headsetl_event: POST_PMD
Date: Thu, 14 May 2009 10:23:38 +0100
Message-ID: <20090514092338.GA4917@rakim.wolfsonmicro.main>
References: <1242040465-10835-1-git-send-email-peter.ujfalusi@nokia.com>
	<200905131557.09731.peter.ujfalusi@nokia.com>
	<20090513130548.GB10035@sirena.org.uk>
	<200905140827.11625.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B7D5A243B8
	for <alsa-devel@alsa-project.org>;
	Thu, 14 May 2009 11:23:39 +0200 (CEST)
Content-Disposition: inline
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
Cc: "sakoman@gmail.com" <sakoman@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "getarunks@gmail.com" <getarunks@gmail.com>, "anuj.aggarwal@ti.com" <anuj.aggarwal@ti.com>
List-Id: alsa-devel@alsa-project.org

On Thu, May 14, 2009 at 08:27:11AM +0300, Peter Ujfalusi wrote:

> While I was looking at the sequences, I wonder why the mux and mixer handled 
> in a differently?

I'm not aware of any great reason for that; I suspect it's most likely
that muxes are more common on inputs than outputs.

> Is it possible to add several SND_SOC_DAPM_PRE to the DAPM routing? For 
> example to the HeadsetL, HeadsetR, HandsFreeL and HandsFreeR? How does it than 
> would work?

Yes, you can have as many of those as you like.
