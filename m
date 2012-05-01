From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 10/11] ARM: imx6q_sabrelite: clkdev_add
	cko1 for sgtl5000
Date: Wed, 2 May 2012 07:39:41 +0800
Message-ID: <20120501233939.GO2194@S2101-09.ap.freescale.net>
References: <1335510185-7906-1-git-send-email-richard.zhao@freescale.com>
	<1335510185-7906-11-git-send-email-richard.zhao@freescale.com>
	<20120501124706.GF2194@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f51.google.com (mail-pb0-f51.google.com
	[209.85.160.51])
	by alsa0.perex.cz (Postfix) with ESMTP id E7660104343
	for <alsa-devel@alsa-project.org>;
	Wed,  2 May 2012 01:39:51 +0200 (CEST)
Received: by pbbrp16 with SMTP id rp16so201061pbb.38
	for <alsa-devel@alsa-project.org>; Tue, 01 May 2012 16:39:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120501124706.GF2194@S2101-09.ap.freescale.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Richard Zhao <richard.zhao@freescale.com>
Cc: alsa-devel@alsa-project.org, ben-linux@fluff.org, broonie@opensource.wolfsonmicro.com, w.sang@pengutronix.de, linux-i2c@vger.kernel.org, kernel@pengutronix.de, dan.j.williams@intel.com, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Tue, May 01, 2012 at 08:47:10PM +0800, Shawn Guo wrote:
> > +	clk_register_clkdev(cko1, NULL, "0-000a");
> 
> This dev_id looks a little strange to me.  I understand that's the
> consequence of having sgtl5000 clock managed in ASoC machine driver
> imx-sgtl5000.
> 
Just realised it's not the case.  But shouldn't the name look like
"sgtl5000.0-000a"?

-- 
Regards,
Shawn
