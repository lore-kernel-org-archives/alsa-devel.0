From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 4/4] ASoC: Flag the i.MX SSI driver as
 using symmetric rates
Date: Mon, 11 Jan 2010 09:51:22 -0600
Message-ID: <4B4B48FA.6070402@freescale.com>
References: <1262967598-4096-1-git-send-email-broonie@opensource.wolfsonmicro.com>	
	<1262967598-4096-4-git-send-email-broonie@opensource.wolfsonmicro.com>	
	<20100111112047.GT6923@pengutronix.de>	
	<20100111113631.GE3440@sirena.org.uk>
	<eedb5541001110339s6c7af715g2c95c65ab1028898@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 7FE7D103811
	for <alsa-devel@alsa-project.org>; Mon, 11 Jan 2010 16:51:42 +0100 (CET)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o0BFpNkZ010634
	for <alsa-devel@alsa-project.org>; Mon, 11 Jan 2010 08:51:34 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id o0BFpQO2021545
	for <alsa-devel@alsa-project.org>; Mon, 11 Jan 2010 09:51:26 -0600 (CST)
In-Reply-To: <eedb5541001110339s6c7af715g2c95c65ab1028898@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: javier Martin <javier.martin@vista-silicon.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

javier Martin wrote:
> I think it would be a good idea to add an optional flag to activate
> symmetric rate.

FYI, we already have this on the PowerPC version of the SSI driver.  Asynchronous mode is only supported if the "fsl,ssi-asynchronous" property exists in the device tree.

I think the default should be synchronous unless asynchronous support is specified.

-- 
Timur Tabi
Linux kernel developer at Freescale
