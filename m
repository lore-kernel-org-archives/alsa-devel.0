From: Brian Austin <brian.austin@cirrus.com>
Subject: Re: ARM: OMAP: twl-common: Add helper function to
 register the omap-twl4030 audio driver
Date: Wed, 22 Aug 2012 10:18:03 -0500
Message-ID: <alpine.DEB.2.02.1208221008320.24654@heelrod.ad.cirrus.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-673913920-1345648683=:24654"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe005.messaging.microsoft.com [216.32.180.188])
 by alsa0.perex.cz (Postfix) with ESMTP id 6A480266135
 for <alsa-devel@alsa-project.org>; Wed, 22 Aug 2012 17:20:28 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: peter.ujfalusi@ti.com, tony@atomide.com, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

--8323329-673913920-1345648683=:24654
Content-Type: text/plain; format=flowed; charset="ISO-8859-7"
Content-Transfer-Encoding: quoted-printable

Hey guys,

This commit 552d9dc316cfedd134ee882cd1ae24ca6934ffc0
breaks the build for OMAP3 Beagelboard. with the following error.

CC      arch/arm/mach-omap2/twl-common.o=20
arch/arm/mach-omap2/twl-common.c:562: error: conflicting types for=20
=A1omap_twl4030_audio_init=A2
arch/arm/mach-omap2/twl-common.h:62: error: previous declaration of=20
=A1omap_twl4030_audio_init=A2 was here
make[1]: *** [arch/arm/mach-omap2/twl-common.o] Error 1
make: *** [arch/arm/mach-omap2] Error 2

You added a redifinition of omap_twl4030_audio_init in twl-common.c=20
with the extra parameter of sysclk, but the header file has the definitio=
n=20
with just the card_name.

I'm not sure which way ya'll wanted to go on this so I didnt submit a=20
patch.  Just letting it be known.

This is off of for-next.

Regards,
Brian
--8323329-673913920-1345648683=:24654
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--8323329-673913920-1345648683=:24654--
