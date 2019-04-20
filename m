From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH V4 3/3] ASoC: fsl_asrc: Unify the supported input and
 output rate
Date: Sat, 20 Apr 2019 00:29:53 -0700
Message-ID: <20190420072952.GA10408@Asurada>
References: <AM0PR04MB646884E539AD85971FD255AEE3200@AM0PR04MB6468.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <AM0PR04MB646884E539AD85971FD255AEE3200@AM0PR04MB6468.eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "S.j. Wang" <shengjiu.wang@nxp.com>
Cc: "timur@kernel.org" <timur@kernel.org>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "festevam@gmail.com" <festevam@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Sat, Apr 20, 2019 at 07:23:59AM +0000, S.j. Wang wrote:
> > >       /* Validate input and output sample rates */
> > > -     for (in = 0; in < ARRAY_SIZE(supported_input_rate); in++)
> > > -             if (inrate == supported_input_rate[in])
> > > +     for (in = 0; in < ARRAY_SIZE(supported_asrc_rate); in++)
> > > +             if (inrate == supported_asrc_rate[in])
> > >                       break;
> > 
> > Not sure if we still need it upon having hw_constraint. Maybe m2m needs it?

> Yes.

OK. Then we can leave it there. Thanks
