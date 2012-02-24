From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 6/6] ASoC: fsl: check property 'compatible'
 for the machine name
Date: Fri, 24 Feb 2012 10:32:50 -0600
Message-ID: <4F47BBB2.7090100@freescale.com>
References: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
	<1330092582-21180-1-git-send-email-shawn.guo@linaro.org>
	<1330092582-21180-7-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from TX2EHSOBE004.bigfish.com (tx2ehsobe004.messaging.microsoft.com
	[65.55.88.14]) by alsa0.perex.cz (Postfix) with ESMTP id C2B2F103C54
	for <alsa-devel@alsa-project.org>; Fri, 24 Feb 2012 17:32:57 +0100 (CET)
In-Reply-To: <1330092582-21180-7-git-send-email-shawn.guo@linaro.org>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Shawn Guo wrote:
> It seems the fsl_ssi PowerPC users, machine mpc8610_hpcd and p1022ds,
> basically have the same thing in model and compatible properties.
> Detecting machine name using compatible property becomes a solution
> working for both PowerPC and ARM users of fsl_ssi.

Do you actually have an 8610 or P1022 to test this?  I'm guessing the
answer is no.

-- 
Timur Tabi
Linux kernel developer at Freescale
