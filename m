From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2.6.30] ASoC: fix initialization order of
	the CS4270	codec driver
Date: Fri, 30 Jan 2009 10:52:24 +0000
Message-ID: <20090130105224.GA22201@rakim.wolfsonmicro.main>
References: <1233260917-525-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DEB89243C8
	for <alsa-devel@alsa-project.org>; Fri, 30 Jan 2009 11:52:25 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1233260917-525-1-git-send-email-timur@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 29, 2009 at 02:28:37PM -0600, Timur Tabi wrote:

> Signed-off-by: Timur Tabi <timur@freescale.com>

Applied, thanks.

> +	ret = snd_soc_register_dai(&cs4270_dai);
>  	if (ret < 0) {
> -		printk(KERN_ERR "cs4270: failed to create PCMs\n");
> +		printk(KERN_ERR "cs4270: failed to register DAIe\n");
>  		goto error_free_codec;
>  	}

Typo (DAIe)?  Ideally you should also use dev_ printk variants where
possible.
