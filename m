From: Tabi Timur-B04825 <B04825@freescale.com>
Subject: Re: [PATCH] asoc/multi-component: fsl: add support	for
	variable SSI FIFO depth
Date: Thu, 5 Aug 2010 08:14:55 -0700
Message-ID: <5610599F537DD74A8D1F5CC946A750730347914E@az33exm25.fsl.freescale.net>
References: <1280952264-21813-1-git-send-email-timur@freescale.com>
	<20100805111010.GA13146@rakim.wolfsonmicro.main>
	<AANLkTinYjH-r3Myv=YavQBS0ULu-T0U4LPscsMOUtujR@mail.gmail.com>
	<20100805135153.GB14470@opensource.wolfsonmicro.com>
	<69A042BE-A5B7-4BD5-91FF-B3F635AF7839@freescale.com>
	<20100805145430.GB26801@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from TX2EHSOBE008.bigfish.com (tx2ehsobe004.messaging.microsoft.com
	[65.55.88.14]) by alsa0.perex.cz (Postfix) with ESMTP id 61C6D1038EF
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Aug 2010 17:15:16 +0200 (CEST)
Received: from mail159-tx2 (localhost.localdomain [127.0.0.1])	by
	mail159-tx2-R.bigfish.com (Postfix) with ESMTP id 030197F04A5	for
	<alsa-devel@alsa-project.org>; Thu,  5 Aug 2010 15:15:10 +0000 (UTC)
Received: from TX2EHSMHS035.bigfish.com (unknown [10.9.14.250])	by
	mail159-tx2.bigfish.com (Postfix) with ESMTP id 305103E0050	for
	<alsa-devel@alsa-project.org>; Thu,  5 Aug 2010 15:15:10 +0000 (UTC)
Received: from az33smr02.freescale.net (az33smr02.freescale.net
	[10.64.34.200])	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP
	id o75FEvms003910	for <alsa-devel@alsa-project.org>;
	Thu, 5 Aug 2010 08:15:07 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id
	o75FF2Rp013124	for <alsa-devel@alsa-project.org>;
	Thu, 5 Aug 2010 10:15:03 -0500 (CDT)
Content-Class: urn:content-classes:message
In-Reply-To: <20100805145430.GB26801@opensource.wolfsonmicro.com>
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
>> >  The whole point behind having a device tree is to specify device
>> >  information that cannot be probed.  So every piece of information in the
>> >  DT is something that the driver needs to be told because there is no way
>> >  to query the hardware.

> This seems crazy, it means that we're not able to use new support for
> hardware features to the driver which require any kind of flag or data
> without also going through and updating the device trees for all
> existing boards.  That doesn't seem terribly helpful.

Hey, what do you want me to do?  That's just the way the hardware is 
designed.  It is not possible for software to know the FIFO depth of the SSI 
on its own, because there is no register that can be queried.  The device 
tree was designed specifically for this purpose -- the provide a data 
structure (e.g. not kernel code) that describes all of the unprobe-able 
features of the various devices on the SOC.

> I'm fairly sure that some of the previous discussion with other device
> tree people suggested that this was something that there was
> infrastructure to cope with.

I have no idea what you're talking about.

-- 
Timur Tabi
Linux kernel developer
