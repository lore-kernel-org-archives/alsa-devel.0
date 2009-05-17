From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: AC97 reset fail after suspend
Date: Mon, 18 May 2009 00:32:55 +0200
Message-ID: <200905180032.55410.marek.vasut@gmail.com>
References: <200905080148.20137.sleep_walker@suse.cz>
	<guq279$iv5$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f170.google.com (mail-fx0-f170.google.com
	[209.85.220.170])
	by alsa0.perex.cz (Postfix) with ESMTP id 39E7624628
	for <alsa-devel@alsa-project.org>;
	Mon, 18 May 2009 00:32:52 +0200 (CEST)
Received: by fxm18 with SMTP id 18so3132306fxm.32
	for <alsa-devel@alsa-project.org>; Sun, 17 May 2009 15:32:51 -0700 (PDT)
In-Reply-To: <guq279$iv5$1@ger.gmane.org>
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
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Monday 18 of May 2009 00:14:01 Dmitry Eremin-Solenikov wrote:
> Tomas 'Sleep_Walker' Cech wrote:
> > Hi,
> >
> > I've got following error on Palm LifeDrive and PalmTX after suspend &
> > resume:
> >
> > pxa2xx_ac97_try_warm_reset: warm reset timeout (GSR=0x0)
> > pxa2xx_ac97_read: read error (ac97_reg=0 GSR=0x0)
> > pxa2xx_ac97_try_cold_reset: cold reset timeout (GSR=0x44)
> > pxa2xx_ac97_read: read error (ac97_reg=0 GSR=0x44) WM9712 AC97 reset
> > failed
> > could not reset AC97 codec
>
> Could you please check if changing reset_gpio to 113 inside
> palmXX_ac97_pdata declarations in palmld and palmtx board files helps.

No it doesn't, nRESET is on GPIO95, it's verified by hardware probing. See 
previous mails in this thread for the reason of these problems.
