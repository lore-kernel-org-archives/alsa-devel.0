From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 2/3] ARM: dts: mx28: Provide a codec clock
Date: Tue, 25 Jun 2013 22:22:58 +0800
Message-ID: <20130625142257.GE12178@S2101-09.ap.freescale.net>
References: <1372168801-4221-1-git-send-email-fabio.estevam@freescale.com>
 <1372168801-4221-2-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
 by alsa0.perex.cz (Postfix) with ESMTP id 7E815265274
 for <alsa-devel@alsa-project.org>; Tue, 25 Jun 2013 16:22:33 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1372168801-4221-2-git-send-email-fabio.estevam@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: marex@denx.de, alsa-devel@alsa-project.org, broonie@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 25, 2013 at 11:00:00AM -0300, Fabio Estevam wrote:
> Since commit 9e13f345887 (ASoC: sgtl5000: Let the codec acquire its clock) it is 
> necessary to pass a codec clock to the sgtl5000 driver.
> 
> Since the saif mclk cannot be passed as a real clock within the clock framework,
> let's pass a dummy one to the codec driver.
> 
Why can not saif driver register the mclk to clock framework?

Shawn

> The mxs-saif driver will activate the codec clock.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
