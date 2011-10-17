From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3 2/8] ASoC: da7210: Add support for DAPM
Date: Mon, 17 Oct 2011 22:41:07 +0100
Message-ID: <20111017214107.GC5200@opensource.wolfsonmicro.com>
References: <1318590098.12107.509.camel@matrix>
	<20111014192008.GD2931@opensource.wolfsonmicro.com>
	<1318666803.613.21.camel@matrix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id F1A0C103879
	for <alsa-devel@alsa-project.org>;
	Mon, 17 Oct 2011 23:41:09 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1318666803.613.21.camel@matrix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ashish Chavan <ashish.chavan@kpitcummins.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, alsa-devel <alsa-devel@alsa-project.org>, lrg <lrg@ti.com>, "kuninori.morimoto.gx" <kuninori.morimoto.gx@renesas.com>, David Dajun Chen <david.chen@diasemi.com>
List-Id: alsa-devel@alsa-project.org

On Sat, Oct 15, 2011 at 01:50:03PM +0530, Ashish Chavan wrote:

> There are two type of registers for all IOs (HP, MIC, AUX) as well as
> DAC and ADC. One type of registers control individual enable and disable
> of IO, while other set of register controls the standby mode of that
> particular IO. e.g. For ADC,

What are "enable and disable" in this context?  What do they do if not
put the part of the chip into a low power mode?  This is an intriguing
hardware design and it really needs some documentation in the driver,
right now it's just far too obscure and the driver looks buggy on code
inspection.
