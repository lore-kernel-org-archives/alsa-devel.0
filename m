From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: i.MX audio support
Date: Thu, 19 Nov 2009 18:47:55 +0100
Message-ID: <20091119174755.GU30179@pengutronix.de>
References: <1258645706-9071-1-git-send-email-s.hauer@pengutronix.de>
	<20091119163241.GB31336@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fmmailgate02.web.de (fmmailgate02.web.de [217.72.192.227])
	by alsa0.perex.cz (Postfix) with ESMTP id 13674103804
	for <alsa-devel@alsa-project.org>; Thu, 19 Nov 2009 18:48:58 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20091119163241.GB31336@rakim.wolfsonmicro.main>
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
Cc: alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 19, 2009 at 04:32:41PM +0000, Mark Brown wrote:
> On Thu, Nov 19, 2009 at 04:48:14PM +0100, Sascha Hauer wrote:
> 
> > There already is a driver for i.MX in the tree, this one is a nearly complete
> > rewrite. I haven't touched the in Kernel driver with these patches. The in
> > Kernel driver has several problems, it doesn't use ioremap, uses direct pointer
> > derefs instead of proper access functions and the only board supported so far is
> > itself not supported in mainline.
> 
> BTW, unless I notice anything particularly bad in there I'm inclined to
> just merge all the arch/arm patches by themselves since obviously you're
> the maintainer they'd normally go via - I'm assuming the other patches
> depend on them?

I'd prefer merging the arm patches myself as I'm afraid of bothering
upstream upstream with merge conflicts. I think I can rebase this series
in a way that there won't be compile breakages during merge.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
