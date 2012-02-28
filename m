From: Tabi Timur-B04825 <B04825@freescale.com>
Subject: Re: [PATCH 4/6] ASoC: fsl: create fsl_utils to
 accommodate the common functions
Date: Tue, 28 Feb 2012 02:15:14 +0000
Message-ID: <4F4C38B1.2020308@freescale.com>
References: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
	<1330092582-21180-1-git-send-email-shawn.guo@linaro.org>
	<1330092582-21180-5-git-send-email-shawn.guo@linaro.org>
	<4F4BF770.3010205@freescale.com>
	<20120228021520.GC13886@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from AM1EHSOBE003.bigfish.com (am1ehsobe006.messaging.microsoft.com
	[213.199.154.209])
	by alsa0.perex.cz (Postfix) with ESMTP id 3B0DE24345
	for <alsa-devel@alsa-project.org>; Tue, 28 Feb 2012 03:15:21 +0100 (CET)
In-Reply-To: <20120228021520.GC13886@S2101-09.ap.freescale.net>
Content-Language: en-US
Content-ID: <DDCD5CC480792D468B6165B29EC3056D@mgd.freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Sascha Hauer <s.hauer@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

Shawn Guo wrote:

> Since fsl_utils.c is created to accommodate the common functions used
> by mpc8610_hpcd.c and p1022_ds.c, I guess you actually meant something
> like the following?
>
> # MPC8610 HPCD Machine Support
> snd-soc-mpc8610-hpcd-objs := mpc8610_hpcd.o fsl_utils.o
> obj-$(CONFIG_SND_SOC_MPC8610_HPCD) += snd-soc-mpc8610-hpcd.o
>
> # P1022 DS Machine Support
> snd-soc-p1022-ds-objs := p1022_ds.o fsl_utils.o
> obj-$(CONFIG_SND_SOC_P1022_DS) += snd-soc-p1022-ds.o

Yes. :-)

>
> I actually started with doing so, but later changed to make fsl_utils
> as a module.  It seems that mpc8610_hpcd and p1022_ds will not be
> built in a single kernel image, but on ARM/IMX, it's very likely that
> multiple machine drivers will be built in a single image, as the ARM
> community is moving to support single image for multiple SoCs.  In
> that case, fsl_utils can not be linked like that but has to be a module.

Ah yes, good point.

-- 
Timur Tabi
Linux kernel developer at Freescale
