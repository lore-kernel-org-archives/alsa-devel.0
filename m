From: Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: [alsa-devel] [PATCH 01/10] ASoC: fsl_sai: add of_match data
Date: Wed, 24 Jul 2019 09:42:33 +0300
Message-ID: <CAEnQRZC_mNnwYkpdiX2d_ccT_L-hivWdxQTMEUojjDWv+NCiQg@mail.gmail.com>
References: <20190722124833.28757-1-daniel.baluta@nxp.com> <20190722124833.28757-2-daniel.baluta@nxp.com>
 <20190723170035.GO5365@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190723170035.GO5365@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Daniel Baluta <daniel.baluta@nxp.com>, Linux-ALSA <alsa-devel@alsa-project.org>, Viorel Suman <viorel.suman@nxp.com>, Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>, linuxppc-dev@lists.ozlabs.org, "S.j. Wang" <shengjiu.wang@nxp.com>, "Angus Ainslie (Purism)" <angus@akkea.ca>, Takashi Iwai <tiwai@suse.com>, Nicolin Chen <nicoleotsuka@gmail.com>, dl-linux-imx <linux-imx@nxp.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Lucas Stach <l.stach@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 23, 2019 at 8:01 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Mon, Jul 22, 2019 at 03:48:24PM +0300, Daniel Baluta wrote:
> > From: Lucas Stach <l.stach@pengutronix.de>
> >
> > New revisions of the SAI IP block have even more differences that need
> > be taken into account by the driver. To avoid sprinking compatible
> > checks all over the driver move the current differences into of_match_data.
> >
> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > ---
> >  sound/soc/fsl/fsl_sai.c | 22 ++++++++++++++--------
>
> You need to supply your own signoff if you're sending someone else's
> patch - see submitting-patches.rst for details on what signoffs mean and
> why they're required.

Ack. Sorry for missing this.
