From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: fsl: sai: Fix clock source for mclk0
Date: Sun, 21 Apr 2019 01:04:40 -0700
Message-ID: <20190421080439.GA8784@Asurada>
References: <20190420154038.14576-1-daniel.baluta@nxp.com>
 <20190421053749.GA5552@Asurada>
 <CAEnQRZDs_gnS8ehjM2M_y+Yw0Ge-Sq=A2c9BV-g=P_d0+O40hQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAEnQRZDs_gnS8ehjM2M_y+Yw0Ge-Sq=A2c9BV-g=P_d0+O40hQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Baluta <daniel.baluta@gmail.com>
Cc: Daniel Baluta <daniel.baluta@nxp.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "timur@kernel.org" <timur@kernel.org>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "S.j. Wang" <shengjiu.wang@nxp.com>, "tiwai@suse.com" <tiwai@suse.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, dl-linux-imx <linux-imx@nxp.com>, "festevam@gmail.com" <festevam@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Sun, Apr 21, 2019 at 10:26:40AM +0300, Daniel Baluta wrote:
> > Firstly, according to your commit message, neither imx8qm nor
> > imx6sx has an "mclk0" clock in the clock list. Either of them
> > starts with "mclk1". So, before you change the driver, I don't
> > think it's even a right thing to define an "mclk0" in the DT.
> 
> From what I understand mclk0 means option 00b of MSEL bits which is:
> * busclk for i.MX8
> * mclk1 for i.MX6/7.

MSEL bit is used for an internal clock MUX to select four clock
inputs. However,  these four clock inputs aren't exactly 1:1 of
SAI's inputs. As fas as I can tell, SAI only has one bus clock
and three MCLK[1-3]; the internal clock MUX maps the bus clock
or MCLK1 to its input0, and then linearly maps MCLK[1-3] to its
inputs[1-3]. So it doesn't sound right to me that you define an
"MCLK0" in the DT, as it's supposed to describe input clocks of
SAI block, other than its internal clock MUX's.

> Adding a mclk0 in the DT and making it point to the correct option
> (busclk or mclk1) does no harm as the driver doesn't yet parse mclk0.

I know it's making driver easier, but unfortunately it's not a
right thing to do from my point of view.

> >
> > >               sai->mclk_clk[i] = devm_clk_get(&pdev->dev, tmp);
> > >               if (IS_ERR(sai->mclk_clk[i])) {
> >
> > Secondly, this would break existing DT bindings of imx6sx and
> > imx7 platforms as they both have clock-names defined in DTB:
> >         clock-names = "bus", "mclk1", "mclk2", "mclk3";
> > Since there's no "mclk0", the entire probe() would error-out.
> 
> Not exactly. The probe won't error-out. It will just print a warning message

You're right about this part. I didn't look further as the patch
ends at the IS_ERR, so made a wrong assumption. Sorry.

> In my opinion, the current implementation of fsl_sai has a bug for imx6/7.
> 
> Currently, fsl_sai.c driver does:
> 
>        sai->mclk_clk[0] = sai->bus_clk;
> 
> is wrong, because on imx6/7 mclk_clk[0] should point to the same clk
> as mclk_clk[1]

You are right. It should be fixed, but not by this approach IMHO.

Thanks
