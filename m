From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Lockups reading from i.MX51 SSI registers
Date: Fri, 10 Aug 2012 20:50:08 +0100
Message-ID: <20120810195005.GP24328@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 00B262665D0
 for <alsa-devel@alsa-project.org>; Fri, 10 Aug 2012 21:20:24 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>
Cc: Christoph Fritz <chf.fritz@googlemail.com>, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Hi,

I'm trying to use -next to test AC'97 register I/O on an i.MX51 board
but I'm seeing the CPU hang during probe at:

	lreg = (reg & 0x7f) <<  12 ;
	writel(lreg, base + SSI_SACADD);

in imx_ssi_ac97_read().  I'm somewhat suspicious this might be because
the IP block isn't clocked properly, I do notice the recent conversion
to the clock API which looks rather involved but it's possible something
else broke.  Does anyone have any bright ideas what might be going on
here?  The board doesn't have the reste functions defined so this is the
first interaction with the hardware block AFAICT.

Thanks,
Mark
