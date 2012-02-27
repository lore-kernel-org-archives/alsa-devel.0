From: Mika Westerberg <mika.westerberg@iki.fi>
Subject: Re: [RFC 7/7] ASoC: ep93xx-pcm: Use dmaengine PCM
	helper functions
Date: Mon, 27 Feb 2012 10:19:33 +0200
Message-ID: <20120227081933.GA3868@mwesterb-mobl.ger.corp.intel.com>
References: <1329904151-5927-1-git-send-email-lars@metafoo.de>
	<1329904151-5927-8-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lpp01m010-f51.google.com (mail-lpp01m010-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id 2EA71245F8
	for <alsa-devel@alsa-project.org>; Mon, 27 Feb 2012 09:20:22 +0100 (CET)
Received: by laap9 with SMTP id p9so1682591laa.38
	for <alsa-devel@alsa-project.org>; Mon, 27 Feb 2012 00:20:21 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1329904151-5927-8-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Vinod Koul <vinod.koul@linux.intel.com>, Russell King <linux@arm.linux.org.uk>, Ryan Mallon <rmallon@gmail.com>, alsa-devel@alsa-project.org, Sascha Hauer <s.hauer@pengutronix.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Wolfram Sang <w.sang@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 22, 2012 at 10:49:11AM +0100, Lars-Peter Clausen wrote:
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

For some reason, this doesn't work on my ep93xx based Sim.One board. On
playback with mpg123 when I press stop, it continues to play whatever was on
the ring-buffer forever. Without the patches it works fine.

I'll try to find some time to debug this further.
