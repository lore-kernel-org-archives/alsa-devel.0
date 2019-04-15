From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/2] ASoC: mpc5200_dma: Fix invalid license ID
Date: Mon, 15 Apr 2019 09:23:39 +0200 (CEST)
Message-ID: <alpine.DEB.2.21.1904150923280.4917@nanos.tec.linutronix.de>
References: <20190414191450.18377-1-andradanciu1997@gmail.com> <20190414191450.18377-2-andradanciu1997@gmail.com> <CAOMZO5C_esXni-N-U+hDXNG6Z5rJLC6ZrgKEseCW7mcK=aiyQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAOMZO5C_esXni-N-U+hDXNG6Z5rJLC6ZrgKEseCW7mcK=aiyQw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Andra Danciu <andradanciu1997@gmail.com>, Timur Tabi <timur@kernel.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Sascha Hauer <kernel@pengutronix.de>, NXP Linux Team <linux-imx@nxp.com>, Linux-ALSA <alsa-devel@alsa-project.org>, linuxppc-dev@lists.ozlabs.org, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, Daniel Baluta <daniel.baluta@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Sun, 14 Apr 2019, Fabio Estevam wrote:

> On Sun, Apr 14, 2019 at 4:15 PM Andra Danciu <andradanciu1997@gmail.com> wrote:
> >
> > As the file had no other license notice/reference, it falls under the
> > project license and therefore the proper SPDX id is: GPL-2.0-only
> >
> > Cc: Daniel Baluta <daniel.baluta@nxp.com>
> > Fixes: 1edfc2485d8dc ("ASoC: mpc5200_dma: Switch to SPDX identifier")
> > Reported-by: Thomas Gleixner <tglx@linutronix.de>
> > Signed-off-by: Andra Danciu <andradanciu1997@gmail.com>
> > ---
> >  sound/soc/fsl/mpc5200_dma.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/sound/soc/fsl/mpc5200_dma.c b/sound/soc/fsl/mpc5200_dma.c
> > index 4396442c2fdd..ccf9301889fe 100644
> > --- a/sound/soc/fsl/mpc5200_dma.c
> > +++ b/sound/soc/fsl/mpc5200_dma.c
> > @@ -1,4 +1,4 @@
> > -// SPDX-License-Identifier: GPL
> > +// SPDX-License-Identifier: GPL-2.0-only
> 
> According to Documentation/process/license-rules.rst this should be:
> 
> // SPDX-License-Identifier: GPL-2.0

Both are valid.
