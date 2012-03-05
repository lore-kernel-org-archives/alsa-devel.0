From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH v2 17/17] ASoC: fsl: add imx-sgtl5000
	machine driver
Date: Mon, 5 Mar 2012 15:08:06 -0600
Message-ID: <4F552B36.9020708@freescale.com>
References: <1330957865-19085-1-git-send-email-shawn.guo@linaro.org>
	<1330957865-19085-18-git-send-email-shawn.guo@linaro.org>
	<20120305174232.GA3852@pengutronix.de>
	<CAKGA1bn7y8xQn-o=8CZj5nwcvaBvHwxqM0Q2wzFAwJsSgi1sfA@mail.gmail.com>
	<20120305204456.GC3224@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from db3outboundpool.messaging.microsoft.com
	(db3ehsobe003.messaging.microsoft.com [213.199.154.141])
	by alsa0.perex.cz (Postfix) with ESMTP id 7D21310444F
	for <alsa-devel@alsa-project.org>; Mon,  5 Mar 2012 22:08:23 +0100 (CET)
In-Reply-To: <20120305204456.GC3224@opensource.wolfsonmicro.com>
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
Cc: Matt Sealey <matt@genesi-usa.com>, Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:

> That would be *really* bad, simultaneous playback and record is very
> widely used.

Especially since I already have that working on PowerPC.  I went through
great lengths to get the device tree binding and the code working in this
regard.

> If the hardware has constraints on the sample rates the driver should be
> telling the application about this.  For the very common case where you
> need the same rate for playback and record there's framework support for
> doing this, the relevant driver just needs to set the symmetric_rates
> flag and the core will do everything.  

And my driver currently does this.  If the SSI is wired up in synchronous
mode, sample rate/size locking is enabled.

-- 
Timur Tabi
Linux kernel developer at Freescale
