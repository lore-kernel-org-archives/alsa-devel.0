From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] asoc/multi-component: fsl: add support for
 variable SSI FIFO depth
Date: Thu, 5 Aug 2010 17:03:11 +0100
Message-ID: <20100805160310.GA17454@opensource.wolfsonmicro.com>
References: <1280952264-21813-1-git-send-email-timur@freescale.com>
	<20100805111010.GA13146@rakim.wolfsonmicro.main>
	<AANLkTinYjH-r3Myv=YavQBS0ULu-T0U4LPscsMOUtujR@mail.gmail.com>
	<20100805135153.GB14470@opensource.wolfsonmicro.com>
	<69A042BE-A5B7-4BD5-91FF-B3F635AF7839@freescale.com>
	<20100805145430.GB26801@opensource.wolfsonmicro.com>
	<5610599F537DD74A8D1F5CC946A750730347914E@az33exm25.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8E15D1038E9
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Aug 2010 18:02:57 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <5610599F537DD74A8D1F5CC946A750730347914E@az33exm25.fsl.freescale.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tabi Timur-B04825 <B04825@freescale.com>
Cc: alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 05, 2010 at 08:14:55AM -0700, Tabi Timur-B04825 wrote:
> Mark Brown wrote:

> > This seems crazy, it means that we're not able to use new support for
> > hardware features to the driver which require any kind of flag or data
> > without also going through and updating the device trees for all
> > existing boards.  That doesn't seem terribly helpful.

> Hey, what do you want me to do?  That's just the way the hardware is 
> designed.  It is not possible for software to know the FIFO depth of the SSI 
> on its own, because there is no register that can be queried.  The device 
> tree was designed specifically for this purpose -- the provide a data 
> structure (e.g. not kernel code) that describes all of the unprobe-able 
> features of the various devices on the SOC.

This doesn't seem like a hardware issue, it seems like an issue with the
way we've deployed the device tree.  I'd have strongly expected that the
device tree was able to incoporate all the properties that are standard
to the CPU by reference somehow (with that data being distributed
separately to the per system device tree).
