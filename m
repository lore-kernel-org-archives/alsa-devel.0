From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re:
 =?iso-8859-1?q?=5BPATCH_0/2_take2=5D_SoC=3A_TWL4030_?=
 =?iso-8859-1?q?and_SDP3430_HS_ramp=09configuration?=
Date: Fri, 22 May 2009 12:57:23 +0300
Message-ID: <200905221257.23887.peter.ujfalusi@nokia.com>
References: <1242976396-7667-1-git-send-email-peter.ujfalusi@nokia.com>
	<20090522092807.GA20887@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 19FD91038F6
	for <alsa-devel@alsa-project.org>;
	Fri, 22 May 2009 11:57:43 +0200 (CEST)
In-Reply-To: <20090522092807.GA20887@rakim.wolfsonmicro.main>
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

On Friday 22 May 2009 12:28:07 ext Mark Brown wrote:
> I've applied both.  It'd be really good if you could look into
> converting the TWL4030 driver into a regular platform driver, probing
> via the normal methods, so it could get this data as regular platform
> data.

Thanks, any pointers for such an implementation?

Do we need to convert the codec driver(s) to use the =

platform_device_register/platform_driver_register, or is it more feasible t=
o =

convert the platform drivers (for example sound/soc/omap/omap3beagle.c)?

-- =

P=E9ter
