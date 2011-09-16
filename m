From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] [v2] ASoC: support all possible sample
 rates in the WM8776 driver
Date: Fri, 16 Sep 2011 17:48:39 +0100
Message-ID: <20110916164838.GF23727@opensource.wolfsonmicro.com>
References: <1316182614-9666-1-git-send-email-timur@freescale.com>
	<20110916164412.GD23727@opensource.wolfsonmicro.com>
	<4E737D89.9060900@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 69285103923
	for <alsa-devel@alsa-project.org>;
	Fri, 16 Sep 2011 18:48:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4E737D89.9060900@freescale.com>
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
Cc: alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 16, 2011 at 11:47:05AM -0500, Timur Tabi wrote:
> Mark Brown wrote:
> > No, it doesn't - it just blindly stores the sample rate in the private
> > data.  There's no list at all there, the only checking that's done is
> > for the DAI ID.

> Wait, what?  This is the list I am talking about:

> #define WM8776_RATES (SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 |\
> 		      SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_88200 |\
> 		      SNDRV_PCM_RATE_96000)

> Is this not a list of sample rates that the driver says it supports?

It is.  It's not referenced at all in set_sysclk().
