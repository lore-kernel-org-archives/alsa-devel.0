From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 02/19] ASoC: sst_platform: add cpu dai
 driver for moorestown platform
Date: Thu, 5 May 2011 09:05:56 +0100
Message-ID: <20110505080556.GA11744@opensource.wolfsonmicro.com>
References: <20110504133756.32443.6282.stgit@localhost>
	<20110504134504.32443.60814.stgit@localhost>
	<1304565781.20953.41.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DE94F10393D
	for <alsa-devel@alsa-project.org>;
	Thu,  5 May 2011 10:06:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1304565781.20953.41.camel@vkoul-udesk3>
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

On Thu, May 05, 2011 at 08:53:01AM +0530, Koul, Vinod wrote:

> Nope, We cant keep on adding these DAIs for every new platform :(
> Even the current way is not best as it just creates 4 instance of DAI
> where we could have done with two (as they have same properties)
> I would use the current headset DAI and change the ops there, or create
> a new one for each type so that it can be reused.

What does this DAI actually represent?  I'd assume from the description
that it's another interface on the same CPU?
