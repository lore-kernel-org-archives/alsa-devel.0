From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH v2 00/17] ASoC: add imx-sgtl5000 machine
 driver working with fsl_ssi
Date: Wed, 7 Mar 2012 17:03:00 -0600
Message-ID: <4F57E924.4050208@freescale.com>
References: <1330957865-19085-1-git-send-email-shawn.guo@linaro.org>
	<4F57CDAC.9030604@freescale.com>
	<20120307210833.GO3107@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
	by alsa0.perex.cz (Postfix) with ESMTP id 91E211039D5
	for <alsa-devel@alsa-project.org>; Thu,  8 Mar 2012 00:03:12 +0100 (CET)
In-Reply-To: <20120307210833.GO3107@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Hauer <s.hauer@pengutronix.de>, Sascha@alsa-project.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> Turn on the debug logging in soc-core.c and it'll chatter away about
> what's up; not finding cards is a perfectly normal thing s we're not too
> verbose.

So it turns out there are a couple problems.

1) This patch is missing:

http://patchwork.ozlabs.org/patch/128533/

Our exalted maintainer apparently forgot to apply this patch in a timely
manner for 3.3, so it probably won't make it.  But that's something I'll
just have to deal with.

2) The p1022_ds.c needs the equivalent of this patch:

http://mailman.alsa-project.org/pipermail/alsa-devel/2011-November/046253.html

I have no idea how the P1022DS ever worked, because the WM8776 driver has
always needed the SND_SOC_DAIFMT_Cxx_xxx macro defined.

Apparently, p1022_ds.c needs to set a value for SND_SOC_DAIFMT_INV_MASK.
I tried SND_SOC_DAIFMT_NB_NF, and that seems to work.

Shawn, I'd make the change myself, but I don't want to step on your toes
while doing it.  Do you want to make it yourself?

-- 
Timur Tabi
Linux kernel developer at Freescale
