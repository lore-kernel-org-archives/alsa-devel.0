From: =?ISO-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v3 0/5] MFD/input/ASoC: twl6040: irq
	registration changes
Date: Wed, 6 Jul 2011 22:45:37 +0300
Message-ID: <2691573.u38zO5bac0@barack>
References: <1309895376-17446-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id B80AF24447
	for <alsa-devel@alsa-project.org>;
	Wed,  6 Jul 2011 21:45:46 +0200 (CEST)
In-Reply-To: <1309895376-17446-1-git-send-email-peter.ujfalusi@ti.com>
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
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Balbi, Felipe" <balbi@ti.com>, "Lopez Cruz,
	Misael" <misael.lopez@ti.com>, "Girdwood, Liam" <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Hi Samuel, Dmitry,

would you be able to take a look at this series?

Thank you,
P=E9ter

On Tuesday 05 July 2011 21:49:31 Ujfalusi, Peter wrote:
> Hello,
> =

> Changes since v2:
> - Fix the check in the slaves driver for the validity of the received irq
> - Mark Brown's ack added to patch 3
> =

> Intro mail froim v1:
> As Samuel, and Felipe requested for the twl6040 MFD series:
> http://marc.info/?l=3Dlinux-kernel&m=3D130978512225430&w=3D2
> http://marc.info/?l=3Dlinux-omap&m=3D130978403224218&w=3D2
> =

> This is the update to remove the obfuscation around the threaded irq requ=
est
> in the twl6040 driver and it's slaves.
> =

> With this change the slaves uses directly the threaded irq request, and t=
he
> core driver passes the irq number for the slaves to use (configured runti=
me,
> so machine drivers do not need to be updated).
> =

> Regards,
> Peter
> =

> PS: for the remaining comments from Samuel I have changed the series, sin=
ce
> the requested change was small.
> I'm not intended to send the series again, unless it is requested (again =
the
> change from v6 is minimal - few lines has been removed/replaced).
> =

> ---
> Peter Ujfalusi (5):
>   MFD: twl6040: Use resource to provide irq number for slaves
>   input: twl6040-vibra: Do not use wrapper for irq request
>   ASoC: twl6040: Do not use wrapper for irq request
>   MFD: twl6040: Demand valid interrupt configuration
>   MFD: twl6040: Remove wrapper for threaded irq request
> =

>  drivers/input/misc/twl6040-vibra.c |   17 ++++++---
>  drivers/mfd/twl6040-core.c         |   69
> ++++++++++++++++++++++++----------- drivers/mfd/twl6040-irq.c          |  =

> 16 +--------
>  include/linux/mfd/twl6040.h        |   22 -----------
>  sound/soc/codecs/twl6040.c         |   19 +++++++---
>  5 files changed, 74 insertions(+), 69 deletions(-)
