From: Tabi Timur-B04825 <B04825@freescale.com>
Subject: Re: [PATCH 03/20] ARM: imx: merge audmux-v1 and
	audmux-v2
Date: Mon, 5 Mar 2012 00:22:07 +0000
Message-ID: <4F54072E.6040407@freescale.com>
References: <1330788001-10158-1-git-send-email-shawn.guo@linaro.org>
	<1330788001-10158-4-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from db3outboundpool.messaging.microsoft.com
	(db3ehsobe004.messaging.microsoft.com [213.199.154.142])
	by alsa0.perex.cz (Postfix) with ESMTP id 9440224425
	for <alsa-devel@alsa-project.org>; Mon,  5 Mar 2012 01:22:15 +0100 (CET)
In-Reply-To: <1330788001-10158-4-git-send-email-shawn.guo@linaro.org>
Content-Language: en-US
Content-ID: <7E909103AFC10D4F8857FA1F716BDE88@mgd.freescale.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tabi Timur-B04825 <B04825@freescale.com>, Sascha Hauer <s.hauer@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

Shawn Guo wrote:
> +static unsigned char port_mapping[] = {
> +	0x0, 0x4, 0x8, 0x10, 0x14, 0x1c,
> +};

May as well make this a 'const' array while you're at it.  And perhaps 
uint8_t is a better choice than "unsigned char".

-- 
Timur Tabi
Linux kernel developer at Freescale
