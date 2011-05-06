From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 02/19] ASoC: sst_platform: add cpu dai
 driver for moorestown platform
Date: Fri, 6 May 2011 10:37:14 +0100
Message-ID: <20110506093713.GA23729@opensource.wolfsonmicro.com>
References: <20110504133756.32443.6282.stgit@localhost>
	<20110504134504.32443.60814.stgit@localhost>
	<1304565781.20953.41.camel@vkoul-udesk3>
	<20110505080556.GA11744@opensource.wolfsonmicro.com>
	<1304587732.20953.50.camel@vkoul-udesk3>
	<20110505102642.GJ11744@opensource.wolfsonmicro.com>
	<1304589659.20953.52.camel@vkoul-udesk3>
	<20110505134644.GL11744@opensource.wolfsonmicro.com>
	<1304607343.20953.54.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4638524154
	for <alsa-devel@alsa-project.org>;
	Fri,  6 May 2011 11:37:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1304607343.20953.54.camel@vkoul-udesk3>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Koul, Vinod" <vinod.koul@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA <alsa-devel@alsa-project.org>, "Lu,
	Guanqun" <guanqun.lu@intel.com>, Liam Girdwood <lrg@ti.com>, "Wang, Xingchao" <xingchao.wang@intel.com>
List-Id: alsa-devel@alsa-project.org

On Thu, May 05, 2011 at 08:25:43PM +0530, Koul, Vinod wrote:
> On Thu, 2011-05-05 at 19:16 +0530, Mark Brown wrote:

> > OK, DAIs make sense then - I'd been concerned that these weren't fixed
> > and might need to be virtualised.

> So how do we go about making them virtual? Thaat might be useful for
> some other things I had in mind...

You don't currently.  The long term plan is to add support for this for
DSPs and so on but it requires a bunch of framework work.
