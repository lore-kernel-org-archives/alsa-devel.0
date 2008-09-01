From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: [PATCH 3/4] ASOC: WM8731 codec: add SPI support as
	well as I2C
Date: Mon, 1 Sep 2008 14:52:08 +0100
Message-ID: <200809011452.08070.gineera@aspect135.co.uk>
References: <1219829968-6431-1-git-send-email-cooloney@kernel.org>
	<1219829968-6431-4-git-send-email-cooloney@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.talktalk.net (smtp-out-3.talktalk.net [62.24.128.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 07519243F4
	for <alsa-devel@alsa-project.org>;
	Mon,  1 Sep 2008 15:46:53 +0200 (CEST)
In-Reply-To: <1219829968-6431-4-git-send-email-cooloney@kernel.org>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Bryan Wu <cooloney@kernel.org>, Cliff Cai <cliff.cai@analog.com>, alsa-devel@alsa-project.org
Cc: liam.girdwood@wolfsonmicro.com, broonie@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

We have just started trying this out as an alternative to i2c, and picked out 
the following:

On Wednesday 27 August 2008 10:39, Bryan Wu wrote:
> -#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
> +#if defined (CONFIG_I2C) || defined (CONFIG_I2C_MODULE) && !defined
> (CONFIG_SND_SOC_WM8731_SPI)

I think this needs extra brackets round the ||'s before the && thus:

> +#if (defined (CONFIG_I2C) || defined (CONFIG_I2C_MODULE)) && !defined
> (CONFIG_SND_SOC_WM8731_SPI)

in order to force use of SPI when (CONFIG_SND_SOC_WM8731_SPI) and (CONFIG_I2C) 
are both defined.  Or have we misunderstood the intention?  This is in 2 
other places also in the patch.

Alan
