From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 06/12] imx-ssi sound driver
Date: Sat, 28 Nov 2009 16:00:47 -0600
Message-ID: <4B119D8F.3030509@freescale.com>
References: <1258645706-9071-1-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-2-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-3-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-4-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-5-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-6-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-7-git-send-email-s.hauer@pengutronix.de>
	<ed82fe3e0911211812i49342b0eg2afe861c866db90c@mail.gmail.com>
	<20091123120000.GC24326@rakim.wolfsonmicro.main>
	<20091123121321.GF30179@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 9E7FD1037E3
	for <alsa-devel@alsa-project.org>; Sat, 28 Nov 2009 23:01:07 +0100 (CET)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	nASM0ng0011218
	for <alsa-devel@alsa-project.org>; Sat, 28 Nov 2009 15:01:00 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id nASM5BMc018747
	for <alsa-devel@alsa-project.org>; Sat, 28 Nov 2009 16:05:11 -0600 (CST)
In-Reply-To: <20091123121321.GF30179@pengutronix.de>
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
>> while the PowerPC one
>> >  is including asm/immap_86xx.h for something.
> This include seems unused. Timur, can you confirm this?

I can confirm that immap_86xx.h is *not* needed for fsl_ssi.c.  When I update 
the driver for the P1022, I'll remove it.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
