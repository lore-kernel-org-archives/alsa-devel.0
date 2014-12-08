From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [alsa-devel][PATCH v3] ASoC: wm8960: Let wm8960 codec driver
	manage its own MCLK
Date: Mon, 8 Dec 2014 11:57:17 +0000
Message-ID: <20141208115717.GF14516@opensource.wolfsonmicro.com>
References: <1417696879-15402-1-git-send-email-b50113@freescale.com> <20141205170156.GB14516@opensource.wolfsonmicro.com> <20141205173932.GN11764@sirena.org.uk> <BN3PR0301MB12511B448B1C0B9E8F0BB6C48D640@BN3PR0301MB1251.namprd03.prod.outlook.com> <20141208111445.GT11764@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20141208111445.GT11764@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Zidan Wang <B50113@freescale.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.de" <tiwai@suse.de>, "lars@metafoo.de" <lars@metafoo.de>, "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 08, 2014 at 11:14:45AM +0000, Mark Brown wrote:
> On Mon, Dec 08, 2014 at 09:49:51AM +0000, Zidan Wang wrote:
> > So I should move mclk to wm8960_priv. 
> > And doing wm8960_priv->mclk = devm_clk_get(&i2c->dev, "codec_mclk") in wm8960_i2c_probe.
> 
> Yes, please.

Apologies I totally misread you last email.

Thanks,
Charles
