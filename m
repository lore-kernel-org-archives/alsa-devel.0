From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH RFC 1/3] ASoC: uda1380: use callbacks
	instead of gpiolib
Date: Mon, 28 Jun 2010 15:32:57 +0100
Message-ID: <20100628143257.GE7403@rakim.wolfsonmicro.main>
References: <1277565285-11563-1-git-send-email-anarsoul@gmail.com>
	<201006281649.39572.anarsoul@gmail.com>
	<20100628135046.GB7403@rakim.wolfsonmicro.main>
	<201006281705.57779.anarsoul@gmail.com>
	<AANLkTilfEIEBaHO8FupS9wU3FR3VGc_yUVNP8KPJ30jW@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7CD1E2447A
	for <alsa-devel@alsa-project.org>;
	Mon, 28 Jun 2010 16:32:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTilfEIEBaHO8FupS9wU3FR3VGc_yUVNP8KPJ30jW@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: pHilipp Zabel <philipp.zabel@gmail.com>
Cc: Vasily Khoruzhick <anarsoul@gmail.com>, alsa-devel <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 28, 2010 at 04:20:43PM +0200, pHilipp Zabel wrote:

> The reset GPIO is connected directly to the UDA1380 RESET pin. The
> power source is external.

OK, the power source is definitely a regulator then.
