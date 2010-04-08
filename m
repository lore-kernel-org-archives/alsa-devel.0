From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] WM8750: Convert to new API
Date: Thu, 8 Apr 2010 15:58:10 +0100
Message-ID: <20100408145809.GB29288@rakim.wolfsonmicro.main>
References: <20100405134106.GC6580@rakim.wolfsonmicro.main>
	<1270738309-4783-1-git-send-email-marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 28500103915
	for <alsa-devel@alsa-project.org>;
	Thu,  8 Apr 2010 16:58:11 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1270738309-4783-1-git-send-email-marek.vasut@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Marek Vasut <marek.vasut@gmail.com>
Cc: alsa-devel@alsa-project.org, eric.y.miao@gmail.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 08, 2010 at 04:51:49PM +0200, Marek Vasut wrote:

> @@ -172,6 +198,10 @@ static int __init jive_init(void)
>  	if (!machine_is_jive())
>  		return 0;
>  
> +	ret = wm8750_i2c_setup();
> +	if (ret != 0)
> +		return ret;
> +

The WM8750 on the JIVE is connected using SPI, not I2C.  You'll want to
CC in the JIVE and S3C maintainer too (Ben Dooks for both).  Looking at
the Jive machine file it's actually registering the SPI device in
arch/arm already so there shouldn't be any need to add any registration
code at all.
