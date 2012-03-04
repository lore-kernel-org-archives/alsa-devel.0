From: Tabi Timur-B04825 <B04825@freescale.com>
Subject: Re: [PATCH 15/20] ASoC: fsl: make fsl_ssi driver
 compilable on ARM/IMX
Date: Sun, 4 Mar 2012 23:13:09 +0000
Message-ID: <4F53F704.8080703@freescale.com>
References: <1330788001-10158-1-git-send-email-shawn.guo@linaro.org>
	<1330788001-10158-16-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
	by alsa0.perex.cz (Postfix) with ESMTP id 123E2243EF
	for <alsa-devel@alsa-project.org>; Mon,  5 Mar 2012 00:13:20 +0100 (CET)
In-Reply-To: <1330788001-10158-16-git-send-email-shawn.guo@linaro.org>
Content-Language: en-US
Content-ID: <6C4D1111C148E541B1832F2F89B9C4F6@mgd.freescale.com>
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
> +#ifdef PPC
> +#define read_ssi(addr)		in_be32(addr)
> +#define write_ssi(val, addr)	out_be32(addr, val)
> +#elif defined ARM
> +#define read_ssi(addr)		readl(addr)
> +#define write_ssi(val, addr)	writel(val, addr)
> +#endif

Can you also add an ARM version of clrsetbits_be32()?  Something like this:

#ifdef PPC
#define read_ssi(addr)		in_be32(addr)
#define write_ssi(val, addr)	out_be32(addr, val)
#define write_ssi_mask(addr, clear, set)	clrsetbits_be32(addr, clear, set)
#elif defined ARM
#define read_ssi(addr)		readl(addr)
#define write_ssi(val, addr)	writel(val, addr)
#define write_ssi_mask(addr, clear, set) \
	{ u32 __val; \
	val = readl(&ssi->scr); \
	val = (val & ~(clear) | (set); \
	writel(val, addr)
#endif

-- 
Timur Tabi
Linux kernel developer at Freescale
