From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH] Fix possibly incorrect offset in
	wm97xx-core
Date: Thu, 4 Jun 2009 11:59:02 +0200
Message-ID: <200906041159.02380.marek.vasut@gmail.com>
References: <200906032344.37640.marek.vasut@gmail.com>
	<20090604084602.GA6983@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f215.google.com (mail-bw0-f215.google.com
	[209.85.218.215])
	by alsa0.perex.cz (Postfix) with ESMTP id AA77A103911
	for <alsa-devel@alsa-project.org>;
	Thu,  4 Jun 2009 11:59:03 +0200 (CEST)
Received: by bwz11 with SMTP id 11so612287bwz.32
	for <alsa-devel@alsa-project.org>; Thu, 04 Jun 2009 02:59:02 -0700 (PDT)
In-Reply-To: <20090604084602.GA6983@rakim.wolfsonmicro.main>
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
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Eric Miao <eric.y.miao@gmail.com>, alsa-devel@alsa-project.org, Russell King - ARM Linux <linux@arm.linux.org.uk>
List-Id: alsa-devel@alsa-project.org

On Thursday 04 of June 2009 10:46:03 Mark Brown wrote:
> On Wed, Jun 03, 2009 at 11:44:37PM +0200, Marek Vasut wrote:
> > -               if (wm->id == WM9712_ID2)
> > -                       wm97xx_reg_write(wm, AC97_GPIO_STATUS, (status &
> > -                                               ~WM97XX_GPIO_13) << 1);
> > -               else
> > -                       wm97xx_reg_write(wm, AC97_GPIO_STATUS, status &
> > +               wm97xx_reg_write(wm, AC97_GPIO_STATUS, status &
> >                                                 ~WM97XX_GPIO_13);
>
> Nack, the existing code reflects the behaviour of the silicon.

The patch above reflects the behavior of my silicon (WM9712G) :-/
