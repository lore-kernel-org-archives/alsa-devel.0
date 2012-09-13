From: Timur Tabi <timur@freescale.com>
Subject: Re: Need help with WM8960
Date: Thu, 13 Sep 2012 11:29:10 -0500
Message-ID: <505209D6.2080206@freescale.com>
References: <5051160C.2010802@freescale.com>
 <20120913024245.GA4467@opensource.wolfsonmicro.com>
 <5051F0F4.5090205@freescale.com> <5051FF73.2030504@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe003.messaging.microsoft.com [65.55.88.13])
 by alsa0.perex.cz (Postfix) with ESMTP id 5BA112625CC
 for <Alsa-devel@alsa-project.org>; Thu, 13 Sep 2012 18:29:22 +0200 (CEST)
In-Reply-To: <5051FF73.2030504@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Timur Tabi wrote:
> +               iprop = of_get_property(np, "wlf,discharge-resistance", &len);
> +               if (iprop && len == sizeof(uint32_t))
> +                       pdata->dres = be32_to_cpup(iprop);

I just noticed that pdata->dres isn't actually used in the driver.  In
fact, I'm also confused by the DISOP bit.  The datasheet says that the
default value of DISOP is 0.  However, the only time we touch register R29
is here:

case SND_SOC_BIAS_STANDBY:
	switch (codec->dapm.bias_level) {
	case SND_SOC_BIAS_PREPARE:
		/* Disable HP discharge */
		snd_soc_update_bits(codec, WM8960_APOP2,
				    WM8960_DISOP | WM8960_DRES_MASK,
				    0);

All we do here is set DISOP and DRES_MASK to 0, which they should already be.

Am I missing something?

-- 
Timur Tabi
Linux kernel developer at Freescale
