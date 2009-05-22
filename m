From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/2 take2] SoC: TWL4030 and SDP3430
	HS	ramp?configuration
Date: Fri, 22 May 2009 11:23:55 +0100
Message-ID: <20090522102355.GD20887@rakim.wolfsonmicro.main>
References: <1242976396-7667-1-git-send-email-peter.ujfalusi@nokia.com>
	<20090522092807.GA20887@rakim.wolfsonmicro.main>
	<200905221257.23887.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 692A91038F6
	for <alsa-devel@alsa-project.org>;
	Fri, 22 May 2009 12:23:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200905221257.23887.peter.ujfalusi@nokia.com>
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
Cc: "sakoman@gmail.com" <sakoman@gmail.com>, "anuj.aggarwal@ti.com" <anuj.aggarwal@ti.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "getarunks@gmail.com" <getarunks@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Fri, May 22, 2009 at 12:57:23PM +0300, Peter Ujfalusi wrote:
> On Friday 22 May 2009 12:28:07 ext Mark Brown wrote:

> > I've applied both.  It'd be really good if you could look into
> > converting the TWL4030 driver into a regular platform driver, probing
> > via the normal methods, so it could get this data as regular platform
> > data.

> Thanks, any pointers for such an implementation?

wm8350 and wm8400 are similar chips with audio blocked in with other
functionality.

> Do we need to convert the codec driver(s) to use the 
> platform_device_register/platform_driver_register, or is it more feasible to 
> convert the platform drivers (for example sound/soc/omap/omap3beagle.c)?

The idea is that the device registration gets done either in arch/arm
or in drivers/mfd - the intention is to make things look much more like
the standard device model.  For twl4030 I'd expect it to be done in
drivers/mfd.
