From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re:
 =?iso-8859-1?q?=5BPATCH_0/2_take2=5D_SoC=3A_TWL4030_?=
 =?iso-8859-1?q?and_SDP3430_HS=09ramp=3Fconfiguration?=
Date: Fri, 22 May 2009 16:01:33 +0300
Message-ID: <200905221601.33254.peter.ujfalusi@nokia.com>
References: <1242976396-7667-1-git-send-email-peter.ujfalusi@nokia.com>
	<200905221257.23887.peter.ujfalusi@nokia.com>
	<20090522102355.GD20887@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 3446E10390F
	for <alsa-devel@alsa-project.org>;
	Fri, 22 May 2009 15:01:36 +0200 (CEST)
In-Reply-To: <20090522102355.GD20887@rakim.wolfsonmicro.main>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "sakoman@gmail.com" <sakoman@gmail.com>, "anuj.aggarwal@ti.com" <anuj.aggarwal@ti.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "getarunks@gmail.com" <getarunks@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Friday 22 May 2009 13:23:55 ext Mark Brown wrote:
> On Fri, May 22, 2009 at 12:57:23PM +0300, Peter Ujfalusi wrote:
> > On Friday 22 May 2009 12:28:07 ext Mark Brown wrote:
> > > I've applied both.  It'd be really good if you could look into
> > > converting the TWL4030 driver into a regular platform driver, probing
> > > via the normal methods, so it could get this data as regular platform
> > > data.
> >
> > Thanks, any pointers for such an implementation?
>
> wm8350 and wm8400 are similar chips with audio blocked in with other
> functionality.
>
> > Do we need to convert the codec driver(s) to use the
> > platform_device_register/platform_driver_register, or is it more feasib=
le
> > to convert the platform drivers (for example
> > sound/soc/omap/omap3beagle.c)?
>
> The idea is that the device registration gets done either in arch/arm
> or in drivers/mfd - the intention is to make things look much more like
> the standard device model.  For twl4030 I'd expect it to be done in
> drivers/mfd.

I see.
After a quick check: it needs some modification for the =

include/linux/i2c/twl4030.h:
New struct for the twl4030_codec, adding that to the existing
twl4030_platform_data.

Than modification to drivers/mfd/twl4030-core.c:
Adding the audio codec as new child.
Modifying the arch/arm/mach-omap*/ board files to fill up the new audio cod=
ec =

struct and include it to their twl4030_platform_data.

Than some modification to the twl4030.c codec in sound/soc/codec/

Or something along these lines...

I'll keep this in mind and try to prepare for it in the near future.

Thanks for the clarification,
P=E9ter
