From: Zidan Wang <B50113@freescale.com>
Subject: RE: [alsa-devel][PATCH v3] ASoC: wm8960: Let wm8960 codec driver
 manage its own MCLK
Date: Mon, 8 Dec 2014 09:49:51 +0000
Message-ID: <BN3PR0301MB12511B448B1C0B9E8F0BB6C48D640@BN3PR0301MB1251.namprd03.prod.outlook.com>
References: <1417696879-15402-1-git-send-email-b50113@freescale.com>
 <20141205170156.GB14516@opensource.wolfsonmicro.com>
 <20141205173932.GN11764@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20141205173932.GN11764@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.de" <tiwai@suse.de>, "lars@metafoo.de" <lars@metafoo.de>, "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

So I should move mclk to wm8960_priv. 
And doing wm8960_priv->mclk = devm_clk_get(&i2c->dev, "codec_mclk") in wm8960_i2c_probe.

Best Regards,
Zidan

-----Original Message-----
From: Mark Brown [mailto:broonie@kernel.org] 
Sent: Saturday, December 06, 2014 1:40 AM
To: Charles Keepax
Cc: Wang Zidan-B50113; lgirdwood@gmail.com; perex@perex.cz; tiwai@suse.de; lars@metafoo.de; Xiubo Li-B47053; patches@opensource.wolfsonmicro.com; alsa-devel@alsa-project.org; linux-kernel@vger.kernel.org
Subject: Re: [alsa-devel][PATCH v3] ASoC: wm8960: Let wm8960 codec driver manage its own MCLK

On Fri, Dec 05, 2014 at 05:01:56PM +0000, Charles Keepax wrote:
> On Thu, Dec 04, 2014 at 08:41:19PM +0800, Zidan Wang wrote:

> >  struct wm8960_data {
> > +	struct clk *mclk;

> Is this really pdata? Would the pdata entry to locate the clock not be 
> a string holding the clock name that you call clk_get on, rather than 
> a clk pointer itself? Probably this should go in wm8960_priv instead.

There should be no platform data of any kind for the clock, the name should be fixed and defined in terms of the name of the clock on the device requesting it.  The code is actually doing the right thing here, it's just that it's put the variable into the platform data because currently the driver just uses the platform data as the driver data.
