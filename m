From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH v2 11/17] ASoC: fsl: create fsl_utils to
 accommodate the common functions
Date: Mon, 5 Mar 2012 09:48:53 -0600
Message-ID: <4F54E065.8060905@freescale.com>
References: <1330957865-19085-1-git-send-email-shawn.guo@linaro.org>
	<1330957865-19085-12-git-send-email-shawn.guo@linaro.org>
	<20120305144920.GR3224@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from am1outboundpool.messaging.microsoft.com
	(am1ehsobe002.messaging.microsoft.com [213.199.154.205])
	by alsa0.perex.cz (Postfix) with ESMTP id 389E6104315
	for <alsa-devel@alsa-project.org>; Mon,  5 Mar 2012 16:49:22 +0100 (CET)
In-Reply-To: <20120305144920.GR3224@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> This doesn't seem at all Freescale specific, it should be a generic
> helper, and in fact there already is one - the machine driver can set
> codec_of_node in the card structure to point to the device node and then
> the core should figure out binding to the device for you.  If it doesn't
> we should fix the core.

Can we do that in another patch set, so that it doesn't hold up Shawn's
work?  All this patch does is move the code from one file to another, so
it's not like he's adding a feature incorrectly.

-- 
Timur Tabi
Linux kernel developer at Freescale
