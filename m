From: Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: [PATCH] ASoC: fsl_sai: Handle slave mode per TX/RX direction
Date: Wed, 14 Aug 2019 17:19:04 +0300
Message-ID: <CAEnQRZA+G8ZD7JY1b6Bd7wXYzSqnFhye4hEx0zn4ATyTRHJ+uQ@mail.gmail.com>
References: <20190811194517.19314-1-daniel.baluta@nxp.com> <20190814010215.GA13398@Asurada-Nvidia.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190814010215.GA13398@Asurada-Nvidia.nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Daniel Baluta <daniel.baluta@nxp.com>, Mark Brown <broonie@kernel.org>, Fabio Estevam <festevam@gmail.com>, Linux-ALSA <alsa-devel@alsa-project.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, Viorel Suman <viorel.suman@nxp.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 14, 2019 at 4:01 AM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
>
> On Sun, Aug 11, 2019 at 10:45:17PM +0300, Daniel Baluta wrote:
> > From: Viorel Suman <viorel.suman@nxp.com>
> >
> > The SAI interface can be a clock supplier or consumer
> > as a function of stream direction. e.g SAI can be master
> > for Tx and slave for Rx.
> >
> > Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
> > Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> > ---
> >  sound/soc/fsl/fsl_sai.c | 18 +++++++++---------
> >  sound/soc/fsl/fsl_sai.h |  2 +-
> >  2 files changed, 10 insertions(+), 10 deletions(-)
> >
> > diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> > index 4a346fcb5630..69cf3678c859 100644
> > --- a/sound/soc/fsl/fsl_sai.c
> > +++ b/sound/soc/fsl/fsl_sai.c
> > @@ -273,18 +273,18 @@ static int fsl_sai_set_dai_fmt_tr(struct snd_soc_dai *cpu_dai,
>
> This function is called for both TX and RX at the same time from
> fsl_sai_set_dai_fmt() so I don't actually see how it can operate
> in two opposite directions from this change alone. Anything that
> I have missed?

Good catch. I'm missing a patch that updates fmt after the first call
of fsl_sai_set_dai_fmt_tr.
Let me update the patch and resend.
