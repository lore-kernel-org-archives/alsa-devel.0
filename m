From: Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: fsl: sai: Fix clock source for mclk0
Date: Tue, 28 May 2019 15:39:44 +0300
Message-ID: <CAEnQRZD6nNH04xZjpSi7ozL=sNJvJdkEAGAYQStJESeu_2R=Eg@mail.gmail.com>
References: <20190420154038.14576-1-daniel.baluta@nxp.com> <20190421053749.GA5552@Asurada>
 <CAEnQRZDs_gnS8ehjM2M_y+Yw0Ge-Sq=A2c9BV-g=P_d0+O40hQ@mail.gmail.com>
 <20190421080439.GA8784@Asurada> <20190421082627.GB8304@Asurada>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190421082627.GB8304@Asurada>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Daniel Baluta <daniel.baluta@nxp.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "timur@kernel.org" <timur@kernel.org>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "S.j. Wang" <shengjiu.wang@nxp.com>, "tiwai@suse.com" <tiwai@suse.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, dl-linux-imx <linux-imx@nxp.com>, "festevam@gmail.com" <festevam@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Sun, Apr 21, 2019 at 11:26 AM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
>
> On Sun, Apr 21, 2019 at 01:04:39AM -0700, Nicolin Chen wrote:
> > On Sun, Apr 21, 2019 at 10:26:40AM +0300, Daniel Baluta wrote:
> > > > Firstly, according to your commit message, neither imx8qm nor
> > > > imx6sx has an "mclk0" clock in the clock list. Either of them
> > > > starts with "mclk1". So, before you change the driver, I don't
> > > > think it's even a right thing to define an "mclk0" in the DT.
> > >
> > > From what I understand mclk0 means option 00b of MSEL bits which is:
> > > * busclk for i.MX8
> > > * mclk1 for i.MX6/7.
> >
> > MSEL bit is used for an internal clock MUX to select four clock
> > inputs. However,  these four clock inputs aren't exactly 1:1 of
> > SAI's inputs. As fas as I can tell, SAI only has one bus clock
> > and three MCLK[1-3]; the internal clock MUX maps the bus clock
> > or MCLK1 to its input0, and then linearly maps MCLK[1-3] to its
> > inputs[1-3]. So it doesn't sound right to me that you define an
> > "MCLK0" in the DT, as it's supposed to describe input clocks of
> > SAI block, other than its internal clock MUX's.
>
> Daniel, I think I's saying this too confident, though I do feel
> so :) But if you can prove me wrong and justify that there is an
> "MCLK0" as an external input of the SAI block, I will agree with
> this change.

Looking inside the RTL for SAI on i.MX8 I found that there
is a MUX with 4 inputs exactly as RM says:
- bus
- master clock 1
- master clock 2
- master clock 3

My point is that the DT is modelling the internal clock MUX
used for SAI to select its clock source.

thanks,
Daniel.
