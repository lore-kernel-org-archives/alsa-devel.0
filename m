From: gabrielcsmo@gmail.com
Subject: Re: [PATCH -next] ASoC: fsl_micfil: Remove set but not used
 variable 'osr'
Date: Wed, 17 Apr 2019 21:58:37 +0300
Message-ID: <3228ff50862b0bad95561bd5276cbfcad5d6213c.camel@gmail.com>
References: <20190417150915.37968-1-yuehaibing@huawei.com>
         <CAEnQRZAug2kQoFTN6W47URBKwHcU5Zmmy=04smOtMomuzz6_TA@mail.gmail.com>
         <20190417183518.GA5073@Asurada-Nvidia.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190417183518.GA5073@Asurada-Nvidia.nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolin Chen <nicoleotsuka@gmail.com>, Daniel Baluta <daniel.baluta@gmail.com>
Cc: Yue Haibing <yuehaibing@huawei.com>, Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org, Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 2019-04-17 at 11:35 -0700, Nicolin Chen wrote:
> On Wed, Apr 17, 2019 at 06:25:11PM +0300, Daniel Baluta wrote:
> 
> > Looks good to me. Just one question for Cosmin:
> > > diff --git a/sound/soc/fsl/fsl_micfil.c
> > > b/sound/soc/fsl/fsl_micfil.c
> > > index 40c07e7..f7f2d29 100644
> > > --- a/sound/soc/fsl/fsl_micfil.c
> > > +++ b/sound/soc/fsl/fsl_micfil.c
> > > @@ -151,12 +151,9 @@ static inline int get_clk_div(struct
> > > fsl_micfil *micfil,
> > >  {
> > >         u32 ctrl2_reg;
> > >         long mclk_rate;
> > > -       int osr;
> > >         int clk_div;
> > > 
> > >         regmap_read(micfil->regmap, REG_MICFIL_CTRL2,
> > > &ctrl2_reg);
> > 
> > I noticed now that we also read ctrl2_reg without using it. Is this
> > as intended?
> 
> For Cosmin,
> 
> Same question here.
> 
> Btw, I just noticed that the initial patch of adding this driver
> did not seemly include most of FSL maintainers/reviewers. Please
> run get_maintainer.pl to add all listed reviewers when sending a
> change to the maillist.
> 
> Thanks
> Nicolin

Hello,

The regmap_read is not used anymore in this implementation and I've
forgot to remove it - it can be safetly removed.

Nicolin, I am pretty sure I've ran the get_maintainer.pl script but
I will pay more attention next time... sorry if I forgot to add you.

Best regards,
Cosmin
