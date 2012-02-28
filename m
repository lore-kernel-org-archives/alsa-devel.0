From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 4/6] ASoC: fsl: create fsl_utils to
 accommodate the common functions
Date: Tue, 28 Feb 2012 10:51:09 -0600
Message-ID: <4F4D05FD.5000401@freescale.com>
References: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
	<1330092582-21180-1-git-send-email-shawn.guo@linaro.org>
	<1330092582-21180-5-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from VA3EHSOBE003.bigfish.com (va3ehsobe006.messaging.microsoft.com
	[216.32.180.16]) by alsa0.perex.cz (Postfix) with ESMTP id 0F35E246AE
	for <alsa-devel@alsa-project.org>; Tue, 28 Feb 2012 17:51:22 +0100 (CET)
In-Reply-To: <1330092582-21180-5-git-send-email-shawn.guo@linaro.org>
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

> +EXPORT_SYMBOL_GPL(fsl_asoc_get_codec_dev_name);

Please use EXPORT_SYMBOL() instead of EXPORT_SYMBOL_GPL().  Freescale does
not want to impose license restrictions on its customers.

Also, I think there's a bug in this function that I never got around to
fixing.  I think you need to call put_device() somewhere.
of_find_i2c_device_by_node() calls bus_find_device(), which calls
get_device(), which increments the reference count.

-- 
Timur Tabi
Linux kernel developer at Freescale
