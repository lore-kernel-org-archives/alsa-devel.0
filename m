From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] asoc/multi-component: fsl: add support	for
	variable SSI FIFO depth
Date: Thu, 5 Aug 2010 15:54:31 +0100
Message-ID: <20100805145430.GB26801@opensource.wolfsonmicro.com>
References: <1280952264-21813-1-git-send-email-timur@freescale.com>
	<20100805111010.GA13146@rakim.wolfsonmicro.main>
	<AANLkTinYjH-r3Myv=YavQBS0ULu-T0U4LPscsMOUtujR@mail.gmail.com>
	<20100805135153.GB14470@opensource.wolfsonmicro.com>
	<69A042BE-A5B7-4BD5-91FF-B3F635AF7839@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A7B741038F7
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Aug 2010 16:54:32 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <69A042BE-A5B7-4BD5-91FF-B3F635AF7839@freescale.com>
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

On Thu, Aug 05, 2010 at 09:10:08AM -0500, Tabi Timur-B04825 wrote:
> On Aug 5, 2010, at 8:52 AM, "Mark Brown" <broonie@opensource.wolfsonmicro.com> wrote:

> > Are you saying that every DT for a system doing audio on a PowerPC
> > system has to manually specify the depth of the FIFO on the silicon?

> Only for SSI devices.

Right, but that's the audio controller on the overwhelming majority of
PowerPC devices.

> > That doesn't sound particularly sensible, and I had been under the
> > impression that DT systems had a better way of coping with this.

> The whole point behind having a device tree is to specify device
> information that cannot be probed.  So every piece of information in the
> DT is something that the driver needs to be told because there is no way
> to query the hardware.

This seems crazy, it means that we're not able to use new support for
hardware features to the driver which require any kind of flag or data
without also going through and updating the device trees for all
existing boards.  That doesn't seem terribly helpful.

I'm fairly sure that some of the previous discussion with other device
tree people suggested that this was something that there was
infrastructure to cope with.
