From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Remove -dai suffix from i.MX SSI
	driver
Date: Thu, 30 Sep 2010 22:51:22 +0100
Message-ID: <1285883482.3101.131.camel@odin>
References: <1285879759-15750-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id C928F103998
	for <alsa-devel@alsa-project.org>;
	Thu, 30 Sep 2010 23:51:23 +0200 (CEST)
Received: by wyb42 with SMTP id 42so2402895wyb.38
	for <alsa-devel@alsa-project.org>; Thu, 30 Sep 2010 14:51:23 -0700 (PDT)
In-Reply-To: <1285879759-15750-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Sascha Hauer <kernel@pengutronix.de>, Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

On Thu, 2010-09-30 at 13:49 -0700, Mark Brown wrote:
> While it is a generic serial port in practice the i.MX SSI is only supported
> in Linux as an audio port (the i.MX has dedicated SPI controllers and so on).
> This means we don't need to disambiguate against other uses of the hardware
> and so can drop the -dai suffix from the driver name which fixes merge
> issues with the i.MX tree in -next.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
