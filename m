From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: i.MX audio support
Date: Thu, 19 Nov 2009 16:32:41 +0000
Message-ID: <20091119163241.GB31336@rakim.wolfsonmicro.main>
References: <1258645706-9071-1-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E4716103812
	for <alsa-devel@alsa-project.org>; Thu, 19 Nov 2009 17:32:42 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1258645706-9071-1-git-send-email-s.hauer@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 19, 2009 at 04:48:14PM +0100, Sascha Hauer wrote:

> There already is a driver for i.MX in the tree, this one is a nearly complete
> rewrite. I haven't touched the in Kernel driver with these patches. The in
> Kernel driver has several problems, it doesn't use ioremap, uses direct pointer
> derefs instead of proper access functions and the only board supported so far is
> itself not supported in mainline.

BTW, unless I notice anything particularly bad in there I'm inclined to
just merge all the arch/arm patches by themselves since obviously you're
the maintainer they'd normally go via - I'm assuming the other patches
depend on them?

Thanks a lot for doing this work - I've got some boards that I could
make a lot of use of if we had i.MX3x audio support in mainline!
