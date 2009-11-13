From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] soc-core: let suspend/resume not called if
 the card is not instantiated
Date: Fri, 13 Nov 2009 17:04:59 +0000
Message-ID: <20091113170459.GB23607@rakim.wolfsonmicro.main>
References: <1258087878-18679-1-git-send-email-21cnbao@gmail.com>
	<20091113133824.GD21516@rakim.wolfsonmicro.main>
	<3c17e3570911130656v662dccej7d6c67e7eaa65b65@mail.gmail.com>
	<20091113150224.GA23607@rakim.wolfsonmicro.main>
	<3c17e3570911130729xab6a443t5b257c2699dfa169@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 67155243F8
	for <alsa-devel@alsa-project.org>; Fri, 13 Nov 2009 18:05:02 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <3c17e3570911130729xab6a443t5b257c2699dfa169@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Barry Song <21cnbao@gmail.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 13, 2009 at 11:29:39PM +0800, Barry Song wrote:

> The logic seems different: in snd_soc_instantiate_card(), only while
> all cpu DAIs and codec DAIs are found and registered in the system
> except ac97, their probes will be called. Then card->instantiated
> becomes 1.
> A case current codes will cause crash is:
> For a CPU DAI driver based on platform driver, if arch hasn't defined
> the platform device for cpu dai, then cpu dai is not registered and
> initialized in the probe() of its platform driver. Even though its
> instance is in card->dai_link, it doesn't really enter the system. But
> while suspend/resume, its entries will be called too since the call
> doesn't check the existence:

Yes, that can go wrong - but as I say the converse thing can also go
wrong where some but not all of the card has managed to register and the
bits that have managed to register expect to be suspended by the core.

> I think suspend/resume of a DAI can only be called while it really
> exists and can be found in the dai_list, at least.

Checking to see if the device is in the DAI relevant list would work
but...

> So I add a overall condition for soc_suspend/resume just like
> 	if (!card->instantiated)
> 		return 0
> has be done in soc_remove(),  soc_poweroff().

...this is too broad.
