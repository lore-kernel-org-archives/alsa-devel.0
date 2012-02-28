From: Tabi Timur-B04825 <B04825@freescale.com>
Subject: Re: [PATCH 6/6] ASoC: fsl: check property 'compatible'
 for the machine name
Date: Tue, 28 Feb 2012 02:12:53 +0000
Message-ID: <4F4C3824.90306@freescale.com>
References: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
	<1330092582-21180-1-git-send-email-shawn.guo@linaro.org>
	<1330092582-21180-7-git-send-email-shawn.guo@linaro.org>
	<4F4BFB79.30801@freescale.com>
	<20120228015012.GA13886@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from AM1EHSOBE002.bigfish.com (am1ehsobe002.messaging.microsoft.com
	[213.199.154.205])
	by alsa0.perex.cz (Postfix) with ESMTP id 40D1224345
	for <alsa-devel@alsa-project.org>; Tue, 28 Feb 2012 03:12:59 +0100 (CET)
In-Reply-To: <20120228015012.GA13886@S2101-09.ap.freescale.net>
Content-Language: en-US
Content-ID: <2B5C19422545C34581784312D4CD30BA@mgd.freescale.com>
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
> Since I was asked by Mark to use new binding for new machine driver,
> I would drop this patch and keep PowerPC machine drivers working with
> /model property.

I think Mark is only concerned with not breaking compatibility with 
existing device trees.  Both the P1022 and MPC8610 device trees have had 
this compatible property.

-- 
Timur Tabi
Linux kernel developer at Freescale
