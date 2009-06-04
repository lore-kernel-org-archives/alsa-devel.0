From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Fix possibly incorrect offset in
	wm97xx-core
Date: Thu, 4 Jun 2009 09:46:03 +0100
Message-ID: <20090604084602.GA6983@rakim.wolfsonmicro.main>
References: <200906032344.37640.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 610E210380B
	for <alsa-devel@alsa-project.org>;
	Thu,  4 Jun 2009 10:46:04 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200906032344.37640.marek.vasut@gmail.com>
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
Cc: Eric Miao <eric.y.miao@gmail.com>, alsa-devel@alsa-project.org, Russell King - ARM Linux <linux@arm.linux.org.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 03, 2009 at 11:44:37PM +0200, Marek Vasut wrote:

> -               if (wm->id == WM9712_ID2)
> -                       wm97xx_reg_write(wm, AC97_GPIO_STATUS, (status &
> -                                               ~WM97XX_GPIO_13) << 1);
> -               else
> -                       wm97xx_reg_write(wm, AC97_GPIO_STATUS, status &
> +               wm97xx_reg_write(wm, AC97_GPIO_STATUS, status &
>                                                 ~WM97XX_GPIO_13);

Nack, the existing code reflects the behaviour of the silicon.
