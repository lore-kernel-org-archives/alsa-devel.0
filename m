From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: Re: [PATCH] ASoC: io: Clean up
	snd_soc_codec_set_cache_io()
Date: Thu, 27 Feb 2014 10:18:03 +0000
Message-ID: <8475b38a0b7c48188bb81bd085245c93@BY2PR03MB505.namprd03.prod.outlook.com>
References: <1393465065-9512-1-git-send-email-Li.Xiubo@freescale.com>
 <20140227041140.GC9383@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0210.outbound.protection.outlook.com [207.46.163.210])
 by alsa0.perex.cz (Postfix) with ESMTP id 30415265833
 for <alsa-devel@alsa-project.org>; Thu, 27 Feb 2014 11:18:20 +0100 (CET)
In-Reply-To: <20140227041140.GC9383@sirena.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>, "abrestic@chromium.org" <abrestic@chromium.org>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "timur@tabi.org" <timur@tabi.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "peter.ujfalusi@ti.com" <peter.ujfalusi@ti.com>, "mr.swami.reddy@ti.com" <mr.swami.reddy@ti.com>, "voice.shen@atmel.com" <voice.shen@atmel.com>, "mike.dyer@md-soft.co.uk" <mike.dyer@md-soft.co.uk>, "bardliao@realtek.com" <bardliao@realtek.com>, "mahaijuns@gmail.com" <mahaijuns@gmail.com>, "s.trumtrar@pengutronix.de" <s.trumtrar@pengutronix.de>, "rf@opensource.wolfsonmicro.com" <rf@opensource.wolfsonmicro.com>, "LW@KARO-electronics.de" <LW@KARO-electronics.de>, "swarren@nvidia.com" <swarren@nvidia.com>, "shc_work@mail.ru" <shc_work@mail.ru>
List-Id: alsa-devel@alsa-project.org

> Subject: Re: [PATCH] ASoC: io: Clean up snd_soc_codec_set_cache_io()
> 
> On Thu, Feb 27, 2014 at 09:37:45AM +0800, Xiubo Li wrote:
> 
> > I'm also thinking could we just discard snd_soc_codec_set_cache_io()
> > calling from each individual driver to simply the code? And just bind
> > it to devm_regmap_init_i2c() and devm_regmap_init_spi()...
> 
> > Is there any other limitations for snd_soc_codec_set_cache_io() usage?
> 
> That's the goal overall, I'm not sure it's worth going through and
> changing the signature of the function and then later going through and
> merging it, it's just too much churn.  The main thing we need to do in
> order to do that is to make sure nothing is relying on specific
> sequencing during startup, probably by providing a way to manually set
> the regmap pointer in the main device probe function rather than in the
> ASoC one.

Yes, that's also what I'm thinking about.

And for most CODEC drivers which the REGMAP is used, the soc_probe_codec()
will do the stuff work of snd_soc_codec_set_cache_io(), which the CODEC's 
ASoC probe will do too, and almost at the same time.

Then the CODEC drivers stuff work of this is redundant, so we could just
discard the snd_soc_codec_set_cache_io() for the CODEC drivers to simplify
the code.

I'll send one RFC patch of this, and please ignore this patch.

Thanks,

--
Best Regards,
Xiubo 
