From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH v3 08/11] ASoC: fsl: make fsl_ssi driver
 compilable on ARM/IMX
Date: Thu, 8 Mar 2012 14:13:04 -0600
Message-ID: <4F5912D0.2090800@freescale.com>
References: <1331225990-27308-1-git-send-email-shawn.guo@linaro.org>
	<1331225990-27308-9-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from db3outboundpool.messaging.microsoft.com
	(db3ehsobe002.messaging.microsoft.com [213.199.154.140])
	by alsa0.perex.cz (Postfix) with ESMTP id 33DE51041F1
	for <alsa-devel@alsa-project.org>; Thu,  8 Mar 2012 21:13:20 +0100 (CET)
In-Reply-To: <1331225990-27308-9-git-send-email-shawn.guo@linaro.org>
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
> +static DEFINE_SPINLOCK(ssi_reg_lock);
> +static inline void write_ssi_mask(u32 __iomem *addr, u32 clear, u32 set)
> +{
> +	u32 val;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&ssi_reg_lock, flags);
> +	val = readl(addr);
> +	val = (val & ~clear) | set;
> +	writel(val, addr);
> +	spin_unlock_irqrestore(&ssi_reg_lock, flags);
> +}
> +#endif

I think this spinlock is the wrong approach.  The problem with
read-modify-write is on the function level, not the register level.

-- 
Timur Tabi
Linux kernel developer at Freescale
