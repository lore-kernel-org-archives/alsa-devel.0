From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re:
 =?iso-8859-1?q?=5BPATCH_1/1=5D_ASoC=3A_TWL4030=3A_Wa?=
 =?iso-8859-1?q?it_RAMP=5FDELAY=09on_headsetl=5Fevent=3A_POST=5FPMD?=
Date: Thu, 14 May 2009 15:44:47 +0300
Message-ID: <200905141544.47934.peter.ujfalusi@nokia.com>
References: <1242040465-10835-1-git-send-email-peter.ujfalusi@nokia.com>
	<200905141248.49418.peter.ujfalusi@nokia.com>
	<20090514095621.GA6823@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 204BF103962
	for <alsa-devel@alsa-project.org>;
	Thu, 14 May 2009 14:44:57 +0200 (CEST)
In-Reply-To: <20090514095621.GA6823@rakim.wolfsonmicro.main>
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
To: alsa-devel@alsa-project.org
Cc: "sakoman@gmail.com" <sakoman@gmail.com>, "anuj.aggarwal@ti.com" <anuj.aggarwal@ti.com>, "getarunks@gmail.com" <getarunks@gmail.com>, ext Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Thursday 14 May 2009 12:56:21 ext Mark Brown wrote:
> On Thu, May 14, 2009 at 12:48:49PM +0300, Peter Ujfalusi wrote:
> > This is not really possible with the twl4030 codec.
> > For simplicity, let's take the Audio left2 route:
> > DACL2 -> PGAL2 ---> PreDriveL
> >
> >                 |-> PreDriveR
> >                 |-> HeadsetL
> >                 |-> CarkitL
> >                 |-> HandsFreeL
> >                 |-> HandsFreeR
> >
> >                 \-> Earpiece
> >
> > At least the Headset and HandsFree needs special mantra for the pop
> > removal. If the Headset is not connected/used than there is no need to =
do
> > the HS pop attenuation.
>
> The event could check the current setup and do whatever's appropriate?

I have to think about this, but at first sight it does look awfully =

complicated thing to do (4 PGA, 7 output with mixers, 2+1 output mux)...

> BTW, since you're saying the required ramp time is clock dependent
> shouldn't it also be possible to configure the ramp time automatically
> based on the clock that's been configured?

The patch that I have sent is calculating the needed delay based on the MCL=
K + =

RAMP_DELAY value.
I think I don't want to fixate the ramp delay to any value (meaning that th=
e =

delay would last around 50ms). This seams to be also board specific, so I =

would rather leave this to the user to find the best value for the given =

board.

-- =

P=E9ter
