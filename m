From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] asoc/multi-component: fsl: add support for
 variable SSI FIFO depth
Date: Thu, 5 Aug 2010 06:51:53 -0700
Message-ID: <20100805135153.GB14470@opensource.wolfsonmicro.com>
References: <1280952264-21813-1-git-send-email-timur@freescale.com>
	<20100805111010.GA13146@rakim.wolfsonmicro.main>
	<AANLkTinYjH-r3Myv=YavQBS0ULu-T0U4LPscsMOUtujR@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E41B21038E7
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Aug 2010 15:51:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTinYjH-r3Myv=YavQBS0ULu-T0U4LPscsMOUtujR@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 05, 2010 at 08:14:43AM -0500, Timur Tabi wrote:
> On Thu, Aug 5, 2010 at 6:10 AM, Mark Brown

> > My first thought with this is that it's not something I'd expect to be
> > in the device tree at all - it looks like it's all properties of the
> > silicon which I'd expect the drivers to be able to figure out for
> > themselves without needing to be told by the device tree.

> There is no way for the software to know what the FIFO depth is, so
> this is the sort of thing that should be in the device tree.

Are you saying that every DT for a system doing audio on a PowerPC
system has to manually specify the depth of the FIFO on the silicon?
That doesn't sound particularly sensible, and I had been under the
impression that DT systems had a better way of coping with this.
