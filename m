From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH 2/2] ASoC: fsl: Move clock operation to PM runtime
Date: Mon, 22 Apr 2019 11:15:40 -0700
Message-ID: <20190422181539.GA30867@Asurada-Nvidia.nvidia.com>
References: <20190420155846.10027-1-daniel.baluta@nxp.com>
 <20190420155846.10027-3-daniel.baluta@nxp.com>
 <20190421055406.GC683@Asurada-Nvidia.nvidia.com>
 <1555930942.31656.4.camel@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1555930942.31656.4.camel@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viorel Suman <viorel.suman@nxp.com>
Cc: Daniel Baluta <daniel.baluta@nxp.com>, dl-linux-imx <linux-imx@nxp.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "timur@kernel.org" <timur@kernel.org>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "festevam@gmail.com" <festevam@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "tiwai@suse.com" <tiwai@suse.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "S.j. Wang" <shengjiu.wang@nxp.com>, "perex@perex.cz" <perex@perex.cz>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 22, 2019 at 11:02:22AM +0000, Viorel Suman wrote:
> Hi Nicolin,
> 
> On Sb, 2019-04-20 at 22:54 -0700, Nicolin Chen wrote:
> > On Sat, Apr 20, 2019 at 03:59:05PM +0000, Daniel Baluta wrote:
> > > 
> > > Turn off/on clocks when device enters suspend/resume. This
> > > helps saving power.
> > > 
> > > @@ -934,6 +933,25 @@ static int fsl_sai_runtime_suspend(struct device *dev)
> > >  static int fsl_sai_runtime_resume(struct device *dev)
> > >  {
> > >  	struct fsl_sai *sai = dev_get_drvdata(dev);
> > > +	int ret;
> > > +
> > > +	ret = clk_prepare_enable(sai->bus_clk);
> > > +	if (ret) {
> > > +		dev_err(dev, "failed to enable bus clock: %d\n", ret);
> > > +		return ret;
> > > +	}
> > > +
> > > +	if (sai->mclk_streams & BIT(SNDRV_PCM_STREAM_PLAYBACK)) {
> > > +		ret = clk_prepare_enable(sai->mclk_clk[sai->mclk_id[1]]);
> > > +		if (ret)
> > > +			goto disable_bus_clk;
> > > +	}
> > > +
> > > +	if (sai->mclk_streams & BIT(SNDRV_PCM_STREAM_CAPTURE)) {
> > > +		ret = clk_prepare_enable(sai->mclk_clk[sai->mclk_id[0]]);
> > > +		if (ret)
> > > +			goto disable_tx_clk;
> > > +	}
> > The driver only enables mclk_clks for I2S master mode. But this
> > change enables them for I2S slave mode also. It doesn't sound a
> > right thing to me since we are supposed to save power?
> 
> This change does not enable them for I2S slave mode, please check "fsl_sai_hw_params"
> and "fsl_sai_hw_free" functions: the field "sai->mclk_streams" is modified only for
> the case when "if (!sai->is_slave_mode)";

Thanks for the input. This should be fine then.

Nicolin
