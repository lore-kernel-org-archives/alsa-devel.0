From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Question about "trigger"
Date: Mon, 11 Apr 2011 06:50:49 -0700
Message-ID: <20110411135048.GD24973@opensource.wolfsonmicro.com>
References: <w3p1v1dw5lx.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 91A5B10383E
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Apr 2011 16:48:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <w3p1v1dw5lx.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Magnus <magnus.damm@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 08, 2011 at 04:43:22PM +0900, Kuninori Morimoto wrote:

> # insmod snd-soc-ak4642.ko
> # insmod snd-soc-fsi-ak4642.ko
> #
> # aplay sound.wav
> # rmmod snd-soc-fsi-ak4642.ko

> I guess noone call soc_pcm_trigger(xx, STOP);
> who should control it ?

I wouldn't 100% rely on that being the case - if the driver is forcibly
removing itself from underneath the subsystem then it's not clear if
this is a useful thing to try to do.  I'd expect that this is something
the ALSA core should do if required.
