From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: RE: [PATCH 2/3] ASoC: core: Set the default I/O up try regmap.
Date: Fri, 28 Feb 2014 04:00:38 +0000
Message-ID: <c405df11848a40b7beda8d8fe747e7a7@BY2PR03MB505.namprd03.prod.outlook.com>
References: <1393494593-26310-1-git-send-email-Li.Xiubo@freescale.com>
 <1393494593-26310-3-git-send-email-Li.Xiubo@freescale.com>
 <20140228035244.GJ9383@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140228035244.GJ9383@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org


> Subject: Re: [PATCH 2/3] ASoC: core: Set the default I/O up try regmap.
> 
> On Thu, Feb 27, 2014 at 05:49:52PM +0800, Xiubo Li wrote:
> > For most CODEC drivers which the REGMAP is used, the soc_probe_codec()
> > will do the stuff work of snd_soc_codec_set_cache_io(), which the CODEC
> > drivers' ASoC probe will do too, and almost at the same time.
> 
> Applied, thanks.  I did a check of the drivers and it looks like they'll
> all be fine with this.

Yes.

I'll send another patches to applied to use this for another CODEC drivers.
And there almost 80 files, Should I send them in one patch or split them into
individual patch for each CODEC driver ?

Thanks,

--
Best Regards,
Xiubo
