From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 16/34] ASoC: imx-ssi: remove unneeded
 mach/hardware.h inclusion
Date: Wed, 19 Sep 2012 07:44:35 -0400
Message-ID: <20120919114434.GV8832@opensource.wolfsonmicro.com>
References: <1347860103-4141-1-git-send-email-shawn.guo@linaro.org>
 <201209171430.35804.arnd@arndb.de>
 <20120919032337.GU8832@opensource.wolfsonmicro.com>
 <201209190801.23616.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3EAFA262635
 for <alsa-devel@alsa-project.org>; Wed, 19 Sep 2012 13:44:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <201209190801.23616.arnd@arndb.de>
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

On Wed, Sep 19, 2012 at 08:01:23AM +0000, Arnd Bergmann wrote:
> On Wednesday 19 September 2012, Mark Brown wrote:

> > Hrm, that seems odd - why are we adding platform data to the driver?

> We're not adding it, we just rename the header file from mach/imx.h
> to linux/platform-data/asoc-imx-ssi.h, along with 94 other header files
> that get moved to the same directory.

Ah, that stuff.  I'd not really registered it as actually adding
platform data to be honest, obviously the series was too big to read in
detail.
