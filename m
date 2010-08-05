From: Tabi Timur-B04825 <B04825@freescale.com>
Subject: Re: [PATCH] asoc/multi-component: fsl: add support for
	variable SSI FIFO depth
Date: Thu, 5 Aug 2010 09:21:15 -0700
Message-ID: <5610599F537DD74A8D1F5CC946A750730347914F@az33exm25.fsl.freescale.net>
References: <1280952264-21813-1-git-send-email-timur@freescale.com>
	<20100805111010.GA13146@rakim.wolfsonmicro.main>
	<AANLkTinYjH-r3Myv=YavQBS0ULu-T0U4LPscsMOUtujR@mail.gmail.com>
	<20100805135153.GB14470@opensource.wolfsonmicro.com>
	<69A042BE-A5B7-4BD5-91FF-B3F635AF7839@freescale.com>
	<20100805145430.GB26801@opensource.wolfsonmicro.com>
	<5610599F537DD74A8D1F5CC946A750730347914E@az33exm25.fsl.freescale.net>
	<20100805160310.GA17454@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from DB3EHSOBE004.bigfish.com (db3ehsobe004.messaging.microsoft.com
	[213.199.154.142])
	by alsa0.perex.cz (Postfix) with ESMTP id ED6B21038F0
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Aug 2010 18:22:10 +0200 (CEST)
Received: from mail64-db3 (localhost.localdomain [127.0.0.1])	by
	mail64-db3-R.bigfish.com (Postfix) with ESMTP id 4E1A29C012F	for
	<alsa-devel@alsa-project.org>; Thu,  5 Aug 2010 16:22:08 +0000 (UTC)
Received: from DB3EHSMHS006.bigfish.com (unknown [10.3.81.248])	by
	mail64-db3.bigfish.com (Postfix) with ESMTP id C95EB9880B8	for
	<alsa-devel@alsa-project.org>; Thu,  5 Aug 2010 16:21:31 +0000 (UTC)
Received: from az33smr02.freescale.net (az33smr02.freescale.net
	[10.64.34.200])	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP
	id o75GLHwT018674	for <alsa-devel@alsa-project.org>;
	Thu, 5 Aug 2010 09:21:28 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id
	o75GLMpo004734	for <alsa-devel@alsa-project.org>;
	Thu, 5 Aug 2010 11:21:22 -0500 (CDT)
Content-Class: urn:content-classes:message
In-Reply-To: <20100805160310.GA17454@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> This doesn't seem like a hardware issue, it seems like an issue with the
> way we've deployed the device tree.

But the FIFO depth *is* a feature of the hardware.  The SSI on the 8610 has a 
depth of 8, and the SSI on the 1022 is identical in every way except that its 
FIFO depth is 15.  Since the FIFO watermark needs to be programmed based on 
the FIFO depth, the drivers need to know that information.  The only way to 
pass that info to the drivers is via the device tree.

> I'd have strongly expected that the
> device tree was able to incoporate all the properties that are standard
> to the CPU by reference somehow (with that data being distributed
> separately to the per system device tree).

Separately?  Why?  Look at the device trees we have today.  They are full of 
nodes with all sorts of device-specific properties that describe minor 
differences among the devices across various SOCs.

-- 
Timur Tabi
Linux kernel developer
