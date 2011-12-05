From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Provide a more complete DMA driver
	stub
Date: Mon, 5 Dec 2011 23:19:46 +0000
Message-ID: <20111205231946.GB21083@opensource.wolfsonmicro.com>
References: <1323118585-18216-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1323122570.8134.1.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 803D224392
	for <alsa-devel@alsa-project.org>; Tue,  6 Dec 2011 00:19:49 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1323122570.8134.1.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 05, 2011 at 10:02:50PM +0000, Liam Girdwood wrote:
> On Mon, 2011-12-05 at 20:56 +0000, Mark Brown wrote:
> > Allow userspace applications to do more parameter setting by providing a
> > more complete stub DMA driver specifying a wildcard set of formats and
> > channels and essentially random values for the DMA parameters. This is
> > required for useful runtime operation of the dummy DMA driver until we
> > are able to figure out how to power up links and do hw_params() from DAPM.

> Is this also intended to be used for hostless DAI links e.g.

> MODEM <-> MCBSP <-> DSP

It's for any sort of link that doesn't go through a DMA controller the
kernel can see - this is the DMA driver that gets stubbed in when the
DAI doesn't have a DMA driver.  In the case above I guess it depends on
if the DMA controller is hidden by the DSP or not.
