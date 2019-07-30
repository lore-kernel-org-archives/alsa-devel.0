From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [alsa-devel] [PATCH v2 1/7] ASoC: fsl_sai: Add registers
 definition for multiple datalines
Date: Tue, 30 Jul 2019 00:59:35 -0700
Message-ID: <20190730075934.GA5892@Asurada>
References: <20190728192429.1514-1-daniel.baluta@nxp.com>
 <20190728192429.1514-2-daniel.baluta@nxp.com>
 <20190729194214.GA20594@Asurada-Nvidia.nvidia.com>
 <CAEnQRZDmnAmgUkRGv3V5S7b5EnYTd2BO5NFuME2CfGb1=nAHzQ@mail.gmail.com>
 <20190729202001.GC4787@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190729202001.GC4787@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Daniel Baluta <daniel.baluta@gmail.com>, Daniel Baluta <daniel.baluta@nxp.com>, Devicetree List <devicetree@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Pengutronix Kernel Team <kernel@pengutronix.de>, Timur Tabi <timur@kernel.org>, Rob Herring <robh@kernel.org>, "S.j. Wang" <shengjiu.wang@nxp.com>, "Angus Ainslie (Purism)" <angus@akkea.ca>, Takashi Iwai <tiwai@suse.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, Viorel Suman <viorel.suman@nxp.com>, Fabio Estevam <festevam@gmail.com>, Mihai Serban <mihai.serban@gmail.com>, Lucas Stach <l.stach@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 29, 2019 at 09:20:01PM +0100, Mark Brown wrote:
> On Mon, Jul 29, 2019 at 10:57:43PM +0300, Daniel Baluta wrote:
> > On Mon, Jul 29, 2019 at 10:42 PM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
> > > On Sun, Jul 28, 2019 at 10:24:23PM +0300, Daniel Baluta wrote:
> 
> > > > @@ -704,7 +711,14 @@ static bool fsl_sai_readable_reg(struct device *dev, unsigned int reg)
> > > >       case FSL_SAI_TCR3:
> > > >       case FSL_SAI_TCR4:
> > > >       case FSL_SAI_TCR5:
> > > > -     case FSL_SAI_TFR:
> > > > +     case FSL_SAI_TFR0:
> 
> > > A tricky thing here is that those SAI instances on older SoC don't
> > > support multi data lines physically, while seemly having registers
> > > pre-defined. So your change doesn't sound doing anything wrong to
> > > them at all, I am still wondering if it is necessary to apply them
> > > to newer compatible only though, as for older compatibles of SAI,
> > > these registers would be useless and confusing if being exposed.
> 
> > > What do you think?
> 
> > Yes, I thought about this too. But, I tried to keep the code as short
> > as possible and technically it is not wrong. When 1 data line is supported
> > for example application will only care about TDR0, TFR0, etc.
> 
> So long as it's safe to read the registers (you don't get a bus error or
> anything) I'd say it's more trouble than it's worth to have separate
> regmap configuations just for this.  The main reasons for restricting
> readability are where there's physical problems with doing the reads or
> to keep the size of the debugfs files under control for usability and
> performance reasons.

Thanks for the input, Mark.

Daniel, did you get a chance to test it on older SoCs? At least
nothing breaks like bus errors?
