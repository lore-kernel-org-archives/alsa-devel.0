From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 1/2] ASoC: omap-mcbsp: Use DMA packet mode
 for non mono streams on OMAP3+
Date: Fri, 16 Mar 2012 14:06:34 +0200
Message-ID: <4F632CCA.5010407@ti.com>
References: <1331807834-25675-1-git-send-email-peter.ujfalusi@ti.com>
	<1331807834-25675-2-git-send-email-peter.ujfalusi@ti.com>
	<4F62E4FC.1020303@bitmer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from psmtp.com (na3sys009aog136.obsmtp.com [74.125.149.85])
	by alsa0.perex.cz (Postfix) with ESMTP id 9318A2447C
	for <alsa-devel@alsa-project.org>; Fri, 16 Mar 2012 13:06:53 +0100 (CET)
Received: by mail-lb0-f170.google.com with SMTP id gg13so4698927lbb.1
	for <alsa-devel@alsa-project.org>; Fri, 16 Mar 2012 05:06:37 -0700 (PDT)
In-Reply-To: <4F62E4FC.1020303@bitmer.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Hi Jarkko,

On 03/16/2012 09:00 AM, Jarkko Nikula wrote:
> Out of curiosity, I guess this will decrease a memory bus or DMA
> controller load a bit.

Yes it will slightly decrease the load on those. It will also decrease
the number of DMA requests going from McBSP to the sDMA controller.

> Can you see any difference with the SW tools
> (top, etc) under some system load or do you need some on-chip
> observability to be able to measure effect of this transfer pattern chang=
e?

I can not see difference between the old
element/packet-element/threshold mode from user space point of view.
I think the effect can be seen in an optimized system more.
The decreased load on SDRAM/sDMA should help with the performance, less
DMA request means less frequent activity, which should decrease power
consumption.

Other good thing might be is that now the DMA moves in sample steps, and
not in words.

-- =

P=E9ter
