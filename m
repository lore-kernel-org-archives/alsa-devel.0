From: Tabi Timur-B04825 <B04825@freescale.com>
Subject: Re: [PATCH] asoc/multi-component: fsl: add support for
	variable SSI FIFO depth
Date: Thu, 5 Aug 2010 09:10:08 -0500
Message-ID: <69A042BE-A5B7-4BD5-91FF-B3F635AF7839@freescale.com>
References: <1280952264-21813-1-git-send-email-timur@freescale.com>
	<20100805111010.GA13146@rakim.wolfsonmicro.main>
	<AANLkTinYjH-r3Myv=YavQBS0ULu-T0U4LPscsMOUtujR@mail.gmail.com>
	<20100805135153.GB14470@opensource.wolfsonmicro.com>
Mime-Version: 1.0 (iPad Mail 7B405)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from VA3EHSOBE008.bigfish.com (va3ehsobe006.messaging.microsoft.com
	[216.32.180.16])
	by alsa0.perex.cz (Postfix) with ESMTP id A97291038ED
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Aug 2010 16:10:05 +0200 (CEST)
Received: from mail154-va3 (localhost.localdomain [127.0.0.1])	by
	mail154-va3-R.bigfish.com (Postfix) with ESMTP id BDE2317F82FE	for
	<alsa-devel@alsa-project.org>; Thu,  5 Aug 2010 14:10:02 +0000 (UTC)
Received: from VA3EHSMHS019.bigfish.com (unknown [10.7.14.244])	by
	mail154-va3.bigfish.com (Postfix) with ESMTP id 65FAE163804D	for
	<alsa-devel@alsa-project.org>; Thu,  5 Aug 2010 14:10:02 +0000 (UTC)
Received: from az33smr02.freescale.net (az33smr02.freescale.net
	[10.64.34.200])	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP
	id o75E9xEu021330	for <alsa-devel@alsa-project.org>;
	Thu, 5 Aug 2010 07:09:59 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id
	o75EA5YD024201	for <alsa-devel@alsa-project.org>;
	Thu, 5 Aug 2010 09:10:05 -0500 (CDT)
In-Reply-To: <20100805135153.GB14470@opensource.wolfsonmicro.com>
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

On Aug 5, 2010, at 8:52 AM, "Mark Brown" <broonie@opensource.wolfsonmicro.com> wrote:

> Are you saying that every DT for a system doing audio on a PowerPC
> system has to manually specify the depth of the FIFO on the silicon?

Only for SSI devices.

> That doesn't sound particularly sensible, and I had been under the
> impression that DT systems had a better way of coping with this.

The whole point behind having a device tree is to specify device information that cannot be probed.  So every piece of information in the DT is something that the driver needs to be told because there is no way to query the hardware.
> 
