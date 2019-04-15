From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/2] ASoC: mpc5200_dma: Fix invalid license ID
Date: Mon, 15 Apr 2019 09:33:03 +0200 (CEST)
Message-ID: <alpine.DEB.2.21.1904150931170.4917@nanos.tec.linutronix.de>
References: <20190414191450.18377-1-andradanciu1997@gmail.com> <20190414191450.18377-2-andradanciu1997@gmail.com> <CAOMZO5C_esXni-N-U+hDXNG6Z5rJLC6ZrgKEseCW7mcK=aiyQw@mail.gmail.com> <CAEnQRZBD_M8Pp4RWXY4TS5MHAEBnkwUOyR16ttAitX-L+Z88Ew@mail.gmail.com>
 <CAEnQRZAP6EWXkwfuR+83trtYrpDaRjA6zp-k5sp33bo5jUEjPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAEnQRZAP6EWXkwfuR+83trtYrpDaRjA6zp-k5sp33bo5jUEjPg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Baluta <daniel.baluta@gmail.com>
Cc: Fabio Estevam <festevam@gmail.com>, Andra Danciu <andradanciu1997@gmail.com>, Timur Tabi <timur@kernel.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Sascha Hauer <kernel@pengutronix.de>, NXP Linux Team <linux-imx@nxp.com>, Linux-ALSA <alsa-devel@alsa-project.org>, linuxppc-dev@lists.ozlabs.org, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 15 Apr 2019, Daniel Baluta wrote:
> On Mon, Apr 15, 2019 at 10:26 AM Daniel Baluta <daniel.baluta@gmail.com> wrote:
> > On Mon, Apr 15, 2019 at 12:53 AM Fabio Estevam <festevam@gmail.com> wrote:
> > > On Sun, Apr 14, 2019 at 4:15 PM Andra Danciu <andradanciu1997@gmail.com> wrote:
> > > > -// SPDX-License-Identifier: GPL
> > > > +// SPDX-License-Identifier: GPL-2.0-only
> > >
> > > According to Documentation/process/license-rules.rst this should be:
> > >
> > > // SPDX-License-Identifier: GPL-2.0
> >
> 
> Actually, according to
> 
> https://spdx.org/licenses/GPL-2.0-only.html
> 
> GPL-2.0 is another name for GPL-2.0-only

See also: LICENSES/preferred/GPL-2.0

    Valid-License-Identifier: GPL-2.0
    Valid-License-Identifier: GPL-2.0-only

If the identifier would be invalid, scripts/spdxcheck.py would complain ...

Thanks,

	tglx
