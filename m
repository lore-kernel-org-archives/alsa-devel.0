From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH RFC 1/3] ASoC: uda1380: use callbacks
	instead of gpiolib
Date: Mon, 28 Jun 2010 14:41:45 +0100
Message-ID: <20100628134145.GA7403@rakim.wolfsonmicro.main>
References: <1277565285-11563-1-git-send-email-anarsoul@gmail.com>
	<201006262353.58897.anarsoul@gmail.com>
	<8308AEB2-F7DB-4C48-AAED-719311AF7A42@opensource.wolfsonmicro.com>
	<201006281500.21327.anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 50A852448A
	for <alsa-devel@alsa-project.org>;
	Mon, 28 Jun 2010 15:41:48 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <201006281500.21327.anarsoul@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Vasily Khoruzhick <anarsoul@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Philipp Zabel <philipp.zabel@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 28, 2010 at 03:00:13PM +0300, Vasily Khoruzhick wrote:

> Actually, power on sequence on rx1950 (and on magician) looks like following:

> 1. set power pin to 1

Is this a feature of the chip or an external power control?
