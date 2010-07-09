From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Question about SuperH HDMI sound
Date: Fri, 9 Jul 2010 10:52:59 +0900
Message-ID: <20100709015258.GA7774@opensource.wolfsonmicro.com>
References: <w3p1vbd5wxq.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4B0D72441D
	for <alsa-devel@alsa-project.org>;
	Fri,  9 Jul 2010 03:52:51 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <w3p1vbd5wxq.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Guennadi <g.liakhovetski@gmx.de>
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 09, 2010 at 09:19:24AM +0900, Kuninori Morimoto wrote:

> HDMI "video" support file is under "drivers/video/sh_mobile_hdmi.c"
> Should I add sound support in it ? or under "sound/soc/codecs" ?

One or the other :)

On PCs there is support for HDMI audio within the HDA subsystem so it
would seem reasonable to add the support in ASoC if the hardware shares
anything with the rest of the audio hardware in the SoC.  It may also
make sense to provide a driver which presents both video and audio
interfaces, depending on how the hardware is structured.

If the hardware doesn't share anything with the other audio hardware
then it might be as easy to just implement outside ASoC as a regular
ALSA driver since HDMI "CODECs" are usually the TVs or other remote
devices that are plugged in to the system rather than a component of the
system itself so the CODEC/CPU split of ASoC isn't such a clear benefit.
