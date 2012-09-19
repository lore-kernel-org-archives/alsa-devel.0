From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 16/34] ASoC: imx-ssi: remove unneeded
 mach/hardware.h inclusion
Date: Tue, 18 Sep 2012 23:23:38 -0400
Message-ID: <20120919032337.GU8832@opensource.wolfsonmicro.com>
References: <1347860103-4141-1-git-send-email-shawn.guo@linaro.org>
 <1347860103-4141-17-git-send-email-shawn.guo@linaro.org>
 <20120917114543.GG5401@opensource.wolfsonmicro.com>
 <201209171430.35804.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C787D26516E
 for <alsa-devel@alsa-project.org>; Wed, 19 Sep 2012 05:23:50 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <201209171430.35804.arnd@arndb.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Sascha Hauer <s.hauer@pengutronix.de>, Rob Herring <rob.herring@calxeda.com>, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 17, 2012 at 02:30:35PM +0000, Arnd Bergmann wrote:
> On Monday 17 September 2012, Mark Brown wrote:
> > On Mon, Sep 17, 2012 at 01:34:45PM +0800, Shawn Guo wrote:

> > >  #include <linux/platform_data/asoc-imx-ssi.h>
> > > -#include <mach/hardware.h>

> > This doesn't apply - there's no platform data header for imx-ssi at the
> > minute (and I don't see a patch in this series related to that in the
> > series).  I checked -next and there doesn't seem to be anything via a
> > non-ASoC tree either.

> It's in my testing/platform-data series, and will be in linux-next in
> a few days.

Hrm, that seems odd - why are we adding platform data to the driver?
