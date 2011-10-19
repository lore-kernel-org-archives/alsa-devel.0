From: Ashish Chavan <ashish.chavan@kpitcummins.com>
Subject: Re: [PATCH v3 2/8] ASoC: da7210: Add support for DAPM
Date: Wed, 19 Oct 2011 12:51:35 +0530
Message-ID: <1319008895.7230.11.camel@matrix>
References: <1318590098.12107.509.camel@matrix>
	<20111014192008.GD2931@opensource.wolfsonmicro.com>
	<1318666803.613.21.camel@matrix>
	<20111017214107.GC5200@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from VA3EHSOBE002.bigfish.com (va3ehsobe002.messaging.microsoft.com
	[216.32.180.12]) by alsa0.perex.cz (Postfix) with ESMTP id CD103243A3
	for <alsa-devel@alsa-project.org>;
	Wed, 19 Oct 2011 09:10:32 +0200 (CEST)
In-Reply-To: <20111017214107.GC5200@opensource.wolfsonmicro.com>
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
Cc: alsa-devel <alsa-devel@alsa-project.org>, "kuninori.morimoto.gx" <kuninori.morimoto.gx@renesas.com>, linux-kernel <linux-kernel@vger.kernel.org>, David@alsa-project.org, Chen <david.chen@diasemi.com>, lrg <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 2011-10-17 at 22:41 +0100, Mark Brown wrote:
> On Sat, Oct 15, 2011 at 01:50:03PM +0530, Ashish Chavan wrote:
> 
> > There are two type of registers for all IOs (HP, MIC, AUX) as well as
> > DAC and ADC. One type of registers control individual enable and disable
> > of IO, while other set of register controls the standby mode of that
> > particular IO. e.g. For ADC,
> 
> What are "enable and disable" in this context?  What do they do if not
> put the part of the chip into a low power mode?  This is an intriguing
> hardware design and it really needs some documentation in the driver,
> right now it's just far too obscure and the driver looks buggy on code
> inspection.
> 

I have queried hardware designers to get more insight in to this and
will update the response here. Probably after that we will be confident
about driver's handling of DAPM.

BTW if in case, hardware designers reiterate to use STANDBY registers,
will it suffice to only document this somewhere is the source?
