From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/3] ASoC: Samsung: Debug PCM
 snd_soc_dai_driver registration
Date: Mon, 13 Sep 2010 09:53:13 +0100
Message-ID: <20100913085313.GD16606@rakim.wolfsonmicro.main>
References: <1284104465-17287-1-git-send-email-jassisinghbrar@gmail.com>
	<20100910095438.GD3068@rakim.wolfsonmicro.main>
	<AANLkTimajKCsDLPuGRoO=339BpUQ_wXn8pDsC+7ErzET@mail.gmail.com>
	<20100910114754.GJ7259@rakim.wolfsonmicro.main>
	<AANLkTinrn=RPk5tktyXrdQ_KokkSYT6g+xYL_ZKiGkW=@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 12858245EA
	for <alsa-devel@alsa-project.org>;
	Mon, 13 Sep 2010 10:53:15 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTinrn=RPk5tktyXrdQ_KokkSYT6g+xYL_ZKiGkW=@mail.gmail.com>
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
Cc: alsa-devel@alsa-project.org, sw.youn@samsung.com, Jassi Brar <jassi.brar@samsung.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 13, 2010 at 10:34:30AM +0900, Jassi Brar wrote:

> ok, but I don't seem to be able to find out where
> snd_soc_dai_driver.id is being used

Meh, actually it's ignored in the driver and concocted from the device.
The id field should just go from the driver structure, sorry.

> and  sound/soc/sh/hac.c and sound/soc/atmel/atmel_ssc_dai.c seems to
> be doing similar
> Are we on the same page? Please help me understand it.

Neither of these platforms are especially good to use as references -
for multi-component Liam was working mostly with OMAP.
