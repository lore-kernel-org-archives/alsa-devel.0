From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] ALSA: ASoc: Add regulator support to
	CS4270 codec driver
Date: Sat, 28 Nov 2009 14:23:20 -0600
Message-ID: <4B1186B8.6070606@freescale.com>
References: <1259159787-21876-1-git-send-email-daniel@caiaq.de>
	<20091125150139.GC636@rakim.wolfsonmicro.main>
	<20091125152052.GM29442@buzzloop.caiaq.de>
	<20091125153804.GA12750@rakim.wolfsonmicro.main>
	<20091126154807.GI14091@buzzloop.caiaq.de>
	<20091126160351.GB10674@rakim.wolfsonmicro.main>
	<20091126174245.GJ14091@buzzloop.caiaq.de>
	<20091127112550.GA29821@rakim.wolfsonmicro.main>
	<20091127124139.GR14091@buzzloop.caiaq.de>
	<20091127133225.GB17711@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	by alsa0.perex.cz (Postfix) with ESMTP id EAA362480D
	for <alsa-devel@alsa-project.org>; Sat, 28 Nov 2009 21:23:23 +0100 (CET)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	nASKNMRW003590
	for <alsa-devel@alsa-project.org>; Sat, 28 Nov 2009 13:23:22 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id nASKRial007203
	for <alsa-devel@alsa-project.org>; Sat, 28 Nov 2009 14:27:44 -0600 (CST)
In-Reply-To: <20091127133225.GB17711@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> Looks good to me, though I suspect Timur will want error checking for
> those enable calls - Timur?

Yes, I'd like to see error checking on those calls, but I'm more concerned 
that I don't see "#ifdef CONFIG_REGULATOR" anywhere in this patch.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
