From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 06/12] imx-ssi sound driver
Date: Sat, 28 Nov 2009 13:53:30 -0600
Message-ID: <4B117FBA.601@freescale.com>
References: <1258645706-9071-1-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-2-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-3-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-4-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-5-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-6-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-7-git-send-email-s.hauer@pengutronix.de>
	<ed82fe3e0911211812i49342b0eg2afe861c866db90c@mail.gmail.com>
	<20091123121055.GE30179@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 05EAD247BA
	for <alsa-devel@alsa-project.org>; Sat, 28 Nov 2009 20:53:52 +0100 (CET)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	nASJrXiL001111
	for <alsa-devel@alsa-project.org>; Sat, 28 Nov 2009 12:53:44 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id nASJwC0t029803
	for <alsa-devel@alsa-project.org>; Sat, 28 Nov 2009 13:58:13 -0600 (CST)
In-Reply-To: <20091123121055.GE30179@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Sascha Hauer wrote:
> Mainly because I wasn't aware of the fact that the fsl driver is the
> same:(

So "fsl-ssi.c" was not a clue? :-)

>
> I'm currently looking if and how the code can be merged. I don't know if
> it's worth it though since the common code doesn't seem to be very big.

That's probably because my driver only supports I2S and yours supports AC97. 
Please, DMA is different.  I wasn't really expecting you to be able to re-use 
my driver, but I figured you could at least re-use the macros I've defined in 
fsl-ssi.h

> There will have to be some changes in the fsl-ssi driver. For example I
> need the irq handler for my fiq handler which means that the fsl-ssi
> driver is not allowed to request the irq for it's statistic.

That shouldn't be a problem, since the statistics never show anything useful 
anyway.

> The other
> thing is the hardware accesses as we do not have in_be*, out_be* and
> setbits/clrbits. Of course all these things are doable and shouldn't be
> a showstopper.

These should be defined in the arch/arm header files anyway.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
