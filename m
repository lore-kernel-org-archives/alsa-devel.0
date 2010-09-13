From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 1/1] ASoC: Add HP iPAQ H1940 support
Date: Mon, 13 Sep 2010 10:05:43 +0100
Message-ID: <20100913090543.GG16606@rakim.wolfsonmicro.main>
References: <1284288909-5961-1-git-send-email-anarsoul@gmail.com>
	<1284293927-15983-2-git-send-email-anarsoul@gmail.com>
	<AANLkTi=TO4ADGEzeJucHnCDkSELxy_buZRrZPRdcX+Nx@mail.gmail.com>
	<201009122110.00148.anarsoul@gmail.com>
	<AANLkTi=u08V3V70p9Prv5MVfqigFkeYggTAdh5Dx28NK@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 622AA103825
	for <alsa-devel@alsa-project.org>;
	Mon, 13 Sep 2010 11:05:44 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTi=u08V3V70p9Prv5MVfqigFkeYggTAdh5Dx28NK@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: Vasily Khoruzhick <anarsoul@gmail.com>, alsa-devel <alsa-devel@alsa-project.org>, "Arnaud Patard (Rtp)" <arnaud.patard@rtp-net.org>, Ben Dooks <ben-linux@fluff.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 13, 2010 at 10:09:16AM +0900, Jassi Brar wrote:

> Btw, sound/soc/soc-core.c is the real 'soc-audio' driver module not
> the MACHINE driver.
> Turns out, sound/soc/soc-core.c already has the
> MODULE_ALIAS("platform:soc-audio");
> So it seems like an immediate conflict.

Indeed - the MODULE_ALIAS() goes along with the device driver, not with
the registration of the device.
